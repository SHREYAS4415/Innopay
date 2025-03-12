

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quize/logic/quiz_event.dart';
import 'package:quize/logic/quiz_state.dart';

import '../data/models/quiz_repository.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository repository;

  QuizBloc(this.repository) : super(QuizLoading()) {
    on<LoadQuestions>((event, emit) async {
      try {
        final questions = await repository.fetchQuestions();
        emit(QuizLoaded(questions));
      } catch (_) {
        emit(QuizError());
      }
    });
  }
}
