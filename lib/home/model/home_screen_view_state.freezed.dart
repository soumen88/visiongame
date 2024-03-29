// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'home_screen_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeScreenViewState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() homeView,
    required TResult Function() permissionDeniedView,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? permissionDeniedView,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? permissionDeniedView,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_HomeView value) homeView,
    required TResult Function(_PermissionDeniedView value) permissionDeniedView,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_HomeView value)? homeView,
    TResult Function(_PermissionDeniedView value)? permissionDeniedView,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_HomeView value)? homeView,
    TResult Function(_PermissionDeniedView value)? permissionDeniedView,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeScreenViewStateCopyWith<$Res> {
  factory $HomeScreenViewStateCopyWith(
          HomeScreenViewState value, $Res Function(HomeScreenViewState) then) =
      _$HomeScreenViewStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$HomeScreenViewStateCopyWithImpl<$Res>
    implements $HomeScreenViewStateCopyWith<$Res> {
  _$HomeScreenViewStateCopyWithImpl(this._value, this._then);

  final HomeScreenViewState _value;
  // ignore: unused_field
  final $Res Function(HomeScreenViewState) _then;
}

/// @nodoc
abstract class _$$_ErrorCopyWith<$Res> {
  factory _$$_ErrorCopyWith(_$_Error value, $Res Function(_$_Error) then) =
      __$$_ErrorCopyWithImpl<$Res>;
  $Res call({String errorMessage});
}

/// @nodoc
class __$$_ErrorCopyWithImpl<$Res>
    extends _$HomeScreenViewStateCopyWithImpl<$Res>
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
    return 'HomeScreenViewState.error(errorMessage: $errorMessage)';
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
    required TResult Function() permissionDeniedView,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? permissionDeniedView,
  }) {
    return error?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? permissionDeniedView,
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
    required TResult Function(_HomeView value) homeView,
    required TResult Function(_PermissionDeniedView value) permissionDeniedView,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_HomeView value)? homeView,
    TResult Function(_PermissionDeniedView value)? permissionDeniedView,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_HomeView value)? homeView,
    TResult Function(_PermissionDeniedView value)? permissionDeniedView,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements HomeScreenViewState {
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
    extends _$HomeScreenViewStateCopyWithImpl<$Res>
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
    return 'HomeScreenViewState.loading()';
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
    required TResult Function() permissionDeniedView,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? permissionDeniedView,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? permissionDeniedView,
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
    required TResult Function(_HomeView value) homeView,
    required TResult Function(_PermissionDeniedView value) permissionDeniedView,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_HomeView value)? homeView,
    TResult Function(_PermissionDeniedView value)? permissionDeniedView,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_HomeView value)? homeView,
    TResult Function(_PermissionDeniedView value)? permissionDeniedView,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements HomeScreenViewState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$$_HomeViewCopyWith<$Res> {
  factory _$$_HomeViewCopyWith(
          _$_HomeView value, $Res Function(_$_HomeView) then) =
      __$$_HomeViewCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_HomeViewCopyWithImpl<$Res>
    extends _$HomeScreenViewStateCopyWithImpl<$Res>
    implements _$$_HomeViewCopyWith<$Res> {
  __$$_HomeViewCopyWithImpl(
      _$_HomeView _value, $Res Function(_$_HomeView) _then)
      : super(_value, (v) => _then(v as _$_HomeView));

  @override
  _$_HomeView get _value => super._value as _$_HomeView;
}

/// @nodoc

class _$_HomeView implements _HomeView {
  const _$_HomeView();

  @override
  String toString() {
    return 'HomeScreenViewState.homeView()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_HomeView);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() homeView,
    required TResult Function() permissionDeniedView,
  }) {
    return homeView();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? permissionDeniedView,
  }) {
    return homeView?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? permissionDeniedView,
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
    required TResult Function(_HomeView value) homeView,
    required TResult Function(_PermissionDeniedView value) permissionDeniedView,
  }) {
    return homeView(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_HomeView value)? homeView,
    TResult Function(_PermissionDeniedView value)? permissionDeniedView,
  }) {
    return homeView?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_HomeView value)? homeView,
    TResult Function(_PermissionDeniedView value)? permissionDeniedView,
    required TResult orElse(),
  }) {
    if (homeView != null) {
      return homeView(this);
    }
    return orElse();
  }
}

abstract class _HomeView implements HomeScreenViewState {
  const factory _HomeView() = _$_HomeView;
}

/// @nodoc
abstract class _$$_PermissionDeniedViewCopyWith<$Res> {
  factory _$$_PermissionDeniedViewCopyWith(_$_PermissionDeniedView value,
          $Res Function(_$_PermissionDeniedView) then) =
      __$$_PermissionDeniedViewCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_PermissionDeniedViewCopyWithImpl<$Res>
    extends _$HomeScreenViewStateCopyWithImpl<$Res>
    implements _$$_PermissionDeniedViewCopyWith<$Res> {
  __$$_PermissionDeniedViewCopyWithImpl(_$_PermissionDeniedView _value,
      $Res Function(_$_PermissionDeniedView) _then)
      : super(_value, (v) => _then(v as _$_PermissionDeniedView));

  @override
  _$_PermissionDeniedView get _value => super._value as _$_PermissionDeniedView;
}

/// @nodoc

class _$_PermissionDeniedView implements _PermissionDeniedView {
  const _$_PermissionDeniedView();

  @override
  String toString() {
    return 'HomeScreenViewState.permissionDeniedView()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_PermissionDeniedView);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() homeView,
    required TResult Function() permissionDeniedView,
  }) {
    return permissionDeniedView();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? permissionDeniedView,
  }) {
    return permissionDeniedView?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? permissionDeniedView,
    required TResult orElse(),
  }) {
    if (permissionDeniedView != null) {
      return permissionDeniedView();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_HomeView value) homeView,
    required TResult Function(_PermissionDeniedView value) permissionDeniedView,
  }) {
    return permissionDeniedView(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_HomeView value)? homeView,
    TResult Function(_PermissionDeniedView value)? permissionDeniedView,
  }) {
    return permissionDeniedView?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_HomeView value)? homeView,
    TResult Function(_PermissionDeniedView value)? permissionDeniedView,
    required TResult orElse(),
  }) {
    if (permissionDeniedView != null) {
      return permissionDeniedView(this);
    }
    return orElse();
  }
}

abstract class _PermissionDeniedView implements HomeScreenViewState {
  const factory _PermissionDeniedView() = _$_PermissionDeniedView;
}
