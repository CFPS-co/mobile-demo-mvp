import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyc.freezed.dart';

@freezed
class Kyc with _$Kyc {
  const factory Kyc({
    required String sumsubtoken,
    required String clientId,
  }) = _ClientDetails;
}
