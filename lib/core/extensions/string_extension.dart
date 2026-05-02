extension StringExtension on String {
  bool get isNullOrEmpty => isEmpty;

  String capitalize() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  bool get isValidEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  bool get isValidPhone => RegExp(r'^\+?[0-9]{8,15}$').hasMatch(this);
}

extension NullableStringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}