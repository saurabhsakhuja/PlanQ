import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'manage_workout_list_state.dart';
part 'manage_workout_list_cubit.freezed.dart';

class ManageWorkoutListCubit extends Cubit<ManageWorkoutListState> {
  ManageWorkoutListCubit() : super(const ManageWorkoutListState());

  void addWorkout(String workout) {
    final updatedList = [...state.workouts, workout];
    emit(state.copyWith(workouts: updatedList));
  }

  void removeWorkout(String workout) {
    final updatedList = [...state.workouts]..remove(workout);
    emit(state.copyWith(workouts: updatedList));
  }

  void clearAllWorkouts() {
    emit(state.copyWith(workouts: []));
  }
}
