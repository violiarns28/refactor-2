import 'package:dot_coaching/core/core.dart';
import 'package:dot_coaching/feats/feats.dart';
import 'package:dot_coaching/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamDetailScreen extends StatefulWidget {
  final ExamModel exam;
  const ExamDetailScreen({super.key, required this.exam});

  @override
  State<ExamDetailScreen> createState() => _ExamDetailScreenState();
}

class _ExamDetailScreenState extends State<ExamDetailScreen> {
  @override
  void initState() {
    context
        .read<QuestionCubit>()
        .getAll(const PaginationParams(), widget.exam.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      body: RoundedTopBackground(
        title: widget.exam.title,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            H1Text('Exam Detail'),
            SizedBox(height: 8.h),
            EightContainer(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  H2Text('Title : ${widget.exam.title}'),
                  if (widget.exam.dueAt != null) ...[
                    H5Text('Due date : ${widget.exam.dueAt!.toDayMonthYear()}'),
                  ],
                  if (widget.exam.description != null)
                    H5Text(
                      'Description : ${widget.exam.description}',
                    ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            H1Text('Questions'),
            SizedBox(height: 8.h),
            BlocBuilder<QuestionCubit, QuestionState>(
              builder: (context, state) {
                return ListQuestion(
                  questions: state.questions,
                  isLoading: state.state == BaseState.loading,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
