import 'package:json_annotation/json_annotation.dart';

part 'example_response_dto.g.dart';

@JsonSerializable()
class ExampleResponseDto {
  ExampleResponseDto({
    required this.example,
  });
  factory ExampleResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ExampleResponseDtoFromJson(json);

  final String example;

  Map<String, dynamic> toJson() => _$ExampleResponseDtoToJson(this);
}
