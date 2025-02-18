import 'package:dartz/dartz.dart';
import 'package:dot_coaching/core/core.dart';
import 'package:dot_coaching/feats/feats.dart';

class ExamRepoImpl implements ExamRepo {
  final DioClient _remote;
  final IsarClient _local;

  ExamRepoImpl(this._remote, this._local);

  @override
  Future<Either<Failure, ExamModel>> create(
    CreateExamParams params,
  ) async {
    final res = await _remote.postRequest(
      ListAPI.CLUB_EXAM,
      data: params.toJson(),
      converter: (res) => ExamModel.fromJson(res['data']),
    );

    return res.fold(
      (l) => Left(l),
      (r) async {
        if (params.image != null) {
          final photoUpdateRes = await _remote.putRequest(
            '${ListAPI.CLUB_EXAM}/${r.id}/image',
            formData: params.toFormData(),
            converter: (res) => ProgramModel.fromJson(res['data']),
          );

          return photoUpdateRes.fold(
            (l) => Left(l),
            (_) async {
              await _local.isar.writeTxn(
                () async => _local.exams.put(r.toEntity()),
              );
              return Right(r);
            },
          );
        }
        await _local.isar.writeTxn(
          () async => _local.exams.put(r.toEntity()),
        );
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, ExamModel>> delete(
    ByIdParams params,
  ) async {
    final res = await _remote.deleteRequest(
      '${ListAPI.CLUB_EXAM}/${params.id}',
      converter: (res) => ExamModel.fromJson(res['data']),
    );

    res.fold(
      (l) => null,
      (r) => _local.isar.writeTxn(
        () async => _local.exams.delete(r.id),
      ),
    );

    return res;
  }

  @override
  Future<Either<Failure, List<ExamModel>>> getAll(
    PaginationParams params,
    int clubId,
  ) async {
    final res = await _remote.getRequest(
      ListAPI.CLUB_EXAM,
      queryParameters: {
        'clubId': clubId,
        'cursor': params.cursor,
        'limit': params.limit,
      },
      converter: (res) {
        final List<ExamModel> exams = [];
        for (final item in res['data']) {
          exams.add(ExamModel.fromJson(item));
        }
        return exams;
      },
    );

    res.fold(
      (l) => null,
      (r) => _local.isar.writeTxn(() async {
        for (final item in r) {
          await _local.exams.put(item.toEntity());
        }
      }),
    );

    return res;
  }

  @override
  Future<Either<Failure, ExamModel>> getById(
    ByIdParams params,
  ) async {
    final res = await _remote.getRequest(
      '${ListAPI.CLUB_EXAM}/${params.id}',
      converter: (res) => ExamModel.fromJson(res['data']),
    );

    res.fold(
      (l) => null,
      (r) => _local.isar.writeTxn(
        () async => _local.exams.put(r.toEntity()),
      ),
    );

    return res;
  }

  @override
  Future<Either<Failure, ExamModel>> update(
    UpdateExamParams params,
  ) async {
    final res = await _remote.putRequest(
      '${ListAPI.CLUB_EXAM}/${params.id}',
      data: params.toJson(),
      converter: (res) => ExamModel.fromJson(res['data']),
    );

    res.fold(
      (l) => null,
      (r) => _local.isar.writeTxn(
        () async => _local.exams.put(r.toEntity()),
      ),
    );
    return res.fold(
      (l) => Left(l),
      (r) async {
        if (params.image != null) {
          final photoUpdateRes = await _remote.putRequest(
            '${ListAPI.CLUB_EXAM}/${r.id}/image',
            formData: params.toFormData(),
            converter: (res) => ProgramModel.fromJson(res['data']),
          );

          return photoUpdateRes.fold(
            (l) => Left(l),
            (_) async {
              await _local.isar.writeTxn(
                () async => _local.exams.put(r.toEntity()),
              );
              return Right(r);
            },
          );
        }
        await _local.isar.writeTxn(
          () async => _local.exams.put(r.toEntity()),
        );
        return Right(r);
      },
    );
  }
}
