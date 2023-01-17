import 'package:cfps/domain/entities/request/check_email_request.dart';
import 'package:cfps/domain/entities/response/check_email_response.dart';
import 'package:cfps/domain/repository/mvp_demo_repository.dart';
import 'package:cfps/domain/utils/failure.dart';
import 'package:cfps/domain/utils/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckEmailUseCase implements UseCase<CheckEmailResponse, CheckEmailRequest> {
  CheckEmailUseCase(this._mvpDemoRepository);

  final MvpDemoRepository _mvpDemoRepository;

  @override
  Future<Either<Failure, CheckEmailResponse>> call(CheckEmailRequest request) =>
      _mvpDemoRepository.checkEmail(request);
}
