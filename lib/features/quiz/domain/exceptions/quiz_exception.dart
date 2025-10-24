// lib/features/quiz/domain/exceptions/quiz_exception.dart

class QuizException implements Exception {
  final String message;
  final String? code; // Optional: for more specific error codes

  const QuizException(this.message, {this.code});

  @override
  String toString() {
    if (code != null) {
      return 'QuizException ($code): $message';
    }
    return 'QuizException: $message';
  }
}