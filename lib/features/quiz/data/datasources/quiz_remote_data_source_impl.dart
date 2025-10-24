// lib/features/quiz/data/datasources/quiz_remote_data_source_impl.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import '../../domain/exceptions/quiz_exception.dart'; // <--- NEW: Import QuizException
import '../models/quiz_model.dart';
import 'quiz_remote_data_source.dart';

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  final FirebaseFirestore firestore;
  final Logger _logger = Logger();

  QuizRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> createQuiz(QuizModel quiz) async {
    try{
      await firestore.collection('quizzes').doc(quiz.id).set(quiz.toMap());
    } on FirebaseException catch (e) { // <--- CHANGED: Catch a specific FirebaseException
      _logger.e('Failed to create quiz: $e');
      throw QuizException('Failed to create quiz: ${e.message}'); // <--- CHANGED: Throw QuizException
    } catch (e) { // <--- NEW: Catch other general exceptions
      _logger.e('An unexpected error occurred while creating quiz: $e');
      throw QuizException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<List<QuizModel>> getAllQuizzes() async {
    try{
      final snapshot = await firestore.collection('quizzes').get();
      return snapshot.docs.map((doc) => QuizModel.fromFirestore(doc)).toList();
    } on FirebaseException catch (e) { // <--- CHANGED: Catch a specific FirebaseException
      _logger.e('Failed to fetch quizzes: $e');
      throw QuizException('Failed to fetch quizzes: ${e.message}'); // <--- CHANGED: Throw QuizException
    } catch (e) { // <--- NEW: Catch other general exceptions
      _logger.e('An unexpected error occurred while fetching quizzes: $e');
      throw QuizException('An unexpected error occurred: $e');
    }
  }
}