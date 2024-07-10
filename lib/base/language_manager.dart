import 'package:flutter/material.dart';

import '../appmodels/language_list_item_model.dart';

class LanguageManager {
  static final LanguageManager _instance = LanguageManager._init();
  static LanguageManager get instance => _instance;

  LanguageManager._init(){
    hiLanguageListItem = LanguageListItemModel(locale: hiLocale, displayName: 'Hindi');
    enLanguageListItem = LanguageListItemModel(locale: enLocale, displayName: 'English');
    enLocale.toLanguageTag();
  }

  final enLocale = Locale('en', 'US');
  final hiLocale = Locale('hi', 'IN');
  late final LanguageListItemModel hiLanguageListItem;
  late final LanguageListItemModel enLanguageListItem;

  List<Locale> get supportedLocales => [enLocale, hiLocale];

  ///This helps in showing options to change or select language in UI
  List<LanguageListItemModel> get supportedLanguageList => [enLanguageListItem, hiLanguageListItem];

  LanguageListItemModel getEnglishLang(){
    return enLanguageListItem;
  }

  LanguageListItemModel getHindiLang(){
    return hiLanguageListItem;
  }
}
