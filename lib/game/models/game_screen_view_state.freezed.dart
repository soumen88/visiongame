// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_screen_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameScreenViewState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() displayGameView,
    required TResult Function() displayGameOver,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? displayGameView,
    TResult Function()? displayGameOver,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? displayGameView,
    TResult Function()? displayGameOver,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_DisplayGameView value) displayGameView,
    required TResult Function(_DisplayGameOver value) displayGameOver,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayGameView value)? displayGameView,
    TResult Function(_DisplayGameOver value)? displayGameOver,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayGameView value)? displayGameView,
    TResult Function(_DisplayGameOver value)? displayGameOver,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameScreenViewStateCopyWith<$Res> {
  factory $GameScreenViewStateCopyWith(
          GameScreenViewState value, $Res Function(GameScreenViewState) then) =
      _$GameScreenViewStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$GameScreenViewStateCopyWithImpl<$Res>
    implements $GameScreenViewStateCopyWith<$Res> {
  _$GameScreenViewStateCopyWithImpl(this._value, this._then);

  final GameScreenViewState _value;
  // ignore: unused_field
  final $Res Function(GameScreenViewState) _then;
}

/// @nodoc
abstract class _$$_ErrorCopyWith<$Res> {
  factory _$$_ErrorCopyWith(_$_Error value, $Res Function(_$_Error) then) =
      __$$_ErrorCopyWithImpl<$Res>;
  $Res call({String errorMessage});
}

/// @nodoc
class __$$_ErrorCopyWithImpl<$Res>
    extends _$GameScreenViewStateCopyWithImpl<$Res>
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
    return 'GameScreenViewState.error(errorMessage: $errorMessage)';
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
    required TResult Function() displayGameView,
    required TResult Function() displayGameOver,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? displayGameView,
    TResult Function()? displayGameOver,
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
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayGameView value)? displayGameView,
    TResult Function(_DisplayGameOver value)? displayGameOver,
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
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements GameScreenViewState {
  const factory _Error(final String errorMessage) = _$_Error;

  String get errorMessage => throw _privateConstructorUsedError;
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
    extends _$GameScreenViewStateCopyWithImpl<$Res>
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
    return 'GameScreenViewState.loading()';
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
    required TResult Function() displayGameView,
    required TResult Function() displayGameOver,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? displayGameView,
    TResult Function()? displayGameOver,
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
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayGameView value)? displayGameView,
    TResult Function(_DisplayGameOver value)? displayGameOver,
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
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements GameScreenViewState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$$_DisplayGameViewCopyWith<$Res> {
  factory _$$_DisplayGameViewCopyWith(
          _$_DisplayGameView value, $Res Function(_$_DisplayGameView) then) =
      __$$_DisplayGameViewCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_DisplayGameViewCopyWithImpl<$Res>
    extends _$GameScreenViewStateCopyWithImpl<$Res>
    implements _$$_DisplayGameViewCopyWith<$Res> {
  __$$_DisplayGameViewCopyWithImpl(
      _$_DisplayGameView _value, $Res Function(_$_DisplayGameView) _then)
      : super(_value, (v) => _then(v as _$_DisplayGameView));

  @override
  _$_DisplayGameView get _value => super._value as _$_DisplayGameView;
}

/// @nodoc

class _$_DisplayGameView implements _DisplayGameView {
  const _$_DisplayGameView();

  @override
  String toString() {
    return 'GameScreenViewState.displayGameView()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_DisplayGameView);
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
  }) {
    return displayGameView();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? displayGameView,
    TResult Function()? displayGameOver,
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
  }) {
    return displayGameView(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayGameView value)? displayGameView,
    TResult Function(_DisplayGameOver value)? displayGameOver,
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
    required TResult orElse(),
  }) {
    if (displayGameView != null) {
      return displayGameView(this);
    }
    return orElse();
  }
}

abstract class _DisplayGameView implements GameScreenViewState {
  const factory _DisplayGameView() = _$_DisplayGameView;
}

/// @nodoc
abstract class _$$_DisplayGameOverCopyWith<$Res> {
  factory _$$_DisplayGameOverCopyWith(
          _$_DisplayGameOver value, $Res Function(_$_DisplayGameOver) then) =
      __$$_DisplayGameOverCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_DisplayGameOverCopyWithImpl<$Res>
    extends _$GameScreenViewStateCopyWithImpl<$Res>
    implements _$$_DisplayGameOverCopyWith<$Res> {
  __$$_DisplayGameOverCopyWithImpl(
      _$_DisplayGameOver _value, $Res Function(_$_DisplayGameOver) _then)
      : super(_value, (v) => _then(v as _$_DisplayGameOver));

  @override
  _$_DisplayGameOver get _value => super._value as _$_DisplayGameOver;
}

/// @nodoc

class _$_DisplayGameOver implements _DisplayGameOver {
  const _$_DisplayGameOver();

  @override
  String toString() {
    return 'GameScreenViewState.displayGameOver()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_DisplayGameOver);
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
  }) {
    return displayGameOver();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? displayGameView,
    TResult Function()? displayGameOver,
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
  }) {
    return displayGameOver(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayGameView value)? displayGameView,
    TResult Function(_DisplayGameOver value)? displayGameOver,
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
    required TResult orElse(),
  }) {
    if (displayGameOver != null) {
      return displayGameOver(this);
    }
    return orElse();
  }
}

abstract class _DisplayGameOver implements GameScreenViewState {
  const factory _DisplayGameOver() = _$_DisplayGameOver;
}
