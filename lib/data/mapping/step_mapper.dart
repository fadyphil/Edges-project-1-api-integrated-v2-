// --- A New Mapper just for Steps ---
import 'package:mini_project_1/data/dtos/step_dto.dart';
import 'package:mini_project_1/data/models/enums.dart';
import 'package:mini_project_1/data/models/step_model.dart';

class StepMapper {
  static Step fromDto(StepDto dto) {
    return Step(
      // The API doesn't give a title, so we'll create one
      title: 'Step ${dto.number}', 
      description: dto.step,
      // The API doesn't time individual steps, so we have to invent a sensible default.
      // We can make this smarter later if we want.
      baseTimeInSeconds: 120, // Default to 2 minutes per step for now
      type: StepType.cooking, // Default to cooking
    );
  }
}