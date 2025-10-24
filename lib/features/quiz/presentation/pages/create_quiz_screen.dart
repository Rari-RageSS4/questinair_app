import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/question_entity.dart';
import '../../domain/entities/quiz_entity.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_event.dart';
import '../bloc/quiz_state.dart';

class TempQuestion {
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> optionControllers =
      List.generate(4, (_) => TextEditingController());
  int correctIndex = 0;
}

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({super.key});

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final _titleController = TextEditingController();
  final List<TempQuestion> _tempQuestions = [];

  void _addNewQuestion() {
    setState(() {
      _tempQuestions.add(TempQuestion());
    });
  }

  void _createQuiz() {
    if (_titleController.text.trim().isEmpty || _tempQuestions.isEmpty) return;

    final questions = _tempQuestions.map((temp) {
      return QuestionEntity(
        question: temp.questionController.text.trim(),
        options: temp.optionControllers.map((c) => c.text.trim()).toList(),
        correctIndex: temp.correctIndex,
      );
    }).toList();

    final quiz = QuizEntity(
      id: const Uuid().v4(),
      title: _titleController.text.trim(),
      createdBy: FirebaseAuth.instance.currentUser?.uid ?? "unknown",
      questions: questions,
    );

    context.read<QuizBloc>().add(CreateQuizEvent(quiz));
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (var temp in _tempQuestions) {
      temp.questionController.dispose();
      for (var c in temp.optionControllers) {
        c.dispose();
      }
    }
    super.dispose();
  }

  Widget _buildQuestionForm(int index, TempQuestion temp) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: temp.questionController,
              decoration: InputDecoration(labelText: "Question ${index + 1}"),
            ),
            const SizedBox(height: 8),
            for (int i = 0; i < 4; i++)
              ListTile(
                leading: Radio<int>(
                  value: i,
                  groupValue: temp.correctIndex,
                  onChanged: (val) {
                    setState(() => temp.correctIndex = val!);
                  },
                ),
                title: TextField(
                  controller: temp.optionControllers[i],
                  decoration: InputDecoration(labelText: "Option ${i + 1}"),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Create Quiz"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state is QuizLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Saving...')),
            );
          } else if (state is QuizSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Quiz Saved')),
            );
            _clearFields();
          } else if (state is QuizError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
          if (state is QuizCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Quiz created successfully!")),
            );
            Navigator.pop(context); // Go back after creation
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Quiz Title"),
              ),
              const SizedBox(height: 20),
              ..._tempQuestions.asMap().entries.map(
                    (e) => _buildQuestionForm(e.key, e.value),
                  ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Add Question"),
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.white),                     
                ),
                onPressed: _addNewQuestion,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createQuiz,
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.white),                     
                ),
                child: const Text("Create Quiz"),
              ),
              const SizedBox(height: 20),
              BlocBuilder<QuizBloc, QuizState>(
                builder: (context, state) {
                  if (state is QuizLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is QuizError) {
                    return Text("Error: ${state.message}");
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _clearFields() {
    _titleController.clear();
    _tempQuestions.forEach((temp) {
      temp.questionController.clear();
      temp.optionControllers.forEach((c) => c.clear());
      temp.correctIndex = 0;
    });
    _tempQuestions.clear();
    setState(() {});
  }
}
