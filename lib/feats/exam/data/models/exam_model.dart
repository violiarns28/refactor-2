import 'dart:math';

import 'package:dot_coaching/feats/feats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'exam_model.freezed.dart';
part 'exam_model.g.dart';

@freezed
class ExamModel with _$ExamModel {
  const factory ExamModel({
    @Default(0) int id,
    @Default(0) int clubId,
    int? imageId,
    @Default('Mid term exam') String title,
    String? description,
    DateTime? dueAt,
    MediaEmbedModel? media,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ExamModel;

  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);

  static ExamModel fromEntity(ExamEntity entity) {
    return ExamModel(
      id: entity.id,
      clubId: entity.clubId,
      title: entity.title,
      description: entity.description,
      dueAt: entity.dueAt,
      media: entity.media != null
          ? MediaEmbedModel.fromEntity(entity.media!)
          : null,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  static ExamModel fake() {
    return ExamModel(
      id: Random().nextInt(100),
      clubId: Random().nextInt(100),
      title: BoneMock.name,
      description: BoneMock.subtitle,
    );
  }
}

extension ExamModelX on ExamModel {
  ExamEntity toEntity() {
    return ExamEntity(
      id: id,
      clubId: clubId,
      title: title,
      description: description,
      dueAt: dueAt,
      media: media?.toEntity(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
