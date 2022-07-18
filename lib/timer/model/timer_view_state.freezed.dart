// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'timer_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TimerViewState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function(bool isTimerVisible, int seconds) displayTime,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function(bool isTimerVisible, int seconds)? displayTime,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function(bool isTimerVisible, int seconds)? displayTime,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_DisplayTime value) displayTime,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayTime value)? displayTime,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayTime value)? displayTime,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerViewStateCopyWith<$Res> {
  factory $TimerViewStateCopyWith(
          TimerViewState value, $Res Function(TimerViewState) then) =
      _$TimerViewStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$TimerViewStateCopyWithImpl<$Res>
    implements $TimerViewStateCopyWith<$Res> {
  _$TimerViewStateCopyWithImpl(this._value, this._then);

  final TimerViewState _value;
  // ignore: unused_field
  final $Res Function(TimerViewState) _then;
}

/// @nodoc
abstract class _$$_ErrorCopyWith<$Res> {
  factory _$$_ErrorCopyWith(_$_Error value, $Res Function(_$_Error) then) =
      __$$_ErrorCopyWithImpl<$Res>;
  $Res call({String errorMessage});
}

/// @nodoc
class __$$_ErrorCopyWithImpl<$Res> extends _$TimerViewStateCopyWithImpl<$Res>
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
    return 'TimerViewState.error(errorMessage: $errorMessage)';
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
    required TResult Function(bool isTimerVisible, int seconds) displayTime,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function(bool isTimerVisible, int seconds)? displayTime,
  }) {
    return error?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function(bool isTimerVisible, int seconds)? displayTime,
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
    required TResult Function(_DisplayTime value) displayTime,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayTime value)? displayTime,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayTime value)? displayTime,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements TimerViewState {
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
class __$$_LoadingCopyWithImpl<$Res> extends _$TimerViewStateCopyWithImpl<$Res>
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
    return 'TimerViewState.loading()';
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
    required TResult Function(bool isTimerVisible, int seconds) displayTime,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function(bool isTimerVisible, int seconds)? displayTime,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function(bool isTimerVisible, int seconds)? displayTime,
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
    required TResult Function(_DisplayTime value) displayTime,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayTime value)? displayTime,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayTime value)? displayTime,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements TimerViewState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$$_DisplayTimeCopyWith<$Res> {
  factory _$$_DisplayTimeCopyWith(
          _$_DisplayTime value, $Res Function(_$_DisplayTime) then) =
      __$$_DisplayTimeCopyWithImpl<$Res>;
  $Res call({bool isTimerVisible, int seconds});
}

/// @nodoc
class __$$_DisplayTimeCopyWithImpl<$Res>
    extends _$TimerViewStateCopyWithImpl<$Res>
    implements _$$_DisplayTimeCopyWith<$Res> {
  __$$_DisplayTimeCopyWithImpl(
      _$_DisplayTime _value, $Res Function(_$_DisplayTime) _then)
      : super(_value, (v) => _then(v as _$_DisplayTime));

  @override
  _$_DisplayTime get _value => super._value as _$_DisplayTime;

  @override
  $Res call({
    Object? isTimerVisible = freezed,
    Object? seconds = freezed,
  }) {
    return _then(_$_DisplayTime(
      isTimerVisible == freezed
          ? _value.isTimerVisible
          : isTimerVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      seconds == freezed
          ? _value.seconds
          : seconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_DisplayTime implements _DisplayTime {
  const _$_DisplayTime(this.isTimerVisible, this.seconds);

  @override
  final bool isTimerVisible;
  @override
  final int seconds;

  @override
  String toString() {
    return 'TimerViewState.displayTime(isTimerVisible: $isTimerVisible, seconds: $seconds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DisplayTime &&
            const DeepCollectionEquality()
                .equals(other.isTimerVisible, isTimerVisible) &&
            const DeepCollectionEquality().equals(other.seconds, seconds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isTimerVisible),
      const DeepCollectionEquality().hash(seconds));

  @JsonKey(ignore: true)
  @override
  _$$_DisplayTimeCopyWith<_$_DisplayTime> get copyWith =>
      __$$_DisplayTimeCopyWithImpl<_$_DisplayTime>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function(bool isTimerVisible, int seconds) displayTime,
  }) {
    return displayTime(isTimerVisible, seconds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function(bool isTimerVisible, int seconds)? displayTime,
  }) {
    return displayTime?.call(isTimerVisible, seconds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function(bool isTimerVisible, int seconds)? displayTime,
    required TResult orElse(),
  }) {
    if (displayTime != null) {
      return displayTime(isTimerVisible, seconds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_DisplayTime value) displayTime,
  }) {
    return displayTime(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayTime value)? displayTime,
  }) {
    return displayTime?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_DisplayTime value)? displayTime,
    required TResult orElse(),
  }) {
    if (displayTime != null) {
      return displayTime(this);
    }
    return orElse();
  }
}

abstract class _DisplayTime implements TimerViewState {
  const factory _DisplayTime(final bool isTimerVisible, final int seconds) =
      _$_DisplayTime;

  bool get isTimerVisible;
  int get seconds;
  @JsonKey(ignore: true)
  _$$_DisplayTimeCopyWith<_$_DisplayTime> get copyWith =>
      throw _privateConstructorUsedError;
}
