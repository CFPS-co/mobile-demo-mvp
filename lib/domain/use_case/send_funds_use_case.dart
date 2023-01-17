import 'package:cfps/data/dto/response/send_funds_response.dart';
import 'package:cfps/domain/entities/send_funds_request.dart';
import 'package:cfps/domain/repository/mvp_demo_repository.dart';
import 'package:cfps/domain/utils/failure.dart';
import 'package:cfps/domain/utils/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendFundsUseCase implements UseCase<SendFundsResponse, SendFundsRequest> {
  SendFundsUseCase(this._mvpDemoRepository);

  final MvpDemoRepository _mvpDemoRepository;

  @override
  Future<Either<Failure, SendFundsResponse>> call(SendFundsRequest request) => _mvpDemoRepository.sendFunds(request);
}
