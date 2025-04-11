part of "backend_socket_bloc.dart";

sealed class BackendSocketState extends Equatable {
  const BackendSocketState();

  @override
  List<Object?> get props => [];
}

final class BackendSocketStateInitial extends BackendSocketState {
  const BackendSocketStateInitial();
}

final class BackendSocketStateConnecting extends BackendSocketState {
  const BackendSocketStateConnecting();
}

final class BackendSocketStateConnectionError extends BackendSocketState {
  final String errorMessage;
  const BackendSocketStateConnectionError({required this.errorMessage});
}

sealed class BackendSocketStateReadyBase extends BackendSocketState {
  final WebSocketChannel channel;
  final Timer timer;
  final StreamSubscription<dynamic> socketListener;
  final BackendSocketMessage? currentMessage;
  final bool isPendingPing;

  const BackendSocketStateReadyBase({
    required this.timer,
    required this.channel,
    required this.socketListener,
    required this.currentMessage,
    required this.isPendingPing,
  });

  @override
  List<Object?> get props => [...super.props, channel, currentMessage];
}

final class BackendSocketStateReady extends BackendSocketStateReadyBase {
  const BackendSocketStateReady({
    required super.timer,
    required super.channel,
    required super.socketListener,
    required super.currentMessage,
    required super.isPendingPing,
  });
}

final class BackendSocketStateIncomingMessage
    extends BackendSocketStateReadyBase {
  const BackendSocketStateIncomingMessage({
    required super.timer,
    required super.channel,
    required super.socketListener,
    required super.currentMessage,
    required super.isPendingPing,
  });
}

final class BackendSocketStatePingPending extends BackendSocketStateReadyBase {
  const BackendSocketStatePingPending({
    required super.timer,
    required super.channel,
    required super.socketListener,
    required super.currentMessage,
    required super.isPendingPing,
  });
}

final class BackendSocketStateConnectionTimedOut
    extends BackendSocketStateReadyBase {
  const BackendSocketStateConnectionTimedOut({
    required super.timer,
    required super.channel,
    required super.socketListener,
    required super.currentMessage,
    required super.isPendingPing,
  });
}
