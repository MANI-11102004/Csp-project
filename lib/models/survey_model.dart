class SurveyQuestion {
  final String id;
  final String question;
  final String questionTe;
  final List<String> options;
  final List<String> optionsTe;
  final String? selectedAnswer;
  final int correctAnswerIndex;

  SurveyQuestion({
    required this.id,
    required this.question,
    required this.questionTe,
    required this.options,
    required this.optionsTe,
    this.selectedAnswer,
    required this.correctAnswerIndex,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'questionTe': questionTe,
      'options': options,
      'optionsTe': optionsTe,
      'selectedAnswer': selectedAnswer,
      'correctAnswerIndex': correctAnswerIndex,
    };
  }
}

class SurveyResult {
  final int? id;
  final int totalQuestions;
  final int correctAnswers;
  final DateTime completedAt;

  SurveyResult({
    this.id,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.completedAt,
  });

  double get scorePercentage =>
      totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0;

  String get literacyLevel {
    final score = scorePercentage;
    if (score >= 80) return 'Advanced';
    if (score >= 60) return 'Intermediate';
    if (score >= 40) return 'Basic';
    return 'Beginner';
  }

  Map<String, dynamic> toMap() {
    return {
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'completedAt': completedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'scorePercentage': scorePercentage,
      'literacyLevel': literacyLevel,
      'completedAt': completedAt.toIso8601String(),
    };
  }

  factory SurveyResult.fromFirestore(Map<String, dynamic> map) {
    return SurveyResult(
      totalQuestions: map['totalQuestions'] as int? ?? 0,
      correctAnswers: map['correctAnswers'] as int? ?? 0,
      completedAt: DateTime.parse(map['completedAt'] as String),
    );
  }

  factory SurveyResult.fromMapSQLite(Map<String, dynamic> map) {
    return SurveyResult(
      id: map['id'] as int?,
      totalQuestions: map['total_questions'] as int? ?? 0,
      correctAnswers: map['correct_answers'] as int? ?? 0,
      completedAt: DateTime.parse(map['completed_at'] as String),
    );
  }
}
