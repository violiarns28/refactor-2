import 'package:dot_coaching/feats/feats.dart';
import 'package:flutter/material.dart';

class QuestionFormScreen extends StatefulWidget {
  final ExamModel exam;
  final List<QuestionModel>? questions;
  const QuestionFormScreen({
    super.key,
    required this.exam,
    this.questions,
  });

  @override
  State<QuestionFormScreen> createState() => _QuestionFormScreenState();
}

class _QuestionFormScreenState extends State<QuestionFormScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
