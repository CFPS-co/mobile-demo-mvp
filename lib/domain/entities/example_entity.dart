import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/dto/example_dto.dart';

part 'example_entity.freezed.dart';

@freezed
class ExampleEntity with _$ExampleEntity {
  const factory ExampleEntity({
    required String test,
  }) = _ExampleEntity;
}

extension AppleSocialSignInResultExtension on ExampleEntity {
  ExampleDto get toDto => ExampleDto(test: test);
}
