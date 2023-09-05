import 'package:dartz/dartz.dart';
import 'package:message_me_app/core/error/failure.dart';
import 'package:message_me_app/core/usecase/base_use_case.dart';
import 'package:message_me_app/features/domain/repository/base_auth_repository.dart';

class UpdateProfilePicUseCase extends BaseUseCase<void,String>{
  final BaseAuthRepository _baseAuthRepository;

  UpdateProfilePicUseCase(this._baseAuthRepository);
  @override
  Future<Either<Failure, void>> call(String parameters)async {
    return await _baseAuthRepository.updateProfilePic(parameters);
  }

}