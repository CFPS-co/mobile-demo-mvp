import 'package:cfps/app/utils/img_paths_png.dart';
import 'package:cfps/data/data_source/mvp_local_data_source_impl.dart';
import 'package:cfps/data/dto/response/client_details_response_dto.dart';
import 'package:cfps/data/dto/response/kyc_response_dto.dart';
import 'package:cfps/data/dto/response/send_funds_response.dart';
import 'package:cfps/domain/data_source/mvp_api_data_source.dart';
import 'package:cfps/domain/entities/cfps_card.dart';
import 'package:cfps/domain/entities/client_details.dart';
import 'package:cfps/domain/entities/kyc.dart';
import 'package:cfps/domain/entities/request/check_email_request.dart';
import 'package:cfps/domain/entities/request/sign_in_request.dart';
import 'package:cfps/domain/entities/response/check_email_response.dart';
import 'package:cfps/domain/entities/response/sign_in_response.dart';
import 'package:cfps/domain/entities/send_funds_request.dart';
import 'package:cfps/domain/entities/transaction.dart';
import 'package:cfps/domain/repository/mvp_demo_repository.dart';
import 'package:cfps/domain/utils/errors.dart';
import 'package:cfps/domain/utils/failure.dart';
import 'package:cfps/domain/utils/mappers.dart';
import 'package:cfps/domain/utils/success.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MvpDemoRepository)
class MvpDemoRepositoryImpl implements MvpDemoRepository {
  MvpDemoRepositoryImpl(this._mvpApiDataSource, this._mvpLocalDataSource, this._dio);

  final MvpApiDataSource _mvpApiDataSource;
  final MvpLocalDataSource _mvpLocalDataSource;
  final Dio _dio;

  @override
  Future<Either<Failure, CheckEmailResponse>> checkEmail(
    CheckEmailRequest request,
  ) async {
    try {
      final result = await _mvpApiDataSource.checkEmail(request.email);
      final data = result.data as Map<String, dynamic>;
      if (data.containsKey('verification_code')) {
        return Right(
          CheckEmailResponse(
            verificationCode:
                data.entries.where((element) => element.key == 'verification_code').first.value.toString(),
          ),
        );
      } else if (data.containsValue('Client already registered')) {
        return const Left(Failure(error: Errors.apiClientAlreadyRegistered));
      } else {
        return const Left(Failure());
      }
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Future<Either<Failure, SendFundsResponse>> sendFunds(
    SendFundsRequest request,
  ) async {
    try {
      final result = await _mvpApiDataSource.sendFunds(request.clientId, request.password);
      final data = result.data as Map<String, dynamic>;
      if (data.containsKey('status')) {
        return Right(
          SendFundsResponse(
            status: data.entries.where((element) => element.key == 'status').first.value.toString(),
          ),
        );
      } else if (data.containsValue("Client doesn't exist")) {
        return const Left(Failure(error: Errors.apiClientNotExist));
      } else {
        return const Left(Failure());
      }
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Kyc>> getKycCredentials(String email, String password) async {
    final response = await _dio.post(
      "",
      data: {
        "email": email,
        "password": password,
      },
      options: Options(
        contentType: "application/x-www-form-urlencoded",
      ),
    );
    final error = response.data['error'];
    if (error != null) {
      return Left(Failure(content: error!));
    }

    final dto = KycResponseDto.fromJson(response.data);

    final credentials = Kyc(
      clientId: dto.clientId,
      sumsubtoken: dto.sumsubToken,
    );

    return Right(credentials);
  }

  @override
  Future<Either<Failure, ClientDetails>> getClientDetails() async {
    final clientId = _mvpLocalDataSource.getClientId();
    final password = _mvpLocalDataSource.getPassword();

    if (clientId == null || password == null) {
      return const Left(Failure());
    }

    final response = await _dio.get();

    try {
      final dto = ClientDetailsResponseDto.fromJson(response.data["client"][0]);
      final clientDetails = ClientDetails(
        email: dto.email,
        accountBalance: dto.accountBalance,
        name: dto.name,
        phone: dto.phone,
        cards: [
          CfpsCard(
            balance: dto.cardBalance,
            name: "Euro Card",
            number: dto.cardNumber.toString(),
            imageUrl: ImgPathsPng.euroCard,
            isBlocked: false,
            isOrdered: false,
            isReordered: false,
            currency: '€',
          )
        ],
        lastTransactions: dto.transactions
            .map(
              (t) => Transaction(
                id: t.id,
                amount: t.amount,
                merchantName: t.merchantName,
                time: DateTime.parse(t.time),
                type: getTransactionTypeFor(t.type),
                sourceName: "Euro Card",
                currency: '€',
              ),
            )
            .toList(),
      );

      return Right(clientDetails);
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Success>> deleteEmail() async {
    try {
      await _mvpLocalDataSource.deleteEmail();
      return const Right(Success());
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Success>> deletePassword() async {
    try {
      await _mvpLocalDataSource.deletePassword();
      return const Right(Success());
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Success>> deletePin() async {
    try {
      await _mvpLocalDataSource.deletePin();
      return const Right(Success());
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Either<Failure, String?> getEmail() {
    try {
      final value = _mvpLocalDataSource.getEmail();
      return Right(value);
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Either<Failure, String?> getPassword() {
    try {
      final value = _mvpLocalDataSource.getPassword();
      return Right(value);
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Either<Failure, String?> getPin() {
    try {
      final value = _mvpLocalDataSource.getPin();
      return Right(value);
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Success>> saveEmail(String email) async {
    try {
      await _mvpLocalDataSource.saveEmail(email);
      return const Right(Success());
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Success>> savePassword(String password) async {
    try {
      await _mvpLocalDataSource.savePassword(password);
      return const Right(Success());
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Success>> savePin(String code) async {
    try {
      await _mvpLocalDataSource.savePin(code);
      return const Right(Success());
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Future<Either<Failure, String>> clientRegister(String email, String password) async {
    try {
      final response = await _dio.post(
        "",
        data: {
          "email": email,
          "password": password,
        },
        options: Options(contentType: "application/x-www-form-urlencoded"),
      );

      final data = response.data;
      final error = data['error'];

      if (error != null) {
        return Left(Failure(content: error));
      }

      final clientId = data['client_id'] as String;
      await _mvpLocalDataSource.saveClientId(clientId);
      await _mvpLocalDataSource.saveEmail(email);
      await _mvpLocalDataSource.savePassword(password);

      return Right(clientId);
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Future<Either<Failure, SignInResponse>> signIn(SignInRequest request) async {
    try {
      final result = await _mvpApiDataSource.signIn(
        request.email,
        request.password,
      );
      final data = result.data as Map<String, dynamic>;
      final clientId = data['client_id'] as String?;
      final error = data['error'] as String?;

      if (error != null) {
        if (error == "Client doesn't exist") {
          return const Left(Failure(error: Errors.apiClientNotExist));
        }
        if (error == "Wrong password") {
          return const Left(Failure(error: Errors.apiWrongPassword));
        }
        return Left(Failure(content: error));
      }

      if (clientId == null) {
        return const Left(Failure());
      }

      await _mvpLocalDataSource.saveClientId(clientId);
      await _mvpLocalDataSource.saveEmail(request.email);
      await _mvpLocalDataSource.savePassword(request.password);

      return Right(SignInResponse(clientId: clientId));
    } catch (e) {
      return const Left(Failure());
    }
  }
}
