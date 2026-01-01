import 'dart:async';
import '../../../doctor/data/data_sources/doctor_remote_data_source.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../../domain/entities/message.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatModel>> getChats();
  Stream<List<MessageModel>> getMessages(String chatId);
  Future<void> sendMessage(String chatId, String content);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final List<MessageModel> _mockMessages = [];
  final StreamController<List<MessageModel>> _messageController =
      StreamController<List<MessageModel>>.broadcast();

  ChatRemoteDataSourceImpl() {
    // Add some initial mock messages
    _mockMessages.addAll([
      MessageModel(
        id: '1',
        senderId: 'doctor1',
        receiverId: 'user1',
        content: 'Hello! How are you feeling today?',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        status: MessageStatus.read,
      ),
      MessageModel(
        id: '2',
        senderId: 'user1',
        receiverId: 'doctor1',
        content: 'I am feeling better, thank you doctor.',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        status: MessageStatus.read,
      ),
    ]);
    _messageController.add(_mockMessages);
  }

  @override
  Future<List<ChatModel>> getChats() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      ChatModel(
        id: 'chat1',
        participant: sampleDoctors[0],
        lastMessage: _mockMessages.last,
        unreadCount: 0,
      ),
      ChatModel(
        id: 'chat2',
        participant: sampleDoctors[1],
        lastMessage: MessageModel(
          id: '3',
          senderId: 'doctor2',
          receiverId: 'user1',
          content: 'Don\'t forget your appointment tomorrow.',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          status: MessageStatus.delivered,
        ),
        unreadCount: 2,
      ),
    ];
  }

  @override
  Stream<List<MessageModel>> getMessages(String chatId) {
    // In a real app, this would filter by chatId
    // Emit initial messages immediately for new listeners
    Timer.run(() => _messageController.add(List.from(_mockMessages)));
    return _messageController.stream;
  }

  @override
  Future<void> sendMessage(String chatId, String content) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final newMessage = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'user1',
      receiverId: 'doctor1',
      content: content,
      timestamp: DateTime.now(),
      status: MessageStatus.sent,
    );
    _mockMessages.add(newMessage);
    _messageController.add(List.from(_mockMessages));

    // Simulate doctor reply
    Future.delayed(const Duration(seconds: 2), () {
      final reply = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: 'doctor1',
        receiverId: 'user1',
        content: 'Glad to hear that! Keep monitoring your symptoms.',
        timestamp: DateTime.now(),
        status: MessageStatus.sent,
      );
      _mockMessages.add(reply);
      _messageController.add(List.from(_mockMessages));
    });
  }
}
