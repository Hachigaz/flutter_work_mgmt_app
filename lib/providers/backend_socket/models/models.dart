part of "../bloc/backend_socket_bloc.dart";

enum SocketMessageType {
  ping(typeName: "Ping"),
  notification(typeName: "Notification");

  final String typeName;

  const SocketMessageType({required this.typeName});

  Map<String, dynamic> toJson() => {"name": name};

  static SocketMessageType fromName(String name) =>
      SocketMessageType.values.firstWhere((value) => value.name == name);
}

sealed class SocketMessageData {
  const SocketMessageData();

  Map<String, dynamic> toJson();
}

final class SocketMessageNotificationData extends SocketMessageData {
  final NotificationRecord notification;

  const SocketMessageNotificationData({required this.notification});

  @override
  Map<String, dynamic> toJson() => {"notification": notification.toJson()};

  factory SocketMessageNotificationData.fromJson(Map<String, dynamic> json) =>
      SocketMessageNotificationData(
        notification: NotificationRecord.fromJson(json["notification"]),
      );
}

final class BackendSocketMessage {
  final SocketMessageType type;
  final SocketMessageData? data;

  BackendSocketMessage({required this.type, required this.data});

  Map<String, dynamic> toJson() => {
    "type": type,
    "data": switch (type) {
      SocketMessageType.ping => null,
      SocketMessageType.notification =>
        (data as SocketMessageNotificationData).toJson(),
    },
  };

  factory BackendSocketMessage.fromJson(Map<String, dynamic> json) {
    final messageType = SocketMessageType.fromName(json["type"]["name"]);

    return BackendSocketMessage(
      type: messageType,
      data: switch (messageType) {
        SocketMessageType.ping => null,
        SocketMessageType.notification =>
          SocketMessageNotificationData.fromJson(json["data"]),
      },
    );
  }
}
