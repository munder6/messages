import 'package:dartz/dartz.dart';
import 'package:message_me_app/core/error/failure.dart';
import 'package:message_me_app/core/usecase/base_use_case.dart';
import 'package:message_me_app/features/domain/entities/user.dart';
import 'package:message_me_app/features/domain/repository/base_auth_repository.dart';

class GetCurrentUserUseCase extends BaseUseCase<UserEntity,NoParameters>{
  final BaseAuthRepository _authRepository;

  GetCurrentUserUseCase(this._authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(NoParameters parameters) async{
    return await _authRepository.getCurrentUser();
  }
}