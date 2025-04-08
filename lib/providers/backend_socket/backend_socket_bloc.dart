import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part "backend_socket_event.dart";
part "backend_socket_state.dart";

class BackendSocketBloc extends Bloc<BackendSocketEvent, BackendSocketState> {
  BackendSocketBloc() : super(BackendSocketState());
}
