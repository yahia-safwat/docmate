import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../data_sources/chat_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Chat>>> getChats() async {
    try {
      final chatModels = await remoteDataSource.getChats();
      return Right(chatModels.map((model) => model.toEntity()).toList());
    } catch (e) {
      return const Left(ServerFailure(message: 'Failed to fetch chats'));
    }
  }

  @override
  Stream<List<Message>> getMessages(String chatId) {
    return remoteDataSource
        .getMessages(chatId)
        .map((models) => models.map((model) => model.toEntity()).toList());
  }

  @override
  Future<Either<Failure, void>> sendMessage(
    String chatId,
    String content,
  ) async {
    try {
      await remoteDataSource.sendMessage(chatId, content);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure(message: 'Failed to send message'));
    }
  }
}
