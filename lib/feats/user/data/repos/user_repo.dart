import 'package:dartz/dartz.dart';
import 'package:dot_coaching/core/core.dart';
import 'package:dot_coaching/feats/feats.dart';
import 'package:isar/isar.dart';

class UserRepoImpl implements UserRepo {
  final DioClient _remote;
  final IsarClient _local;

  UserRepoImpl(
    this._remote,
    this._local,
  );

  @override
  Future<Either<Failure, UserEntity>> getMe() async {
    final res = await _local.isar.txn(() async {
      return await _local.isar.userEntitys.filter().tokenIsNotEmpty().findAll();
    });

    if (res.isEmpty) {
      return const Left(StorageFailure(message: 'No user data found'));
    }

    return Right(res.last);
  }

  @override
  Future<bool> clear() async {
    await _local.isar.writeTxn(() async {
      await _local.isar.userEntitys.clear();
    });

    final check = await _local.isar.txn(() async {
      return await _local.isar.userEntitys.where().findAll();
    });

    return check.isEmpty;
  }

  @override
  Future<Either<Failure, List<String>>> findUsername(
    String username,
    String email,
  ) async {
    final res = await _remote.getRequest(
      '${ListAPI.USER}/find-username',
      queryParameters: {
        'username': username,
        'email': email,
      },
      converter: (res) {
        List<String> data = [];
        if (res['message'] == 'Username not available') {
          for (var item in res['data']) {
            data.add(item);
          }
        }

        return data;
      },
    );

    return res;
  }

  @override
  Future<Either<Failure, UserPreferencesModel>> getUserPref() async {
    final res = await _local.isar.txn(() async {
      return await _local.userPreferences.where().findAll();
    });

    if (res.isEmpty) {
      return const Left(StorageFailure(message: 'No user preferences found'));
    }

    return Right(UserPreferencesModel.fromEntity(res.last));
  }

  @override
  Future<Either<Failure, bool>> saveUserPref(
    UserPreferencesModel model,
  ) async {
    final entity = model.toEntity();
    entity.id = 1;
    final res = await _local.isar.writeTxn(() async {
      return await _local.userPreferences.put(entity).then((value) {
        return true;
      }).catchError((e) {
        return false;
      });
    });

    return Right(res);
  }

  @override
  Future<Either<Failure, UserModel>> updateProfile(
    UpdateUserParams params,
  ) async {
    Future<Either<Failure, UserModel>> updateUserProfile() async {
      return await _remote.putRequest(
        '${ListAPI.USER}/update',
        data: params.toJson(),
        converter: (res) => UserModel.fromJson(res['data']),
      );
    }

    Future<void> saveUserLocally(UserModel userModel) async {
      await _local.isar.writeTxn(() async {
        await _local.isar.userEntitys.clear();
        await _local.isar.userEntitys.put(userModel.toEntity());
      });
    }

    if (params.image != null) {
      final photoUpdateRes = await _remote.putRequest(
        '${ListAPI.USER}/update-photo',
        formData: params.toFormData(),
        converter: (res) => UserModel.fromJson(res['data']),
      );

      return photoUpdateRes.fold(
        (l) => Left(l),
        (_) async {
          final userUpdateRes = await updateUserProfile();
          return userUpdateRes.fold(
            (l) => Left(l),
            (r) async {
              await saveUserLocally(r);
              return Right(r);
            },
          );
        },
      );
    } else {
      final userUpdateRes = await updateUserProfile();
      return userUpdateRes.fold(
        (l) => Left(l),
        (r) async {
          await saveUserLocally(r);
          return Right(r);
        },
      );
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> search(
    String query,
  ) async {
    final res = await _remote.getRequest(
      '${ListAPI.USER}/search',
      queryParameters: {
        'query': query,
      },
      converter: (res) {
        List<UserModel> data = [];
        for (var item in res['data']) {
          data.add(UserModel.fromJson(item));
        }

        return data;
      },
    );

    return res;
  }

  @override
  Future<Either<Failure, UserModel>> updateFCMToken(
    String fcmToken,
  ) async {
    final res = await _remote.putRequest(
      '${ListAPI.USER}/update-fcm-token',
      data: {
        'fcmToken': fcmToken,
      },
      converter: (res) => UserModel.fromJson(res['data']),
    );

    return res;
  }

  @override
  Future<Either<Failure, bool>> cacheNotification(
    NotificationDataModel notification,
  ) async {
    final res = await _local.isar.writeTxn(() async {
      return await _local.notifications
          .put(notification.toEntity())
          .then((value) {
        return true;
      }).catchError((e) {
        return false;
      });
    });

    return Right(res);
  }

  @override
  Future<Either<Failure, bool>> clearNotifications() async {
    final res = await _local.isar.writeTxn(() async {
      return await _local.notifications.clear().then((value) {
        return true;
      }).catchError((e) {
        return false;
      });
    });

    return Right(res);
  }

  @override
  Future<Either<Failure, List<NotificationDataModel>>>
      getNotifications() async {
    final res = await _local.isar.txn(() async {
      return await _local.notifications.where().findAll();
    });

    List<NotificationDataModel> data = [];
    for (var item in res) {
      data.add(NotificationDataModel.fromEntity(item));
    }

    return Right(data);
  }
}
