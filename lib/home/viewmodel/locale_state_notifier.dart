import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../appmodels/language_list_item_model.dart';
import '../../base/language_manager.dart';
import '../../base/logger_utils.dart';
import '../../injector/injection.dart';
import '../model/locale_state.dart';

class LocaleStateNotifier extends StateNotifier<LocaleState>{
  LocaleStateNotifier() : super(const LocaleState.localeChanged(null)){
    setLocaleFromLocalStorage();
  }

  final _TAG = "LocaleStateNotifier";
  final _logger = locator<LoggerUtils>();
  late LanguageListItemModel currentLocaleListItemModel;
  final languageStream = BehaviorSubject<LanguageListItemModel?>.seeded(null);
  /// Set Locale
  /// Attempts to set the locale if it's in our list of supported locales.
  /// IF NOT: get the first locale that matches our language code and set that
  /// ELSE: do nothing.
  void saveLocale(LanguageListItemModel languageListItemModel) {
    // context.setLocale(Locale('hi', 'IN'));

    currentLocaleListItemModel = languageListItemModel;

    _logger.log(_TAG, "Saving language as ${currentLocaleListItemModel}");
    state = LocaleState.localeChanged(currentLocaleListItemModel);
  }

  void setLocaleFromLocalStorage() {
    LanguageListItemModel model = LanguageManager.instance.hiLanguageListItem;;
    currentLocaleListItemModel = model;
    _logger.log(_TAG, "Current language ${currentLocaleListItemModel}");
  }
}

