import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chat.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<Chat>>> getChats();
  Stream<List<Message>> getMessages(String chatId);
  Future<Either<Failure, void>> sendMessage(String chatId, String content);
}
