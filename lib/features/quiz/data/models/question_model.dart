

import 'package:questinair_app/features/quiz/domain/entities/question_entity.dart';

class QuestionModel {
  final String question;
  final List<String> options;
  final int correctIndex;

  QuestionModel({
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      question: map['question'],
      options: List<String>.from(map['options']),
      correctIndex: map['correctIndex'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correctIndex': correctIndex,
    };
  }

  QuestionEntity toEntity() {
    return QuestionEntity(
      question: question,
      options: options,
      correctIndex: correctIndex,
    );
  }

  factory QuestionModel.fromEntity(QuestionEntity entity) {
    return QuestionModel(
      question: entity.question,
      options: entity.options,
      correctIndex: entity.correctIndex,
    );
  }
}
