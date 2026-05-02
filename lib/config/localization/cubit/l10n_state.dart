import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class L10nState extends Equatable {
  const L10nState({required this.locale});

  final Locale locale;

  static const initial = L10nState(locale: Locale('ar'));

  L10nState copyWith({Locale? locale}) =>
      L10nState(locale: locale ?? this.locale);

  @override
  List<Object?> get props => [locale];
}