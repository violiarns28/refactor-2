import 'package:dot_coaching/feats/feats.dart';
import 'package:isar/isar.dart';

part 'tactical_entity.g.dart';

@collection
class TacticalEntity {
  Id id = Isar.autoIncrement;
  int clubId;
  int? mediaId;
  String name;
  String? description;
  TacticalBoardEntity board = TacticalBoardEntity();
  // TacticalTeamEntity? team;
  TacticalStrategicEntity? strategic;
  bool isLive;
  MediaEmbedEntity? media;
  DateTime? createdAt;
  DateTime? updatedAt;

  // n:1 relationship
  final club = IsarLink<ClubEntity>();

  TacticalEntity({
    this.id = Isar.autoIncrement,
    this.clubId = 0,
    this.mediaId,
    this.name = 'SBY Tactical exhibition',
    this.description,
    required this.board,
    // this.team,
    this.strategic,
    this.isLive = false,
    this.media,
    this.createdAt,
    this.updatedAt,
  });
}

@embedded
class TacticalBoardEntity {
  double width, height;

  TacticalBoardEntity({
    this.width = 0,
    this.height = 0,
  });
}

@embedded
class TacticalStrategicEntity {
  List<PlayerEntity> players = [];
  List<ArrowEntity> arrows = [];

  TacticalStrategicEntity({
    this.players = const [],
    this.arrows = const [],
  });
}
