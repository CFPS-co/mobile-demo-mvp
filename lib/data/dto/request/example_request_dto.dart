import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_request_dto.freezed.dart';

part 'example_request_dto.g.dart';

@freezed
class ExampleRequestDto with _$ExampleRequestDto {
  const factory ExampleRequestDto({
    required String example,
  }) = ExampleRequestDtoData;

  factory ExampleRequestDto.fromJson(Map<String, dynamic> json) => _$ExampleRequestDtoFromJson(json);
}
