// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'difficulty_level_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DifficultyLevelViewState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() homeView,
    required TResult Function() startGameView,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? startGameView,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? startGameView,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LevelView value) homeView,
    required TResult Function(_StartGameView value) startGameView,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_LevelView value)? homeView,
    TResult Function(_StartGameView value)? startGameView,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_LevelView value)? homeView,
    TResult Function(_StartGameView value)? startGameView,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DifficultyLevelViewStateCopyWith<$Res> {
  factory $DifficultyLevelViewStateCopyWith(DifficultyLevelViewState value,
          $Res Function(DifficultyLevelViewState) then) =
      _$DifficultyLevelViewStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$DifficultyLevelViewStateCopyWithImpl<$Res>
    implements $DifficultyLevelViewStateCopyWith<$Res> {
  _$DifficultyLevelViewStateCopyWithImpl(this._value, this._then);

  final DifficultyLevelViewState _value;
  // ignore: unused_field
  final $Res Function(DifficultyLevelViewState) _then;
}

/// @nodoc
abstract class _$$_ErrorCopyWith<$Res> {
  factory _$$_ErrorCopyWith(_$_Error value, $Res Function(_$_Error) then) =
      __$$_ErrorCopyWithImpl<$Res>;
  $Res call({String errorMessage});
}

/// @nodoc
class __$$_ErrorCopyWithImpl<$Res>
    extends _$DifficultyLevelViewStateCopyWithImpl<$Res>
    implements _$$_ErrorCopyWith<$Res> {
  __$$_ErrorCopyWithImpl(_$_Error _value, $Res Function(_$_Error) _then)
      : super(_value, (v) => _then(v as _$_Error));

  @override
  _$_Error get _value => super._value as _$_Error;

  @override
  $Res call({
    Object? errorMessage = freezed,
  }) {
    return _then(_$_Error(
      errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Error implements _Error {
  const _$_Error(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'DifficultyLevelViewState.error(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Error &&
            const DeepCollectionEquality()
                .equals(other.errorMessage, errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(errorMessage));

  @JsonKey(ignore: true)
  @override
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      __$$_ErrorCopyWithImpl<_$_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() homeView,
    required TResult Function() startGameView,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? startGameView,
  }) {
    return error?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? startGameView,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LevelView value) homeView,
    required TResult Function(_StartGameView value) startGameView,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_LevelView value)? homeView,
    TResult Function(_StartGameView value)? startGameView,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_LevelView value)? homeView,
    TResult Function(_StartGameView value)? startGameView,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements DifficultyLevelViewState {
  const factory _Error(final String errorMessage) = _$_Error;

  String get errorMessage;
  @JsonKey(ignore: true)
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res>
    extends _$DifficultyLevelViewStateCopyWithImpl<$Res>
    implements _$$_LoadingCopyWith<$Res> {
  __$$_LoadingCopyWithImpl(_$_Loading _value, $Res Function(_$_Loading) _then)
      : super(_value, (v) => _then(v as _$_Loading));

  @override
  _$_Loading get _value => super._value as _$_Loading;
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading();

  @override
  String toString() {
    return 'DifficultyLevelViewState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() homeView,
    required TResult Function() startGameView,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? startGameView,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? startGameView,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LevelView value) homeView,
    required TResult Function(_StartGameView value) startGameView,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_LevelView value)? homeView,
    TResult Function(_StartGameView value)? startGameView,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_LevelView value)? homeView,
    TResult Function(_StartGameView value)? startGameView,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements DifficultyLevelViewState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$$_LevelViewCopyWith<$Res> {
  factory _$$_LevelViewCopyWith(
          _$_LevelView value, $Res Function(_$_LevelView) then) =
      __$$_LevelViewCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LevelViewCopyWithImpl<$Res>
    extends _$DifficultyLevelViewStateCopyWithImpl<$Res>
    implements _$$_LevelViewCopyWith<$Res> {
  __$$_LevelViewCopyWithImpl(
      _$_LevelView _value, $Res Function(_$_LevelView) _then)
      : super(_value, (v) => _then(v as _$_LevelView));

  @override
  _$_LevelView get _value => super._value as _$_LevelView;
}

/// @nodoc

class _$_LevelView implements _LevelView {
  const _$_LevelView();

  @override
  String toString() {
    return 'DifficultyLevelViewState.homeView()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_LevelView);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() homeView,
    required TResult Function() startGameView,
  }) {
    return homeView();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? startGameView,
  }) {
    return homeView?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? startGameView,
    required TResult orElse(),
  }) {
    if (homeView != null) {
      return homeView();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LevelView value) homeView,
    required TResult Function(_StartGameView value) startGameView,
  }) {
    return homeView(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_LevelView value)? homeView,
    TResult Function(_StartGameView value)? startGameView,
  }) {
    return homeView?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_LevelView value)? homeView,
    TResult Function(_StartGameView value)? startGameView,
    required TResult orElse(),
  }) {
    if (homeView != null) {
      return homeView(this);
    }
    return orElse();
  }
}

abstract class _LevelView implements DifficultyLevelViewState {
  const factory _LevelView() = _$_LevelView;
}

/// @nodoc
abstract class _$$_StartGameViewCopyWith<$Res> {
  factory _$$_StartGameViewCopyWith(
          _$_StartGameView value, $Res Function(_$_StartGameView) then) =
      __$$_StartGameViewCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_StartGameViewCopyWithImpl<$Res>
    extends _$DifficultyLevelViewStateCopyWithImpl<$Res>
    implements _$$_StartGameViewCopyWith<$Res> {
  __$$_StartGameViewCopyWithImpl(
      _$_StartGameView _value, $Res Function(_$_StartGameView) _then)
      : super(_value, (v) => _then(v as _$_StartGameView));

  @override
  _$_StartGameView get _value => super._value as _$_StartGameView;
}

/// @nodoc

class _$_StartGameView implements _StartGameView {
  const _$_StartGameView();

  @override
  String toString() {
    return 'DifficultyLevelViewState.startGameView()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_StartGameView);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() homeView,
    required TResult Function() startGameView,
  }) {
    return startGameView();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? startGameView,
  }) {
    return startGameView?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? startGameView,
    required TResult orElse(),
  }) {
    if (startGameView != null) {
      return startGameView();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LevelView value) homeView,
    required TResult Function(_StartGameView value) startGameView,
  }) {
    return startGameView(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_LevelView value)? homeView,
    TResult Function(_StartGameView value)? startGameView,
  }) {
    return startGameView?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_LevelView value)? homeView,
    TResult Function(_StartGameView value)? startGameView,
    required TResult orElse(),
  }) {
    if (startGameView != null) {
      return startGameView(this);
    }
    return orElse();
  }
}

abstract class _StartGameView implements DifficultyLevelViewState {
  const factory _StartGameView() = _$_StartGameView;
}
