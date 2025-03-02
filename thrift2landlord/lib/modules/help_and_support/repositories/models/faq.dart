part of './../../index.dart';

class FAQuestions {
  final String question;
  final String answer;

  FAQuestions({required this.question, required this.answer});

  factory FAQuestions.fromMap(Map<String, dynamic> data) {
    return FAQuestions(
      question: data['question'] ?? '',
      answer: data['answer'] ?? '',
    );
  }
}
