import 'package:freezed_annotation/freezed_annotation.dart';

import '../../appmodels/language_list_item_model.dart';

part 'locale_state.freezed.dart';

@freezed
class LocaleState with _$LocaleState{
  const factory LocaleState.localeChanged(LanguageListItemModel? currentLanguageListItemModel) = _localeChanged;
}
