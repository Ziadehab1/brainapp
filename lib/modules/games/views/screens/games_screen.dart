import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../cubits/games_cubit/games_cubit.dart';
import '../../cubits/games_cubit/games_state.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Games')),
      body: BlocBuilder<GamesCubit, GamesState>(
        builder: (context, state) {
          return switch (state.status) {
            RequestStatus.loading =>
              const Center(child: CircularProgressIndicator()),
            RequestStatus.failure => Center(
                child: Text(state.failure?.message ?? 'Failed to load games'),
              ),
            RequestStatus.success => ListView.builder(
                itemCount: state.games?.items.length ?? 0,
                itemBuilder: (context, index) {
                  final game = state.games!.items[index];
                  return ListTile(
                    title: Text(game.title),
                    subtitle: Text(game.category),
                    trailing: Text('Lvl ${game.difficultyLevel}'),
                  );
                },
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}