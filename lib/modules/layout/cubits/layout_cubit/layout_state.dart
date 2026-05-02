import 'package:equatable/equatable.dart';

class LayoutState extends Equatable {
  const LayoutState({this.currentIndex = 0});

  final int currentIndex;

  LayoutState copyWith({int? currentIndex}) =>
      LayoutState(currentIndex: currentIndex ?? this.currentIndex);

  @override
  List<Object?> get props => [currentIndex];
}