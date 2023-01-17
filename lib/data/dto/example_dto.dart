import 'package:json_annotation/json_annotation.dart';

part 'example_dto.g.dart';

@JsonSerializable()
class ExampleDto {

  ExampleDto({required this.test});

  factory ExampleDto.fromJson(Map<String, dynamic> json) =>
      _$ExampleDtoFromJson(json);

  String test;

  Map<String, dynamic> toJson() => _$ExampleDtoToJson(this);
}
