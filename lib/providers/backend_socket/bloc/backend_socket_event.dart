part of "backend_socket_bloc.dart";

sealed class BackendSocketEvent {}

final class BackendSocketEventServerConnectCall extends BackendSocketEvent {}

final class BackendSocketEventInit extends BackendSocketEvent {}

final class BackendSocketEventMessageReceived extends BackendSocketEvent {
  final BackendSocketMessage message;

  BackendSocketEventMessageReceived({required this.message});
}

final class BackendSocketEventConnectionTimedOutCheck
    extends BackendSocketEvent {}

final class BackendSocketEventSendingPing extends BackendSocketEvent {}

final class BackendSocketEventServerPingReceived extends BackendSocketEvent {}
