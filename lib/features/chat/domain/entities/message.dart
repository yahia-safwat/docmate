import 'package:equatable/equatable.dart';

enum MessageStatus { sent, delivered, read }

class Message extends Equatable {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;
  final MessageStatus status;

  const Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    this.status = MessageStatus.sent,
  });

  @override
  List<Object?> get props => [
    id,
    senderId,
    receiverId,
    content,
    timestamp,
    status,
  ];
}
