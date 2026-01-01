import '../../domain/entities/chat.dart';
import '../../../doctor/data/models/doctor_model.dart';
import 'message_model.dart';

class ChatModel extends Chat {
  const ChatModel({
    required super.id,
    required DoctorModel super.participant,
    required MessageModel super.lastMessage,
    super.unreadCount = 0,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      participant: DoctorModel.fromJson(json['participant']),
      lastMessage: MessageModel.fromJson(json['lastMessage']),
      unreadCount: json['unreadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participant': (participant as DoctorModel).toJson(),
      'lastMessage': (lastMessage as MessageModel).toJson(),
      'unreadCount': unreadCount,
    };
  }

  Chat toEntity() {
    return Chat(
      id: id,
      participant: participant,
      lastMessage: lastMessage,
      unreadCount: unreadCount,
    );
  }
}
