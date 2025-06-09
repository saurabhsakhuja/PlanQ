// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_workout_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ManageWorkoutListState {
  List<String> get workouts => throw _privateConstructorUsedError;

  /// Create a copy of ManageWorkoutListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ManageWorkoutListStateCopyWith<ManageWorkoutListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManageWorkoutListStateCopyWith<$Res> {
  factory $ManageWorkoutListStateCopyWith(ManageWorkoutListState value,
          $Res Function(ManageWorkoutListState) then) =
      _$ManageWorkoutListStateCopyWithImpl<$Res, ManageWorkoutListState>;
  @useResult
  $Res call({List<String> workouts});
}

/// @nodoc
class _$ManageWorkoutListStateCopyWithImpl<$Res,
        $Val extends ManageWorkoutListState>
    implements $ManageWorkoutListStateCopyWith<$Res> {
  _$ManageWorkoutListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ManageWorkoutListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workouts = null,
  }) {
    return _then(_value.copyWith(
      workouts: null == workouts
          ? _value.workouts
          : workouts // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ManageWorkoutListStateImplCopyWith<$Res>
    implements $ManageWorkoutListStateCopyWith<$Res> {
  factory _$$ManageWorkoutListStateImplCopyWith(
          _$ManageWorkoutListStateImpl value,
          $Res Function(_$ManageWorkoutListStateImpl) then) =
      __$$ManageWorkoutListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> workouts});
}

/// @nodoc
class __$$ManageWorkoutListStateImplCopyWithImpl<$Res>
    extends _$ManageWorkoutListStateCopyWithImpl<$Res,
        _$ManageWorkoutListStateImpl>
    implements _$$ManageWorkoutListStateImplCopyWith<$Res> {
  __$$ManageWorkoutListStateImplCopyWithImpl(
      _$ManageWorkoutListStateImpl _value,
      $Res Function(_$ManageWorkoutListStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManageWorkoutListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workouts = null,
  }) {
    return _then(_$ManageWorkoutListStateImpl(
      workouts: null == workouts
          ? _value._workouts
          : workouts // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$ManageWorkoutListStateImpl implements _ManageWorkoutListState {
  const _$ManageWorkoutListStateImpl({final List<String> workouts = const []})
      : _workouts = workouts;

  final List<String> _workouts;
  @override
  @JsonKey()
  List<String> get workouts {
    if (_workouts is EqualUnmodifiableListView) return _workouts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workouts);
  }

  @override
  String toString() {
    return 'ManageWorkoutListState(workouts: $workouts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ManageWorkoutListStateImpl &&
            const DeepCollectionEquality().equals(other._workouts, _workouts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_workouts));

  /// Create a copy of ManageWorkoutListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ManageWorkoutListStateImplCopyWith<_$ManageWorkoutListStateImpl>
      get copyWith => __$$ManageWorkoutListStateImplCopyWithImpl<
          _$ManageWorkoutListStateImpl>(this, _$identity);
}

abstract class _ManageWorkoutListState implements ManageWorkoutListState {
  const factory _ManageWorkoutListState({final List<String> workouts}) =
      _$ManageWorkoutListStateImpl;

  @override
  List<String> get workouts;

  /// Create a copy of ManageWorkoutListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ManageWorkoutListStateImplCopyWith<_$ManageWorkoutListStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
