import 'package:equatable/equatable.dart';
import '../../../doctor/domain/entities/doctor.dart';
import 'message.dart';

class Chat extends Equatable {
  final String id;
  final Doctor participant;
  final Message lastMessage;
  final int unreadCount;

  const Chat({
    required this.id,
    required this.participant,
    required this.lastMessage,
    this.unreadCount = 0,
  });

  @override
  List<Object?> get props => [id, participant, lastMessage, unreadCount];
}
