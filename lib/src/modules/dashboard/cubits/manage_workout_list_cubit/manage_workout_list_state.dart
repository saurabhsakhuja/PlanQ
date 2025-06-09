part of 'manage_workout_list_cubit.dart';

@freezed
class ManageWorkoutListState with _$ManageWorkoutListState {
  const factory ManageWorkoutListState({
    @Default([]) List<String> workouts,
  }) = _ManageWorkoutListState;
}
