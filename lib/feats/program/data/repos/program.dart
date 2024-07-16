import 'package:dartz/dartz.dart';
import 'package:dot_coaching/core/core.dart';
import 'package:dot_coaching/feats/feats.dart';

class ProgramRepoImpl implements ProgramRepo {
  final DioClient _remote;
  final IsarClient _local;

  ProgramRepoImpl(this._remote, this._local);

  @override
  Future<Either<Failure, ProgramModel>> create(
    CreateProgramParams params,
  ) async {
    final res = await _remote.postRequest(
      ListAPI.CLUB_PROGRAM,
      data: params.toJson(),
      converter: (res) => ProgramModel.fromJson(res['data']),
    );

    return res;
  }

  @override
  Future<Either<Failure, ProgramModel>> delete(
    ByIdParams params,
  ) async {
    final res = await _remote.deleteRequest(
      '${ListAPI.CLUB_PROGRAM}/${params.id}',
      converter: (res) => ProgramModel.fromJson(res['data']),
    );

    return res;
  }

  @override
  Future<Either<Failure, List<ProgramModel>>> getAll(
    PaginationParams params,
  ) async {
    final res = await _remote.getRequest(
      ListAPI.CLUB_PROGRAM,
      converter: (res) {
        final List<ProgramModel> programs = [];
        for (final item in res['data']) {
          programs.add(ProgramModel.fromJson(item));
        }
        return programs;
      },
    );

    return res;
  }

  @override
  Future<Either<Failure, ProgramModel>> getById(
    ByIdParams params,
  ) async {
    final res = await _remote.getRequest(
      '${ListAPI.CLUB_PROGRAM}/${params.id}',
      converter: (res) => ProgramModel.fromJson(res['data']),
    );

    return res;
  }

  @override
  Future<Either<Failure, ProgramModel>> update(
    UpdateProgramParams params,
  ) async {
    final res = await _remote.putRequest(
      '${ListAPI.CLUB_PROGRAM}/${params.id}',
      data: params.toJson(),
      converter: (res) => ProgramModel.fromJson(res['data']),
    );

    return res;
  }
}
