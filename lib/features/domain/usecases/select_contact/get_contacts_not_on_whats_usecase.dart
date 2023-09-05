import 'package:dartz/dartz.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:message_me_app/core/error/failure.dart';
import 'package:message_me_app/core/usecase/base_use_case.dart';
import 'package:message_me_app/features/domain/repository/base_select_contact_repository.dart';

class GetContactsNotOnWhatsUseCase extends BaseUseCase<List<Contact>, NoParameters>{
  final BaseSelectContactRepository _baseSelectContactRepository;

  GetContactsNotOnWhatsUseCase(this._baseSelectContactRepository);
  @override
  Future<Either<Failure, List<Contact>>> call(NoParameters parameters) async{
    return await _baseSelectContactRepository.getContactsNotOnWhatsApp();
  }

}