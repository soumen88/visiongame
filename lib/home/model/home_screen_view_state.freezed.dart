// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_screen_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeScreenViewState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() homeView,
    required TResult Function() chooseLanguageView,
    required TResult Function() permissionDeniedView,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? homeView,
    TResult? Function()? chooseLanguageView,
    TResult? Function()? permissionDeniedView,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? chooseLanguageView,
    TResult Function()? permissionDeniedView,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_HomeView value) homeView,
    required TResult Function(_ChooseLanguageView value) chooseLanguageView,
    required TResult Function(_PermissionDeniedView value) permissionDeniedView,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_HomeView value)? homeView,
    TResult? Function(_ChooseLanguageView value)? chooseLanguageView,
    TResult? Function(_PermissionDeniedView value)? permissionDeniedView,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_HomeView value)? homeView,
    TResult Function(_ChooseLanguageView value)? chooseLanguageView,
    TResult Function(_PermissionDeniedView value)? permissionDeniedView,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeScreenViewStateCopyWith<$Res> {
  factory $HomeScreenViewStateCopyWith(
          HomeScreenViewState value, $Res Function(HomeScreenViewState) then) =
      _$HomeScreenViewStateCopyWithImpl<$Res, HomeScreenViewState>;
}

/// @nodoc
class _$HomeScreenViewStateCopyWithImpl<$Res, $Val extends HomeScreenViewState>
    implements $HomeScreenViewStateCopyWith<$Res> {
  _$HomeScreenViewStateCopyWithImpl(this._value, this._then);

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
    extends _$HomeScreenViewStateCopyWithImpl<$Res, _$ErrorImpl>
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
    return 'HomeScreenViewState.error(errorMessage: $errorMessage)';
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
    required TResult Function() chooseLanguageView,
    required TResult Function() permissionDeniedView,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? homeView,
    TResult? Function()? chooseLanguageView,
    TResult? Function()? permissionDeniedView,
  }) {
    return error?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? chooseLanguageView,
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
    required TResult Function(_ChooseLanguageView value) chooseLanguageView,
    required TResult Function(_PermissionDeniedView value) permissionDeniedView,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_HomeView value)? homeView,
    TResult? Function(_ChooseLanguageView value)? chooseLanguageView,
    TResult? Function(_PermissionDeniedView value)? permissionDeniedView,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_HomeView value)? homeView,
    TResult Function(_ChooseLanguageView value)? chooseLanguageView,
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
    extends _$HomeScreenViewStateCopyWithImpl<$Res, _$LoadingImpl>
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
    return 'HomeScreenViewState.loading()';
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
    required TResult Function() chooseLanguageView,
    required TResult Function() permissionDeniedView,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? homeView,
    TResult? Function()? chooseLanguageView,
    TResult? Function()? permissionDeniedView,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? chooseLanguageView,
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
    required TResult Function(_ChooseLanguageView value) chooseLanguageView,
    required TResult Function(_PermissionDeniedView value) permissionDeniedView,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_HomeView value)? homeView,
    TResult? Function(_ChooseLanguageView value)? chooseLanguageView,
    TResult? Function(_PermissionDeniedView value)? permissionDeniedView,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_HomeView value)? homeView,
    TResult Function(_ChooseLanguageView value)? chooseLanguageView,
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
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$HomeViewImplCopyWith<$Res> {
  factory _$$HomeViewImplCopyWith(
          _$HomeViewImpl value, $Res Function(_$HomeViewImpl) then) =
      __$$HomeViewImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HomeViewImplCopyWithImpl<$Res>
    extends _$HomeScreenViewStateCopyWithImpl<$Res, _$HomeViewImpl>
    implements _$$HomeViewImplCopyWith<$Res> {
  __$$HomeViewImplCopyWithImpl(
      _$HomeViewImpl _value, $Res Function(_$HomeViewImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$HomeViewImpl implements _HomeView {
  const _$HomeViewImpl();

  @override
  String toString() {
    return 'HomeScreenViewState.homeView()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HomeViewImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() homeView,
    required TResult Function() chooseLanguageView,
    required TResult Function() permissionDeniedView,
  }) {
    return homeView();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? homeView,
    TResult? Function()? chooseLanguageView,
    TResult? Function()? permissionDeniedView,
  }) {
    return homeView?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? chooseLanguageView,
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
    required TResult Function(_ChooseLanguageView value) chooseLanguageView,
    required TResult Function(_PermissionDeniedView value) permissionDeniedView,
  }) {
    return homeView(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_HomeView value)? homeView,
    TResult? Function(_ChooseLanguageView value)? chooseLanguageView,
    TResult? Function(_PermissionDeniedView value)? permissionDeniedView,
  }) {
    return homeView?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_HomeView value)? homeView,
    TResult Function(_ChooseLanguageView value)? chooseLanguageView,
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
  const factory _HomeView() = _$HomeViewImpl;
}

/// @nodoc
abstract class _$$ChooseLanguageViewImplCopyWith<$Res> {
  factory _$$ChooseLanguageViewImplCopyWith(_$ChooseLanguageViewImpl value,
          $Res Function(_$ChooseLanguageViewImpl) then) =
      __$$ChooseLanguageViewImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChooseLanguageViewImplCopyWithImpl<$Res>
    extends _$HomeScreenViewStateCopyWithImpl<$Res, _$ChooseLanguageViewImpl>
    implements _$$ChooseLanguageViewImplCopyWith<$Res> {
  __$$ChooseLanguageViewImplCopyWithImpl(_$ChooseLanguageViewImpl _value,
      $Res Function(_$ChooseLanguageViewImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ChooseLanguageViewImpl implements _ChooseLanguageView {
  const _$ChooseLanguageViewImpl();

  @override
  String toString() {
    return 'HomeScreenViewState.chooseLanguageView()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChooseLanguageViewImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() homeView,
    required TResult Function() chooseLanguageView,
    required TResult Function() permissionDeniedView,
  }) {
    return chooseLanguageView();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? homeView,
    TResult? Function()? chooseLanguageView,
    TResult? Function()? permissionDeniedView,
  }) {
    return chooseLanguageView?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? chooseLanguageView,
    TResult Function()? permissionDeniedView,
    required TResult orElse(),
  }) {
    if (chooseLanguageView != null) {
      return chooseLanguageView();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Error value) error,
    required TResult Function(_Loading value) loading,
    required TResult Function(_HomeView value) homeView,
    required TResult Function(_ChooseLanguageView value) chooseLanguageView,
    required TResult Function(_PermissionDeniedView value) permissionDeniedView,
  }) {
    return chooseLanguageView(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_HomeView value)? homeView,
    TResult? Function(_ChooseLanguageView value)? chooseLanguageView,
    TResult? Function(_PermissionDeniedView value)? permissionDeniedView,
  }) {
    return chooseLanguageView?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_HomeView value)? homeView,
    TResult Function(_ChooseLanguageView value)? chooseLanguageView,
    TResult Function(_PermissionDeniedView value)? permissionDeniedView,
    required TResult orElse(),
  }) {
    if (chooseLanguageView != null) {
      return chooseLanguageView(this);
    }
    return orElse();
  }
}

abstract class _ChooseLanguageView implements HomeScreenViewState {
  const factory _ChooseLanguageView() = _$ChooseLanguageViewImpl;
}

/// @nodoc
abstract class _$$PermissionDeniedViewImplCopyWith<$Res> {
  factory _$$PermissionDeniedViewImplCopyWith(_$PermissionDeniedViewImpl value,
          $Res Function(_$PermissionDeniedViewImpl) then) =
      __$$PermissionDeniedViewImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PermissionDeniedViewImplCopyWithImpl<$Res>
    extends _$HomeScreenViewStateCopyWithImpl<$Res, _$PermissionDeniedViewImpl>
    implements _$$PermissionDeniedViewImplCopyWith<$Res> {
  __$$PermissionDeniedViewImplCopyWithImpl(_$PermissionDeniedViewImpl _value,
      $Res Function(_$PermissionDeniedViewImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PermissionDeniedViewImpl implements _PermissionDeniedView {
  const _$PermissionDeniedViewImpl();

  @override
  String toString() {
    return 'HomeScreenViewState.permissionDeniedView()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionDeniedViewImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorMessage) error,
    required TResult Function() loading,
    required TResult Function() homeView,
    required TResult Function() chooseLanguageView,
    required TResult Function() permissionDeniedView,
  }) {
    return permissionDeniedView();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String errorMessage)? error,
    TResult? Function()? loading,
    TResult? Function()? homeView,
    TResult? Function()? chooseLanguageView,
    TResult? Function()? permissionDeniedView,
  }) {
    return permissionDeniedView?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorMessage)? error,
    TResult Function()? loading,
    TResult Function()? homeView,
    TResult Function()? chooseLanguageView,
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
    required TResult Function(_ChooseLanguageView value) chooseLanguageView,
    required TResult Function(_PermissionDeniedView value) permissionDeniedView,
  }) {
    return permissionDeniedView(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Error value)? error,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_HomeView value)? homeView,
    TResult? Function(_ChooseLanguageView value)? chooseLanguageView,
    TResult? Function(_PermissionDeniedView value)? permissionDeniedView,
  }) {
    return permissionDeniedView?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Error value)? error,
    TResult Function(_Loading value)? loading,
    TResult Function(_HomeView value)? homeView,
    TResult Function(_ChooseLanguageView value)? chooseLanguageView,
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
  const factory _PermissionDeniedView() = _$PermissionDeniedViewImpl;
}
