import 'package:flutter/material.dart';
import 'package:brainapp/core/constants/constants.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _Step {
  String label;
  bool isDone = false;
  _Step({required this.label});
}

class _FlowTask {
  final String id;
  String title;
  String targetTime;
  List<_Step> steps;
  bool isExpanded = false;
  bool isDone = false;

  _FlowTask({
    required this.id,
    required this.title,
    required this.targetTime,
  }) : steps = [];
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<_FlowTask> _tasks = [];

  void _showAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddTaskSheet(
        onAdd: (title, time) {
          setState(() {
            _tasks.add(_FlowTask(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: title,
              targetTime: time,
            ));
          });
        },
      ),
    );
  }

  void _deleteTask(String id) {
    setState(() => _tasks.removeWhere((t) => t.id == id));
  }

  Future<bool> _confirmDelete(BuildContext context, String title) async {
    return await showDialog<bool>(
          context: context,
          barrierColor: AppColors.barrierDark,
          builder: (ctx) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.error.withValues(alpha: 0.15),
                    ),
                    child: const Icon(Icons.delete_outline_rounded,
                        color: AppColors.error, size: 26),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Delete Task?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '"$title" will be permanently removed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.45),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(ctx, false),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(vertical: 13),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceDark,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(ctx, true),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(vertical: 13),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Center(
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ) ??
        false;
  }

  void _toggleExpand(String id) {
    setState(() {
      final task = _tasks.firstWhere((t) => t.id == id);
      task.isExpanded = !task.isExpanded;
    });
  }

  void _toggleTaskDone(String id) {
    setState(() {
      final task = _tasks.firstWhere((t) => t.id == id);
      task.isDone = !task.isDone;
    });
  }

  void _addStep(String taskId, String label) {
    setState(() {
      _tasks
          .firstWhere((t) => t.id == taskId)
          .steps
          .add(_Step(label: label));
    });
  }

  void _toggleStepDone(String taskId, int stepIndex) {
    setState(() {
      final step =
          _tasks.firstWhere((t) => t.id == taskId).steps[stepIndex];
      step.isDone = !step.isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final listPad = bottomInset + 100;
    final fabBottom = bottomInset + 116;

    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Daily Flow',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Design your day, find your focus',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: _tasks.isEmpty
                    ? Center(
                        child: Text(
                          'No tasks yet.\nTap + to add your first flow.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.2),
                            fontSize: 14,
                            height: 1.7,
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(20, 0, 20, listPad),
                        itemCount: _tasks.length,
                        itemBuilder: (context, i) {
                          final task = _tasks[i];
                          return Dismissible(
                            key: ValueKey(task.id),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (_) =>
                                _confirmDelete(context, task.title),
                            onDismissed: (_) => _deleteTask(task.id),
                            background: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.only(right: 24),
                              decoration: BoxDecoration(
                                color: AppColors.error.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.delete_outline_rounded,
                                color: AppColors.error,
                                size: 26,
                              ),
                            ),
                            child: _FlowTaskCard(
                              task: task,
                              onDelete: () async {
                                final ok = await _confirmDelete(
                                    context, task.title);
                                if (ok) _deleteTask(task.id);
                              },
                              onToggle: () => _toggleExpand(task.id),
                              onToggleDone: () => _toggleTaskDone(task.id),
                              onAddStep: (s) => _addStep(task.id, s),
                              onToggleStep: (idx) =>
                                  _toggleStepDone(task.id, idx),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 20,
          bottom: fabBottom,
          child: GestureDetector(
            onTap: _showAddTaskSheet,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surfaceMedium,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(Icons.add_rounded,
                  color: Colors.white, size: 28),
            ),
          ),
        ),
      ],
    );
  }
}

class _FlowTaskCard extends StatefulWidget {
  final _FlowTask task;
  final Future<void> Function() onDelete;
  final VoidCallback onToggle;
  final VoidCallback onToggleDone;
  final ValueChanged<String> onAddStep;
  final ValueChanged<int> onToggleStep;

  const _FlowTaskCard({
    required this.task,
    required this.onDelete,
    required this.onToggle,
    required this.onToggleDone,
    required this.onAddStep,
    required this.onToggleStep,
  });

  @override
  State<_FlowTaskCard> createState() => _FlowTaskCardState();
}

class _FlowTaskCardState extends State<_FlowTaskCard> {
  bool _addingStep = false;
  final _stepController = TextEditingController();

  @override
  void dispose() {
    _stepController.dispose();
    super.dispose();
  }

  void _submitStep() {
    final text = _stepController.text.trim();
    if (text.isNotEmpty) widget.onAddStep(text);
    _stepController.clear();
    setState(() => _addingStep = false);
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // ── Main row ──
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Tappable done circle
                GestureDetector(
                  onTap: widget.onToggleDone,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: task.isDone
                          ? AppColors.primary.withValues(alpha: 0.2)
                          : AppColors.surfaceMedium,
                      border: task.isDone
                          ? Border.all(
                              color: AppColors.primary.withValues(alpha: 0.6),
                              width: 1.5)
                          : null,
                    ),
                    child: Icon(
                      task.isDone
                          ? Icons.check_circle_rounded
                          : Icons.task_alt_rounded,
                      color: task.isDone
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.6),
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          color: task.isDone
                              ? Colors.white.withValues(alpha: 0.35)
                              : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          decoration: task.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor:
                              Colors.white.withValues(alpha: 0.35),
                        ),
                      ),
                      if (task.targetTime.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.access_time_rounded,
                                color: AppColors.primary, size: 12),
                            const SizedBox(width: 4),
                            Text(
                              task.targetTime,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline_rounded,
                      color: Colors.white.withValues(alpha: 0.3),
                      size: 20),
                  onPressed: widget.onDelete,
                  splashRadius: 20,
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints(minWidth: 36, minHeight: 36),
                ),
                IconButton(
                  icon: Icon(
                    task.isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: Colors.white.withValues(alpha: 0.3),
                    size: 22,
                  ),
                  onPressed: widget.onToggle,
                  splashRadius: 20,
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints(minWidth: 36, minHeight: 36),
                ),
              ],
            ),
          ),

          // ── Expanded steps ──
          if (task.isExpanded) ...[
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              color: AppColors.divider,
            ),
            ...task.steps.asMap().entries.map((e) {
              final idx = e.key;
              final step = e.value;
              return _StepRow(
                label: step.label,
                isDone: step.isDone,
                onToggle: () => widget.onToggleStep(idx),
              );
            }),

            // Inline add-step input
            if (_addingStep)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surfaceMedium,
                        border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            width: 1),
                      ),
                      child: const Icon(Icons.check_circle_outline_rounded,
                          color: AppColors.primary, size: 16),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _stepController,
                        autofocus: true,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14),
                        cursorColor: AppColors.primary,
                        decoration: InputDecoration(
                          hintText: 'Step description...',
                          hintStyle: TextStyle(
                              color: Colors.white.withValues(alpha: 0.3),
                              fontSize: 14),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onSubmitted: (_) => _submitStep(),
                      ),
                    ),
                    GestureDetector(
                      onTap: _submitStep,
                      child: const Icon(Icons.check_rounded,
                          color: AppColors.primary, size: 20),
                    ),
                  ],
                ),
              ),

            // "+ ADD DESCRIPTION/STEP" — always visible, tap to open input
            GestureDetector(
              onTap: () => setState(() => _addingStep = true),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    16, _addingStep ? 4 : 10, 16, 14),
                child: Row(
                  children: [
                    const Icon(Icons.add_rounded,
                        color: AppColors.primary, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'ADD DESCRIPTION/STEP',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final String label;
  final bool isDone;
  final VoidCallback onToggle;

  const _StepRow({
    required this.label,
    required this.isDone,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone
                    ? AppColors.primary.withValues(alpha: 0.2)
                    : AppColors.surfaceMedium,
                border: isDone
                    ? Border.all(
                        color: AppColors.primary.withValues(alpha: 0.6),
                        width: 1)
                    : null,
              ),
              child: Icon(
                isDone
                    ? Icons.check_circle_rounded
                    : Icons.check_circle_outline_rounded,
                color: isDone
                    ? AppColors.primary
                    : AppColors.primary.withValues(alpha: 0.5),
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: isDone
                      ? Colors.white.withValues(alpha: 0.35)
                      : Colors.white,
                  fontSize: 14,
                  decoration: isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: Colors.white.withValues(alpha: 0.35),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddTaskSheet extends StatefulWidget {
  final void Function(String title, String time) onAdd;
  const _AddTaskSheet({required this.onAdd});

  @override
  State<_AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<_AddTaskSheet> {
  final _titleController = TextEditingController();
  String _timeText = '';

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.primary,
            surface: AppColors.surfaceDark,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null && mounted) {
      setState(() => _timeText = picked.format(context));
    }
  }

  void _submit() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;
    widget.onAdd(title, _timeText);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(24, 12, 24, 24 + bottom),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.sheetHandle,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'New Flow Task',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'MAIN TASK TITLE',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                hintText: 'e.g., Critical Project Focus',
                hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.25),
                    fontSize: 15),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'TARGET TIME',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _pickTime,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _timeText.isEmpty ? '--:--  --' : _timeText,
                      style: TextStyle(
                        color: _timeText.isEmpty
                            ? Colors.white.withValues(alpha: 0.25)
                            : Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Icon(Icons.access_time_rounded,
                      color: Colors.white.withValues(alpha: 0.3),
                      size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppColors.cancelText,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: _submit,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text(
                        'Add to Flow',
                        style: TextStyle(
                          color: AppColors.surfaceDeep,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
