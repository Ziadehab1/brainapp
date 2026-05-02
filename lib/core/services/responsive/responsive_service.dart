import 'package:flutter/material.dart';

enum DeviceType { miniPhone, phone, tablet, computer }

class Responsive {
  Responsive._();

  static late double _width;
  static late double _height;

  static void init(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
  }

  static double get width => _width;
  static double get height => _height;

  static DeviceType get deviceType {
    if (_width < 360) return DeviceType.miniPhone;
    if (_width < 600) return DeviceType.phone;
    if (_width < 1024) return DeviceType.tablet;
    return DeviceType.computer;
  }

  static bool get isMiniPhone => deviceType == DeviceType.miniPhone;
  static bool get isPhone => deviceType == DeviceType.phone;
  static bool get isTablet => deviceType == DeviceType.tablet;
  static bool get isComputer => deviceType == DeviceType.computer;

  static double scale(double size) {
    switch (deviceType) {
      case DeviceType.miniPhone:
        return size * 0.85;
      case DeviceType.phone:
        return size;
      case DeviceType.tablet:
        return size * 1.2;
      case DeviceType.computer:
        return size * 1.4;
    }
  }

  static double sp(double size) => scale(size);
  static double w(double size) => _width * (size / 375);
  static double h(double size) => _height * (size / 812);
}