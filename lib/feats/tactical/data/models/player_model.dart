import 'package:dot_coaching/feats/feats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_model.freezed.dart';
part 'player_model.g.dart';

@freezed
class PlayerModel with _$PlayerModel {
  const factory PlayerModel({
    @Default('folks') String alias,
    @Default(0) int number,
    @Default(0) int team,
    @Default(0xFFC90508) int hexColor,
    @Default(0) double x,
    @Default(0) double y,
    // ignore: invalid_annotation_target
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool isDragging,
  }) = _PlayerModel;

  factory PlayerModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerModelFromJson(json);

  static PlayerModel fromEntity(PlayerEntity entity) {
    return PlayerModel(
      alias: entity.alias,
      number: entity.number,
      team: entity.team,
      hexColor: entity.hexColor,
      x: entity.x,
      y: entity.y,
    );
  }
}

extension PlayerModelX on PlayerModel {
  PlayerEntity toEntity() {
    return PlayerEntity(
      alias: alias,
      number: number,
      team: team,
      hexColor: hexColor,
      x: x,
      y: y,
    );
  }
}
