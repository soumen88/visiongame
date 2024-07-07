// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'difficulty_level_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? homeView,
    TResult? Function()? startGameView,
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
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LevelView value)? homeView,
    TResult? Function(_StartGameView value)? startGameView,
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
      _$DifficultyLevelViewStateCopyWithImpl<$Res, DifficultyLevelViewState>;
}

/// @nodoc
class _$DifficultyLevelViewStateCopyWithImpl<$Res,
        $Val extends DifficultyLevelViewState>
    implements $DifficultyLevelViewStateCopyWith<$Res> {
  _$DifficultyLevelViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$DifficultyLevelViewStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(_$ErrorImpl(
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'DifficultyLevelViewState.error(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

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
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? homeView,
    TResult? Function()? startGameView,
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
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LevelView value)? homeView,
    TResult? Function(_StartGameView value)? startGameView,
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
  const factory _Error(final String errorMessage) = _$ErrorImpl;

  String get errorMessage;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$DifficultyLevelViewStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'DifficultyLevelViewState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
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
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? homeView,
    TResult? Function()? startGameView,
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
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LevelView value)? homeView,
    TResult? Function(_StartGameView value)? startGameView,
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
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LevelViewImplCopyWith<$Res> {
  factory _$$LevelViewImplCopyWith(
          _$LevelViewImpl value, $Res Function(_$LevelViewImpl) then) =
      __$$LevelViewImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LevelViewImplCopyWithImpl<$Res>
    extends _$DifficultyLevelViewStateCopyWithImpl<$Res, _$LevelViewImpl>
    implements _$$LevelViewImplCopyWith<$Res> {
  __$$LevelViewImplCopyWithImpl(
      _$LevelViewImpl _value, $Res Function(_$LevelViewImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LevelViewImpl implements _LevelView {
  const _$LevelViewImpl();

  @override
  String toString() {
    return 'DifficultyLevelViewState.homeView()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LevelViewImpl);
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
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? homeView,
    TResult? Function()? startGameView,
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
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LevelView value)? homeView,
    TResult? Function(_StartGameView value)? startGameView,
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
  const factory _LevelView() = _$LevelViewImpl;
}

/// @nodoc
abstract class _$$StartGameViewImplCopyWith<$Res> {
  factory _$$StartGameViewImplCopyWith(
          _$StartGameViewImpl value, $Res Function(_$StartGameViewImpl) then) =
      __$$StartGameViewImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartGameViewImplCopyWithImpl<$Res>
    extends _$DifficultyLevelViewStateCopyWithImpl<$Res, _$StartGameViewImpl>
    implements _$$StartGameViewImplCopyWith<$Res> {
  __$$StartGameViewImplCopyWithImpl(
      _$StartGameViewImpl _value, $Res Function(_$StartGameViewImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartGameViewImpl implements _StartGameView {
  const _$StartGameViewImpl();

  @override
  String toString() {
    return 'DifficultyLevelViewState.startGameView()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartGameViewImpl);
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
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? homeView,
    TResult? Function()? startGameView,
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
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LevelView value)? homeView,
    TResult? Function(_StartGameView value)? startGameView,
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
  const factory _StartGameView() = _$StartGameViewImpl;
}
