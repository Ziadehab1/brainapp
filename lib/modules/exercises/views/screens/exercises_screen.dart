import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../cubits/exercises_cubit/exercises_cubit.dart';
import '../../cubits/exercises_cubit/exercises_state.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercises')),
      body: BlocBuilder<ExercisesCubit, ExercisesState>(
        builder: (context, state) {
          return switch (state.status) {
            RequestStatus.loading =>
              const Center(child: CircularProgressIndicator()),
            RequestStatus.failure => Center(
                child: Text(state.failure?.message ?? 'Failed to load exercises'),
              ),
            RequestStatus.success => ListView.builder(
                itemCount: state.exercises?.items.length ?? 0,
                itemBuilder: (context, index) {
                  final exercise = state.exercises!.items[index];
                  return ListTile(
                    title: Text(exercise.title),
                    subtitle: Text(exercise.type),
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