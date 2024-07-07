// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_screen_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameScreenViewState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() displayGameView,
    required TResult Function() displayGameOver,
    required TResult Function() displayGameWin,
    required TResult Function() displayTutorialView,
    required TResult Function() displayRobotView,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? displayGameView,
    TResult? Function()? displayGameOver,
    TResult? Function()? displayGameWin,
    TResult? Function()? displayTutorialView,
    TResult? Function()? displayRobotView,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? displayGameView,
    TResult Function()? displayGameOver,
    TResult Function()? displayGameWin,
    TResult Function()? displayTutorialView,
    TResult Function()? displayRobotView,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_DisplayGameView value) displayGameView,
    required TResult Function(_DisplayGameOver value) displayGameOver,
    required TResult Function(_DisplayGameWin value) displayGameWin,
    required TResult Function(_DisplayTutorialView value) displayTutorialView,
    required TResult Function(_DisplayRobotView value) displayRobotView,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_DisplayGameView value)? displayGameView,
    TResult? Function(_DisplayGameOver value)? displayGameOver,
    TResult? Function(_DisplayGameWin value)? displayGameWin,
    TResult? Function(_DisplayTutorialView value)? displayTutorialView,
    TResult? Function(_DisplayRobotView value)? displayRobotView,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayGameView value)? displayGameView,
    TResult Function(_DisplayGameOver value)? displayGameOver,
    TResult Function(_DisplayGameWin value)? displayGameWin,
    TResult Function(_DisplayTutorialView value)? displayTutorialView,
    TResult Function(_DisplayRobotView value)? displayRobotView,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameScreenViewStateCopyWith<$Res> {
  factory $GameScreenViewStateCopyWith(
          GameScreenViewState value, $Res Function(GameScreenViewState) then) =
      _$GameScreenViewStateCopyWithImpl<$Res, GameScreenViewState>;
}

/// @nodoc
class _$GameScreenViewStateCopyWithImpl<$Res, $Val extends GameScreenViewState>
    implements $GameScreenViewStateCopyWith<$Res> {
  _$GameScreenViewStateCopyWithImpl(this._value, this._then);

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
    extends _$GameScreenViewStateCopyWithImpl<$Res, _$ErrorImpl>
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
    return 'GameScreenViewState.error(errorMessage: $errorMessage)';
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
    required TResult Function() displayGameView,
    required TResult Function() displayGameOver,
    required TResult Function() displayGameWin,
    required TResult Function() displayTutorialView,
    required TResult Function() displayRobotView,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? displayGameView,
    TResult? Function()? displayGameOver,
    TResult? Function()? displayGameWin,
    TResult? Function()? displayTutorialView,
    TResult? Function()? displayRobotView,
  }) {
    return error?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? displayGameView,
    TResult Function()? displayGameOver,
    TResult Function()? displayGameWin,
    TResult Function()? displayTutorialView,
    TResult Function()? displayRobotView,
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
    required TResult Function(_DisplayGameView value) displayGameView,
    required TResult Function(_DisplayGameOver value) displayGameOver,
    required TResult Function(_DisplayGameWin value) displayGameWin,
    required TResult Function(_DisplayTutorialView value) displayTutorialView,
    required TResult Function(_DisplayRobotView value) displayRobotView,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_DisplayGameView value)? displayGameView,
    TResult? Function(_DisplayGameOver value)? displayGameOver,
    TResult? Function(_DisplayGameWin value)? displayGameWin,
    TResult? Function(_DisplayTutorialView value)? displayTutorialView,
    TResult? Function(_DisplayRobotView value)? displayRobotView,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayGameView value)? displayGameView,
    TResult Function(_DisplayGameOver value)? displayGameOver,
    TResult Function(_DisplayGameWin value)? displayGameWin,
    TResult Function(_DisplayTutorialView value)? displayTutorialView,
    TResult Function(_DisplayRobotView value)? displayRobotView,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements GameScreenViewState {
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
    extends _$GameScreenViewStateCopyWithImpl<$Res, _$LoadingImpl>
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
    return 'GameScreenViewState.loading()';
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
    required TResult Function() displayGameView,
    required TResult Function() displayGameOver,
    required TResult Function() displayGameWin,
    required TResult Function() displayTutorialView,
    required TResult Function() displayRobotView,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? displayGameView,
    TResult? Function()? displayGameOver,
    TResult? Function()? displayGameWin,
    TResult? Function()? displayTutorialView,
    TResult? Function()? displayRobotView,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? displayGameView,
    TResult Function()? displayGameOver,
    TResult Function()? displayGameWin,
    TResult Function()? displayTutorialView,
    TResult Function()? displayRobotView,
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
    required TResult Function(_DisplayGameView value) displayGameView,
    required TResult Function(_DisplayGameOver value) displayGameOver,
    required TResult Function(_DisplayGameWin value) displayGameWin,
    required TResult Function(_DisplayTutorialView value) displayTutorialView,
    required TResult Function(_DisplayRobotView value) displayRobotView,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_DisplayGameView value)? displayGameView,
    TResult? Function(_DisplayGameOver value)? displayGameOver,
    TResult? Function(_DisplayGameWin value)? displayGameWin,
    TResult? Function(_DisplayTutorialView value)? displayTutorialView,
    TResult? Function(_DisplayRobotView value)? displayRobotView,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayGameView value)? displayGameView,
    TResult Function(_DisplayGameOver value)? displayGameOver,
    TResult Function(_DisplayGameWin value)? displayGameWin,
    TResult Function(_DisplayTutorialView value)? displayTutorialView,
    TResult Function(_DisplayRobotView value)? displayRobotView,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements GameScreenViewState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$DisplayGameViewImplCopyWith<$Res> {
  factory _$$DisplayGameViewImplCopyWith(_$DisplayGameViewImpl value,
          $Res Function(_$DisplayGameViewImpl) then) =
      __$$DisplayGameViewImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DisplayGameViewImplCopyWithImpl<$Res>
    extends _$GameScreenViewStateCopyWithImpl<$Res, _$DisplayGameViewImpl>
    implements _$$DisplayGameViewImplCopyWith<$Res> {
  __$$DisplayGameViewImplCopyWithImpl(
      _$DisplayGameViewImpl _value, $Res Function(_$DisplayGameViewImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DisplayGameViewImpl implements _DisplayGameView {
  const _$DisplayGameViewImpl();

  @override
  String toString() {
    return 'GameScreenViewState.displayGameView()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DisplayGameViewImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() displayGameView,
    required TResult Function() displayGameOver,
    required TResult Function() displayGameWin,
    required TResult Function() displayTutorialView,
    required TResult Function() displayRobotView,
  }) {
    return displayGameView();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? displayGameView,
    TResult? Function()? displayGameOver,
    TResult? Function()? displayGameWin,
    TResult? Function()? displayTutorialView,
    TResult? Function()? displayRobotView,
  }) {
    return displayGameView?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? displayGameView,
    TResult Function()? displayGameOver,
    TResult Function()? displayGameWin,
    TResult Function()? displayTutorialView,
    TResult Function()? displayRobotView,
    required TResult orElse(),
  }) {
    if (displayGameView != null) {
      return displayGameView();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_DisplayGameView value) displayGameView,
    required TResult Function(_DisplayGameOver value) displayGameOver,
    required TResult Function(_DisplayGameWin value) displayGameWin,
    required TResult Function(_DisplayTutorialView value) displayTutorialView,
    required TResult Function(_DisplayRobotView value) displayRobotView,
  }) {
    return displayGameView(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_DisplayGameView value)? displayGameView,
    TResult? Function(_DisplayGameOver value)? displayGameOver,
    TResult? Function(_DisplayGameWin value)? displayGameWin,
    TResult? Function(_DisplayTutorialView value)? displayTutorialView,
    TResult? Function(_DisplayRobotView value)? displayRobotView,
  }) {
    return displayGameView?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayGameView value)? displayGameView,
    TResult Function(_DisplayGameOver value)? displayGameOver,
    TResult Function(_DisplayGameWin value)? displayGameWin,
    TResult Function(_DisplayTutorialView value)? displayTutorialView,
    TResult Function(_DisplayRobotView value)? displayRobotView,
    required TResult orElse(),
  }) {
    if (displayGameView != null) {
      return displayGameView(this);
    }
    return orElse();
  }
}

abstract class _DisplayGameView implements GameScreenViewState {
  const factory _DisplayGameView() = _$DisplayGameViewImpl;
}

/// @nodoc
abstract class _$$DisplayGameOverImplCopyWith<$Res> {
  factory _$$DisplayGameOverImplCopyWith(_$DisplayGameOverImpl value,
          $Res Function(_$DisplayGameOverImpl) then) =
      __$$DisplayGameOverImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DisplayGameOverImplCopyWithImpl<$Res>
    extends _$GameScreenViewStateCopyWithImpl<$Res, _$DisplayGameOverImpl>
    implements _$$DisplayGameOverImplCopyWith<$Res> {
  __$$DisplayGameOverImplCopyWithImpl(
      _$DisplayGameOverImpl _value, $Res Function(_$DisplayGameOverImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DisplayGameOverImpl implements _DisplayGameOver {
  const _$DisplayGameOverImpl();

  @override
  String toString() {
    return 'GameScreenViewState.displayGameOver()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DisplayGameOverImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() displayGameView,
    required TResult Function() displayGameOver,
    required TResult Function() displayGameWin,
    required TResult Function() displayTutorialView,
    required TResult Function() displayRobotView,
  }) {
    return displayGameOver();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? displayGameView,
    TResult? Function()? displayGameOver,
    TResult? Function()? displayGameWin,
    TResult? Function()? displayTutorialView,
    TResult? Function()? displayRobotView,
  }) {
    return displayGameOver?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? displayGameView,
    TResult Function()? displayGameOver,
    TResult Function()? displayGameWin,
    TResult Function()? displayTutorialView,
    TResult Function()? displayRobotView,
    required TResult orElse(),
  }) {
    if (displayGameOver != null) {
      return displayGameOver();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_DisplayGameView value) displayGameView,
    required TResult Function(_DisplayGameOver value) displayGameOver,
    required TResult Function(_DisplayGameWin value) displayGameWin,
    required TResult Function(_DisplayTutorialView value) displayTutorialView,
    required TResult Function(_DisplayRobotView value) displayRobotView,
  }) {
    return displayGameOver(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_DisplayGameView value)? displayGameView,
    TResult? Function(_DisplayGameOver value)? displayGameOver,
    TResult? Function(_DisplayGameWin value)? displayGameWin,
    TResult? Function(_DisplayTutorialView value)? displayTutorialView,
    TResult? Function(_DisplayRobotView value)? displayRobotView,
  }) {
    return displayGameOver?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayGameView value)? displayGameView,
    TResult Function(_DisplayGameOver value)? displayGameOver,
    TResult Function(_DisplayGameWin value)? displayGameWin,
    TResult Function(_DisplayTutorialView value)? displayTutorialView,
    TResult Function(_DisplayRobotView value)? displayRobotView,
    required TResult orElse(),
  }) {
    if (displayGameOver != null) {
      return displayGameOver(this);
    }
    return orElse();
  }
}

abstract class _DisplayGameOver implements GameScreenViewState {
  const factory _DisplayGameOver() = _$DisplayGameOverImpl;
}

/// @nodoc
abstract class _$$DisplayGameWinImplCopyWith<$Res> {
  factory _$$DisplayGameWinImplCopyWith(_$DisplayGameWinImpl value,
          $Res Function(_$DisplayGameWinImpl) then) =
      __$$DisplayGameWinImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DisplayGameWinImplCopyWithImpl<$Res>
    extends _$GameScreenViewStateCopyWithImpl<$Res, _$DisplayGameWinImpl>
    implements _$$DisplayGameWinImplCopyWith<$Res> {
  __$$DisplayGameWinImplCopyWithImpl(
      _$DisplayGameWinImpl _value, $Res Function(_$DisplayGameWinImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DisplayGameWinImpl implements _DisplayGameWin {
  const _$DisplayGameWinImpl();

  @override
  String toString() {
    return 'GameScreenViewState.displayGameWin()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DisplayGameWinImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() displayGameView,
    required TResult Function() displayGameOver,
    required TResult Function() displayGameWin,
    required TResult Function() displayTutorialView,
    required TResult Function() displayRobotView,
  }) {
    return displayGameWin();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? displayGameView,
    TResult? Function()? displayGameOver,
    TResult? Function()? displayGameWin,
    TResult? Function()? displayTutorialView,
    TResult? Function()? displayRobotView,
  }) {
    return displayGameWin?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? displayGameView,
    TResult Function()? displayGameOver,
    TResult Function()? displayGameWin,
    TResult Function()? displayTutorialView,
    TResult Function()? displayRobotView,
    required TResult orElse(),
  }) {
    if (displayGameWin != null) {
      return displayGameWin();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_DisplayGameView value) displayGameView,
    required TResult Function(_DisplayGameOver value) displayGameOver,
    required TResult Function(_DisplayGameWin value) displayGameWin,
    required TResult Function(_DisplayTutorialView value) displayTutorialView,
    required TResult Function(_DisplayRobotView value) displayRobotView,
  }) {
    return displayGameWin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_DisplayGameView value)? displayGameView,
    TResult? Function(_DisplayGameOver value)? displayGameOver,
    TResult? Function(_DisplayGameWin value)? displayGameWin,
    TResult? Function(_DisplayTutorialView value)? displayTutorialView,
    TResult? Function(_DisplayRobotView value)? displayRobotView,
  }) {
    return displayGameWin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayGameView value)? displayGameView,
    TResult Function(_DisplayGameOver value)? displayGameOver,
    TResult Function(_DisplayGameWin value)? displayGameWin,
    TResult Function(_DisplayTutorialView value)? displayTutorialView,
    TResult Function(_DisplayRobotView value)? displayRobotView,
    required TResult orElse(),
  }) {
    if (displayGameWin != null) {
      return displayGameWin(this);
    }
    return orElse();
  }
}

abstract class _DisplayGameWin implements GameScreenViewState {
  const factory _DisplayGameWin() = _$DisplayGameWinImpl;
}

/// @nodoc
abstract class _$$DisplayTutorialViewImplCopyWith<$Res> {
  factory _$$DisplayTutorialViewImplCopyWith(_$DisplayTutorialViewImpl value,
          $Res Function(_$DisplayTutorialViewImpl) then) =
      __$$DisplayTutorialViewImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DisplayTutorialViewImplCopyWithImpl<$Res>
    extends _$GameScreenViewStateCopyWithImpl<$Res, _$DisplayTutorialViewImpl>
    implements _$$DisplayTutorialViewImplCopyWith<$Res> {
  __$$DisplayTutorialViewImplCopyWithImpl(_$DisplayTutorialViewImpl _value,
      $Res Function(_$DisplayTutorialViewImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DisplayTutorialViewImpl implements _DisplayTutorialView {
  const _$DisplayTutorialViewImpl();

  @override
  String toString() {
    return 'GameScreenViewState.displayTutorialView()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DisplayTutorialViewImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() displayGameView,
    required TResult Function() displayGameOver,
    required TResult Function() displayGameWin,
    required TResult Function() displayTutorialView,
    required TResult Function() displayRobotView,
  }) {
    return displayTutorialView();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? displayGameView,
    TResult? Function()? displayGameOver,
    TResult? Function()? displayGameWin,
    TResult? Function()? displayTutorialView,
    TResult? Function()? displayRobotView,
  }) {
    return displayTutorialView?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? displayGameView,
    TResult Function()? displayGameOver,
    TResult Function()? displayGameWin,
    TResult Function()? displayTutorialView,
    TResult Function()? displayRobotView,
    required TResult orElse(),
  }) {
    if (displayTutorialView != null) {
      return displayTutorialView();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_DisplayGameView value) displayGameView,
    required TResult Function(_DisplayGameOver value) displayGameOver,
    required TResult Function(_DisplayGameWin value) displayGameWin,
    required TResult Function(_DisplayTutorialView value) displayTutorialView,
    required TResult Function(_DisplayRobotView value) displayRobotView,
  }) {
    return displayTutorialView(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_DisplayGameView value)? displayGameView,
    TResult? Function(_DisplayGameOver value)? displayGameOver,
    TResult? Function(_DisplayGameWin value)? displayGameWin,
    TResult? Function(_DisplayTutorialView value)? displayTutorialView,
    TResult? Function(_DisplayRobotView value)? displayRobotView,
  }) {
    return displayTutorialView?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayGameView value)? displayGameView,
    TResult Function(_DisplayGameOver value)? displayGameOver,
    TResult Function(_DisplayGameWin value)? displayGameWin,
    TResult Function(_DisplayTutorialView value)? displayTutorialView,
    TResult Function(_DisplayRobotView value)? displayRobotView,
    required TResult orElse(),
  }) {
    if (displayTutorialView != null) {
      return displayTutorialView(this);
    }
    return orElse();
  }
}

abstract class _DisplayTutorialView implements GameScreenViewState {
  const factory _DisplayTutorialView() = _$DisplayTutorialViewImpl;
}

/// @nodoc
abstract class _$$DisplayRobotViewImplCopyWith<$Res> {
  factory _$$DisplayRobotViewImplCopyWith(_$DisplayRobotViewImpl value,
          $Res Function(_$DisplayRobotViewImpl) then) =
      __$$DisplayRobotViewImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DisplayRobotViewImplCopyWithImpl<$Res>
    extends _$GameScreenViewStateCopyWithImpl<$Res, _$DisplayRobotViewImpl>
    implements _$$DisplayRobotViewImplCopyWith<$Res> {
  __$$DisplayRobotViewImplCopyWithImpl(_$DisplayRobotViewImpl _value,
      $Res Function(_$DisplayRobotViewImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DisplayRobotViewImpl implements _DisplayRobotView {
  const _$DisplayRobotViewImpl();

  @override
  String toString() {
    return 'GameScreenViewState.displayRobotView()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DisplayRobotViewImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() displayGameView,
    required TResult Function() displayGameOver,
    required TResult Function() displayGameWin,
    required TResult Function() displayTutorialView,
    required TResult Function() displayRobotView,
  }) {
    return displayRobotView();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? displayGameView,
    TResult? Function()? displayGameOver,
    TResult? Function()? displayGameWin,
    TResult? Function()? displayTutorialView,
    TResult? Function()? displayRobotView,
  }) {
    return displayRobotView?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? displayGameView,
    TResult Function()? displayGameOver,
    TResult Function()? displayGameWin,
    TResult Function()? displayTutorialView,
    TResult Function()? displayRobotView,
    required TResult orElse(),
  }) {
    if (displayRobotView != null) {
      return displayRobotView();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_DisplayGameView value) displayGameView,
    required TResult Function(_DisplayGameOver value) displayGameOver,
    required TResult Function(_DisplayGameWin value) displayGameWin,
    required TResult Function(_DisplayTutorialView value) displayTutorialView,
    required TResult Function(_DisplayRobotView value) displayRobotView,
  }) {
    return displayRobotView(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_DisplayGameView value)? displayGameView,
    TResult? Function(_DisplayGameOver value)? displayGameOver,
    TResult? Function(_DisplayGameWin value)? displayGameWin,
    TResult? Function(_DisplayTutorialView value)? displayTutorialView,
    TResult? Function(_DisplayRobotView value)? displayRobotView,
  }) {
    return displayRobotView?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayGameView value)? displayGameView,
    TResult Function(_DisplayGameOver value)? displayGameOver,
    TResult Function(_DisplayGameWin value)? displayGameWin,
    TResult Function(_DisplayTutorialView value)? displayTutorialView,
    TResult Function(_DisplayRobotView value)? displayRobotView,
    required TResult orElse(),
  }) {
    if (displayRobotView != null) {
      return displayRobotView(this);
    }
    return orElse();
  }
}

abstract class _DisplayRobotView implements GameScreenViewState {
  const factory _DisplayRobotView() = _$DisplayRobotViewImpl;
}
