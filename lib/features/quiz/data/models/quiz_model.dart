import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:questinair_app/features/quiz/data/models/question_model.dart';
import 'package:questinair_app/features/quiz/domain/entities/quiz_entity.dart';


class QuizModel {
  final String id;
  final String title;
  final String createdBy;
  final List<QuestionModel> questions;
  final Timestamp createdAt;

  QuizModel({
    required this.id,
    required this.title,
    required this.createdBy,
    required this.questions,
    required this.createdAt,
  });

  factory QuizModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return QuizModel(
      id: doc.id,
      title: data['title'],
      createdBy: data['createdBy'],
      createdAt: data['createdAt'],
      questions: (data['questions'] as List)
          .map((q) => QuestionModel.fromMap(q))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'questions': questions.map((q) => q.toMap()).toList(),
    };
  }

  QuizEntity toEntity() {
    return QuizEntity(
      id: id,
      title: title,
      createdBy: createdBy,
      questions: questions.map((q) => q.toEntity()).toList(),
    );
  }

  factory QuizModel.fromEntity(QuizEntity entity) {
    return QuizModel(
      id: entity.id,
      title: entity.title,
      createdBy: entity.createdBy,
      createdAt: Timestamp.now(),
      questions: entity.questions
          .map((q) => QuestionModel.fromEntity(q))
          .toList(),
    );
  }
}
