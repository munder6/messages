import 'package:equatable/equatable.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../entities/message.dart';
import '../../repository/base_chat_repository.dart';

class GetChatMessagesUseCase extends StreamBaseUseCase<List<Message>, GetChatMessagesParameters>{
  final BaseChatRepository _baseChatRepository;

  GetChatMessagesUseCase(this._baseChatRepository);

  @override
  Stream<List<Message>> call(GetChatMessagesParameters parameters) {
    return _baseChatRepository.getChatMessages(parameters);
  }

}

class GetChatMessagesParameters extends Equatable {
  final String receiverId;

  const GetChatMessagesParameters({
    required this.receiverId,
  });

  @override
  List<Object?> get props => [
    receiverId,
  ];
}