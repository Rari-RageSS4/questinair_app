import 'package:flutter/material.dart';
import 'package:questinair_app/core/constants/app_text_styles.dart';
import 'package:questinair_app/features/quiz/domain/entities/quiz_entity.dart';

class TakeQuizScreen extends StatefulWidget {
  final QuizEntity quiz;

  const TakeQuizScreen({super.key, required this.quiz});

  @override
  State<TakeQuizScreen> createState() => _TakeQuizScreenState();
}

class _TakeQuizScreenState extends State<TakeQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  List<int?> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    selectedAnswers = List<int?>.filled(widget.quiz.questions.length, null);
  }

  void _submitAnswer(int selectedIndex) {
    setState(() {
      selectedAnswers[currentQuestionIndex] = selectedIndex;
      if (selectedIndex == widget.quiz.questions[currentQuestionIndex].correctIndex) {
        score++;
      }
      if (currentQuestionIndex < widget.quiz.questions.length - 1) {
        currentQuestionIndex++;
      } else {
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed', style: AppTextStyles.title),
        content: Text(
          'Your score: $score/${widget.quiz.questions.length}',
          style: AppTextStyles.subtitle,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: AppTextStyles.button),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.quiz.questions[currentQuestionIndex];
    return Scaffold(
      backgroundColor: Colors.transparent, // Use global gradient
      appBar: AppBar(
        title: Text(widget.quiz.title, style: AppTextStyles.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}/${widget.quiz.questions.length}',
              style: AppTextStyles.subtitle,
            ),
            const SizedBox(height: 10),
            Text(question.question, style: AppTextStyles.title),
            const SizedBox(height: 20),
            ...question.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              return RadioListTile<int>(
                title: Text(option, style: AppTextStyles.body),
                value: index,
                groupValue: selectedAnswers[currentQuestionIndex],
                onChanged: (value) => _submitAnswer(value!),
              );
            }),
          ],
        ),
      ),
    );
  }
}