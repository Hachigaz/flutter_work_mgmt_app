import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_work_mgmt_app/data/models/notifications.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part "backend_socket_event.dart";
part "backend_socket_state.dart";
part "../models/models.dart";

const _socketConnectionTimeout = 5;
const _socketCallbackInterval = 2;

class BackendSocketBloc extends Bloc<BackendSocketEvent, BackendSocketState> {
  BackendSocketBloc() : super(BackendSocketStateInitial()) {
    on<BackendSocketEventInit>(_onInitBloc);
    on<BackendSocketEventServerConnectCall>(_onCallServerConnect);
    on<BackendSocketEventMessageReceived>(
      _onReceiveMessage,
      transformer: sequential(),
    );
    on<BackendSocketEventSendingPing>(_onSendingPing);
    on<BackendSocketEventConnectionTimedOutCheck>(_onConnectionTimedOutCheck);
    add(BackendSocketEventInit());
  }

  Future<void> _onInitBloc(
    BackendSocketEventInit event,
    Emitter<BackendSocketState> emit,
  ) async {
    add(BackendSocketEventServerConnectCall());
  }

  FutureOr<void> _onCallServerConnect(
    BackendSocketEventServerConnectCall event,
    Emitter<BackendSocketState> emit,
  ) async {
    try {
      //goes into connecting state
      emit(BackendSocketStateConnecting());

      bool isConnectionTimedOut = false;
      final channel = IOWebSocketChannel.connect(
        Uri.parse(dotenv.env["WS_URL"]!),
        protocols: [dotenv.env["SERVER_SOCKET_PROTOCOL"]!],
        headers: <String, dynamic>{},
      );
      await channel.ready.timeout(
        Duration(seconds: _socketConnectionTimeout),
        onTimeout: () {
          isConnectionTimedOut = true;
        },
      );

      //if timed out then emit error state and return
      if (isConnectionTimedOut) {
        throw WebSocketChannelException("Connection Timed Out");
      }

      //if ready then continue
      //add ping callback between interval
      final timer = Timer.periodic(Duration(seconds: _socketCallbackInterval), (
        _,
      ) {
        if (state is BackendSocketStateReadyBase) {
          final state = this.state as BackendSocketStateReadyBase;

          if (!state.isPendingPing) {
            print("Pinging server");
            add(BackendSocketEventSendingPing());
            final timer = Timer(
              Duration(seconds: _socketConnectionTimeout),
              () {
                print("Ping timeout check");
                add(BackendSocketEventConnectionTimedOutCheck());
              },
            );
          }
        }
      });

      // listener on prehandling received data
      final socketListener = channel.stream.listen((data) {
        //assume data is string type
        print("received $data");
        if (data != null) {
          if (state is BackendSocketStateReadyBase) {
            final message = BackendSocketMessage.fromJson(jsonDecode(data));
            final state = this.state as BackendSocketStateReadyBase;
            add(BackendSocketEventMessageReceived(message: message));
          }
        }
      });

      print("Socket bloc is ready");

      //emit ready state
      emit(
        BackendSocketStateReady(
          timer: timer,
          channel: channel,
          socketListener: socketListener,
          currentMessage: null,
          isPendingPing: false,
        ),
      );
    } on WebSocketChannelException catch (error) {
      print(error.message);
    }
  }

  FutureOr<void> _onReceiveMessage(
    BackendSocketEventMessageReceived event,
    Emitter<BackendSocketState> emit,
  ) {
    if (state is BackendSocketStateReadyBase) {
      final state = this.state as BackendSocketStateReadyBase;
      emit(
        BackendSocketStateIncomingMessage(
          timer: state.timer,
          channel: state.channel,
          socketListener: state.socketListener,
          currentMessage: event.message,
          isPendingPing: state.isPendingPing,
        ),
      );
    }
  }

  FutureOr<void> _onConnectionTimedOutCheck(
    BackendSocketEventConnectionTimedOutCheck event,
    Emitter<BackendSocketState> emit,
  ) {
    if (state is BackendSocketStateReadyBase) {
      final state = this.state as BackendSocketStateReadyBase;
      if (state.isPendingPing) {
        state.socketListener.cancel();
        state.timer.cancel();
        print("Connection timed out");
        emit(
          BackendSocketStateConnectionTimedOut(
            timer: state.timer,
            channel: state.channel,
            socketListener: state.socketListener,
            currentMessage: state.currentMessage,
            isPendingPing: state.isPendingPing,
          ),
        );
        add(BackendSocketEventServerConnectCall());
      } else {
        emit(
          BackendSocketStateReady(
            timer: state.timer,
            channel: state.channel,
            socketListener: state.socketListener,
            currentMessage: state.currentMessage,
            isPendingPing: false,
          ),
        );
      }
    }
  }

  FutureOr<void> _onSendingPing(
    BackendSocketEventSendingPing event,
    Emitter<BackendSocketState> emit,
  ) {
    if (state is BackendSocketStateReadyBase) {
      final state = this.state as BackendSocketStateReadyBase;
      //send ping data
      state.channel.sink.add(
        jsonEncode(
          BackendSocketMessage(type: SocketMessageType.ping, data: null),
        ),
      );
      emit(
        BackendSocketStatePingPending(
          timer: state.timer,
          channel: state.channel,
          socketListener: state.socketListener,
          currentMessage: state.currentMessage,
          isPendingPing: true,
        ),
      );
    }
  }
}
