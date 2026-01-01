import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class FetchChats extends ChatEvent {}

class FetchMessages extends ChatEvent {
  final String chatId;
  const FetchMessages(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

class SendMessage extends ChatEvent {
  final String chatId;
  final String content;

  const SendMessage({required this.chatId, required this.content});

  @override
  List<Object?> get props => [chatId, content];
}
