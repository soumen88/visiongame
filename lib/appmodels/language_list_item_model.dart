import 'package:flutter/material.dart';

class LanguageListItemModel {
  final Locale locale;
  final String displayName;

  LanguageListItemModel({required this.locale, required this.displayName});

  static LanguageListItemModel? fromSavedLocaleString(String savedLocaleString){
    List<String> languageListItemModelStringList = savedLocaleString.split('_');
    if(languageListItemModelStringList.length != 3){
      return null;
    }
    return LanguageListItemModel(locale: Locale(languageListItemModelStringList[0], languageListItemModelStringList[1]), displayName: languageListItemModelStringList[2]);
  }

  @override
  String toString() {
    return '${locale.languageCode}_${locale.countryCode}_$displayName';
  }
}
