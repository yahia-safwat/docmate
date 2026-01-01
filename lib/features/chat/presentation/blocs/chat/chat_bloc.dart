import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/usecases/get_chats_usecase.dart';
import '../../../domain/usecases/get_messages_usecase.dart';
import '../../../domain/usecases/send_message_usecase.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatsUseCase getChatsUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  StreamSubscription? _messagesSubscription;

  ChatBloc({
    required this.getChatsUseCase,
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
  }) : super(ChatInitial()) {
    on<FetchChats>(_onFetchChats);
    on<FetchMessages>(_onFetchMessages);
    on<SendMessage>(_onSendMessage);
    on<_UpdateMessages>(
      (event, emit) => emit(MessagesLoaded(List<Message>.from(event.messages))),
    );
  }

  Future<void> _onFetchChats(FetchChats event, Emitter<ChatState> emit) async {
    emit(ChatsLoading());
    final result = await getChatsUseCase();
    result.fold(
      (failure) => emit(const ChatError('Failed to load chats')),
      (chats) => emit(ChatsLoaded(chats)),
    );
  }

  Future<void> _onFetchMessages(
    FetchMessages event,
    Emitter<ChatState> emit,
  ) async {
    emit(MessagesLoading());
    await _messagesSubscription?.cancel();
    _messagesSubscription = getMessagesUseCase(
      event.chatId,
    ).listen((messages) => add(_UpdateMessages(messages)));
  }

  @override
  void onTransition(Transition<ChatEvent, ChatState> transition) {
    super.onTransition(transition);
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    final result = await sendMessageUseCase(event.chatId, event.content);
    result.fold(
      (failure) => emit(const ChatError('Failed to send message')),
      (_) => null, // Message will be updated via stream
    );
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}

class _UpdateMessages extends ChatEvent {
  final List<dynamic> messages;
  const _UpdateMessages(this.messages);

  @override
  List<Object?> get props => [messages];
}
