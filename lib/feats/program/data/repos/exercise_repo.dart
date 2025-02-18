import 'package:dartz/dartz.dart';
import 'package:dot_coaching/core/core.dart';
import 'package:dot_coaching/feats/feats.dart';

class ExerciseRepoImpl implements ExerciseRepo {
  final DioClient _remote;
  final IsarClient _local;

  ExerciseRepoImpl(this._remote, this._local);

  @override
  Future<Either<Failure, ProgramExerciseModel>> delete(
    ByIdParams params,
  ) async {
    final res = await _remote.deleteRequest(
      '${ListAPI.CLUB_PROGRAM_EXERCISE}/${params.id}',
      converter: (res) => ProgramExerciseModel.fromJson(res['data']),
    );

    res.fold(
      (l) => null,
      (r) => _local.isar.writeTxn(
        () async => _local.programExercises.delete(r.id),
      ),
    );

    return res;
  }

  @override
  Future<Either<Failure, List<ProgramExerciseModel>>> getAll(
    PaginationParams params,
    int programId,
  ) async {
    final res = await _remote.getRequest(
      ListAPI.CLUB_PROGRAM_EXERCISE,
      queryParameters: params.toJson()
        ..addAll(
          {'programId': programId},
        ),
      converter: (res) {
        final List<ProgramExerciseModel> exercises = [];
        for (final data in res['data']) {
          exercises.add(ProgramExerciseModel.fromJson(data));
        }
        return exercises;
      },
    );

    res.fold(
      (l) => null,
      (r) => _local.isar.writeTxn(() async {
        for (final item in r) {
          await _local.programExercises.put(item.toEntity());
        }
      }),
    );

    return res;
  }

  @override
  Future<Either<Failure, List<ProgramExerciseModel>>> createBulk(
    List<CreateProgramExerciseParams> params,
  ) async {
    final List<Map<String, dynamic>> body = [];
    for (final param in params) {
      body.add(param.toJson());
    }
    final res = await _remote.postRequest(
      '${ListAPI.CLUB_PROGRAM_EXERCISE}/bulk',
      listData: body,
      converter: (res) {
        final List<ProgramExerciseModel> exercises = [];
        for (final data in res['data']) {
          exercises.add(ProgramExerciseModel.fromJson(data));
        }
        return exercises;
      },
    );

    res.fold(
      (l) => null,
      (r) => _local.isar.writeTxn(() async {
        for (final item in r) {
          await _local.programExercises.put(item.toEntity());
        }
      }),
    );

    return res;
  }

  @override
  Future<Either<Failure, ProgramExerciseModel>> getById(
    ByIdParams params,
  ) async {
    final res = await _remote.getRequest(
      '${ListAPI.CLUB_PROGRAM_EXERCISE}/${params.id}',
      converter: (res) => ProgramExerciseModel.fromJson(res['data']),
    );

    res.fold(
      (l) => null,
      (r) => _local.isar.writeTxn(
        () async => _local.programExercises.put(r.toEntity()),
      ),
    );

    return res;
  }

  @override
  Future<Either<Failure, List<ProgramExerciseModel>>> updateBulk(
    List<UpdateProgramExerciseParams> params,
  ) async {
    List<CreateProgramExerciseParams> createParams = [];
    final List<Map<String, dynamic>> body = [];
    for (final param in params) {
      if (param.id == 0) {
        createParams.add(CreateProgramExerciseParams(
          programId: param.programId,
          mediaId: param.mediaId,
          name: param.name,
          description: param.description,
          repetition: param.repetition,
          sets: param.sets,
          rest: param.rest,
          tempo: param.tempo,
          intensity: param.intensity,
          order: param.order,
        ));
        continue;
      }
      body.add(param.toJson());
    }
    if (createParams.isNotEmpty) {
      await createBulk(createParams);
    }
    final res = await _remote.putRequest(
      '${ListAPI.CLUB_PROGRAM_EXERCISE}/bulk',
      listData: body,
      converter: (res) {
        final List<ProgramExerciseModel> exercises = [];
        for (final data in res['data']) {
          exercises.add(ProgramExerciseModel.fromJson(data));
        }
        return exercises;
      },
    );

    res.fold(
      (l) => null,
      (r) => _local.isar.writeTxn(() async {
        for (final item in r) {
          await _local.programExercises.put(item.toEntity());
        }
      }),
    );

    return res;
  }
}
