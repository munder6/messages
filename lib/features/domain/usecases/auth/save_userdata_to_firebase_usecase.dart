import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../repository/base_auth_repository.dart';


class SaveUserDataToFirebaseUseCase extends BaseUseCase<void ,UserDataParameters>{
  final BaseAuthRepository baseFirebaseRepository;

  SaveUserDataToFirebaseUseCase(this.baseFirebaseRepository);
  @override
  Future<Either<Failure, void>> call(UserDataParameters parameters) async{
    return await baseFirebaseRepository.saveUserDataToFirebase(parameters);
  }

}

class UserDataParameters extends Equatable {
  final String name;
  final String fcmToken;
  final File? profilePic;
  final bool isTyping;
  final bool isEnglish;

  const UserDataParameters({
    required this.name,
    this.profilePic,
    required this.fcmToken,
    this.isTyping = false,
    this.isEnglish = false,
  });

  @override
  List<Object?> get props => [
    name,
    profilePic,
    fcmToken,
    isTyping,
    isEnglish,
  ];
}

