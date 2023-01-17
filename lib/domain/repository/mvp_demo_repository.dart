import 'package:cfps/data/dto/response/send_funds_response.dart';
import 'package:cfps/domain/entities/client_details.dart';
import 'package:cfps/domain/entities/kyc.dart';
import 'package:cfps/domain/entities/request/check_email_request.dart';
import 'package:cfps/domain/entities/request/sign_in_request.dart';
import 'package:cfps/domain/entities/response/check_email_response.dart';
import 'package:cfps/domain/entities/response/sign_in_response.dart';
import 'package:cfps/domain/entities/send_funds_request.dart';
import 'package:cfps/domain/utils/failure.dart';
import 'package:cfps/domain/utils/success.dart';
import 'package:dartz/dartz.dart';

abstract class MvpDemoRepository {
  Future<Either<Failure, CheckEmailResponse>> checkEmail(CheckEmailRequest request);

  Future<Either<Failure, SendFundsResponse>> sendFunds(SendFundsRequest request);

  Future<Either<Failure, Kyc>> getKycCredentials(String email, String password);

  Future<Either<Failure, ClientDetails>> getClientDetails();

  Future<Either<Failure, Success>> savePin(String code);

  Either<Failure, String?> getPin();

  Future<Either<Failure, Success>> deletePin();

  Future<Either<Failure, Success>> savePassword(String password);

  Either<Failure, String?> getPassword();

  Future<Either<Failure, Success>> deletePassword();

  Future<Either<Failure, Success>> saveEmail(String email);

  Either<Failure, String?> getEmail();

  Future<Either<Failure, Success>> deleteEmail();

  Future<Either<Failure, String>> clientRegister(String email, String password);

  Future<Either<Failure, SignInResponse>> signIn(SignInRequest request);
}
