

import '../data/models/question.dart';

abstract class QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<Question> questions;
  QuizLoaded(this.questions);
}

class QuizError extends QuizState {}

