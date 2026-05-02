import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/navigation/routes.dart';
import '../../cubits/layout_cubit/layout_cubit.dart';
import '../../cubits/layout_cubit/layout_state.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  static final List<_TabItem> _tabs = [
    _TabItem(icon: Icons.home_outlined, label: 'Home', route: Routes.exercises),
    _TabItem(icon: Icons.sports_esports_outlined, label: 'Games', route: Routes.games),
    _TabItem(icon: Icons.person_outline, label: 'Profile', route: Routes.layout),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: _tabs
                .map((_) => const Center(child: Text('Tab content')))
                .toList(),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: state.currentIndex,
            onDestinationSelected: context.read<LayoutCubit>().changeTab,
            destinations: _tabs
                .map((t) => NavigationDestination(
                      icon: Icon(t.icon),
                      label: t.label,
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}

class _TabItem {
  const _TabItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String route;
}