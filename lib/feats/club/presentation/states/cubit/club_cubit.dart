import 'dart:io';

import 'package:dot_coaching/core/core.dart';
import 'package:dot_coaching/feats/feats.dart';
import 'package:dot_coaching/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'club_cubit.freezed.dart';
part 'club_state.dart';

class ClubCubit extends Cubit<ClubState> {
  final ClubRepo _clubRepo;
  final UserRepo _userRepo;
  final ImagePickerClient _imagePickerClient;

  ClubCubit(
    this._clubRepo,
    this._userRepo,
    this._imagePickerClient,
  ) : super(const ClubState());

  void emitCaller(ClubState s) {
    safeEmit(
      isClosed: isClosed,
      emit: emit,
      state: s,
    );
  }

  Future<void> init() async {
    final u = await fetchLocalUser();
    if (u != null) {
      u.role == UserRole.coach ? await coachInit(u) : await athleteInit();
    }
  }

  Future<UserEntity?> fetchLocalUser() async {
    final res = await _userRepo.getMe();
    return res.fold(
      (l) => null,
      (r) => r,
    );
  }

  Future<void> coachInit(UserEntity user) async {
    await getAll(user);
  }

  Future<void> athleteInit() async {}

  Future<void> getAll(UserEntity user) async {
    final res = await _clubRepo.getAll(
      const PaginationParams(),
      user.role == UserRole.coach ? user.id : null,
    );

    res.fold(
      (l) => safeEmit(
        isClosed: isClosed,
        emit: emit,
        state: state.copyWith(
          state: BaseState.failure,
          failure: l,
        ),
      ),
      (r) {
        safeEmit(
          isClosed: isClosed,
          emit: emit,
          state: state.copyWith(
            state: BaseState.success,
            coachClubs: r,
          ),
        );
      },
    );
  }

  Future<void> create(CreateClubParams params) async {
    final res = await _clubRepo.create(params);

    res.fold(
      (l) => safeEmit(
        isClosed: isClosed,
        emit: emit,
        state: state.copyWith(
          state: BaseState.failure,
          failure: l,
        ),
      ),
      (r) {
        final coachClub = List<ClubModel>.from(state.coachClubs);
        coachClub.add(r);

        safeEmit(
          isClosed: isClosed,
          emit: emit,
          state: state.copyWith(
            state: BaseState.success,
            coachClubs: coachClub,
          ),
        );
      },
    );
  }

  Future<void> update(UpdateClubParams params) async {
    final res = await _clubRepo.update(params);

    res.fold(
      (l) => safeEmit(
        isClosed: isClosed,
        emit: emit,
        state: state.copyWith(
          state: BaseState.failure,
          failure: l,
        ),
      ),
      (r) {
        final coachClub = List<ClubModel>.from(state.coachClubs);
        final index = coachClub.indexWhere((element) => element.id == r.id);
        coachClub[index] = r;

        safeEmit(
          isClosed: isClosed,
          emit: emit,
          state: state.copyWith(
            state: BaseState.success,
            coachClubs: coachClub,
          ),
        );
      },
    );
  }

  Future<void> delete(ByIdParams params) async {
    final res = await _clubRepo.delete(params);

    res.fold(
      (l) => safeEmit(
        isClosed: isClosed,
        emit: emit,
        state: state.copyWith(
          state: BaseState.failure,
          failure: l,
        ),
      ),
      (r) {
        final coachClub = List<ClubModel>.from(state.coachClubs);
        coachClub.removeWhere((element) => element.id == params.id);

        safeEmit(
          isClosed: isClosed,
          emit: emit,
          state: state.copyWith(
            state: BaseState.success,
            coachClubs: coachClub,
          ),
        );
      },
    );
  }

  Future<void> getById(ByIdParams params) async {
    final res = await _clubRepo.getById(params);

    res.fold(
      (l) => safeEmit(
        isClosed: isClosed,
        emit: emit,
        state: state.copyWith(
          state: BaseState.failure,
          failure: l,
        ),
      ),
      (r) {
        safeEmit(
          isClosed: isClosed,
          emit: emit,
          state: state.copyWith(
            state: BaseState.success,
          ),
        );
      },
    );
  }

  void pickImageFromGallery() async {
    final res = await _imagePickerClient.getImageFromGallery();

    res.fold(
      (l) {},
      (r) {
        safeEmit(
          isClosed: isClosed,
          emit: emit,
          state: state.copyWith(
            image: File(r.path),
          ),
        );
      },
    );
  }

  void pickImageFromCamera() async {
    final res = await _imagePickerClient.getImageFromCamera();

    res.fold(
      (l) {},
      (r) {
        safeEmit(
          isClosed: isClosed,
          emit: emit,
          state: state.copyWith(
            image: File(r.path),
          ),
        );
      },
    );
  }
}
