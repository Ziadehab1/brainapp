import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/local/cache_client.dart';
import '../../../core/services/local/storage_keys.dart';
import 'l10n_state.dart';

class L10nCubit extends Cubit<L10nState> {
  L10nCubit(this._cacheClient) : super(L10nState.initial);

  final CacheClient _cacheClient;

  Future<void> loadSavedLocale() async {
    final saved = _cacheClient.getString(StorageKeys.locale);
    if (saved != null) {
      emit(state.copyWith(locale: Locale(saved)));
    }
  }

  Future<void> changeLocale(Locale locale) async {
    await _cacheClient.setString(StorageKeys.locale, locale.languageCode);
    emit(state.copyWith(locale: locale));
  }

  Future<void> toggleLocale() async {
    final next =
        state.locale.languageCode == 'ar' ? const Locale('en') : const Locale('ar');
    await changeLocale(next);
  }
}