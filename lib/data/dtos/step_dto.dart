import 'package:json_annotation/json_annotation.dart';

part 'step_dto.g.dart';

@JsonSerializable()
class StepDto {
  final int number;
  final String step; // This is the description of the step

  StepDto({required this.number, required this.step});

  factory StepDto.fromJson(Map<String, dynamic> json) => _$StepDtoFromJson(json);
  Map<String, dynamic> toJson() => _$StepDtoToJson(this);
}

@JsonSerializable()
class InstructionDto {
  final List<StepDto> steps;

  InstructionDto({required this.steps});

  factory InstructionDto.fromJson(Map<String, dynamic> json) => _$InstructionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$InstructionDtoToJson(this);
}