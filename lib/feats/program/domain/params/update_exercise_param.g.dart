// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_exercise_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateProgramExerciseParamsImpl _$$UpdateProgramExerciseParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateProgramExerciseParamsImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      order: (json['order'] as num?)?.toInt() ?? 0,
      programId: (json['programId'] as num?)?.toInt() ?? 0,
      mediaId: (json['mediaId'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      repetition: (json['repetition'] as num?)?.toInt() ?? 0,
      sets: (json['sets'] as num?)?.toInt() ?? 0,
      rest: (json['rest'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UpdateProgramExerciseParamsImplToJson(
        _$UpdateProgramExerciseParamsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'programId': instance.programId,
      'mediaId': instance.mediaId,
      'name': instance.name,
      'description': instance.description,
      'repetition': instance.repetition,
      'sets': instance.sets,
      'rest': instance.rest,
    };
