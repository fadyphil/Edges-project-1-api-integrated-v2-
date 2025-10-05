// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepDto _$StepDtoFromJson(Map<String, dynamic> json) => StepDto(
  number: (json['number'] as num).toInt(),
  step: json['step'] as String,
);

Map<String, dynamic> _$StepDtoToJson(StepDto instance) => <String, dynamic>{
  'number': instance.number,
  'step': instance.step,
};

InstructionDto _$InstructionDtoFromJson(Map<String, dynamic> json) =>
    InstructionDto(
      steps: (json['steps'] as List<dynamic>)
          .map((e) => StepDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InstructionDtoToJson(InstructionDto instance) =>
    <String, dynamic>{'steps': instance.steps};
