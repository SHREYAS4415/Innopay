import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/question.dart';
import '../../logic/quiz_bloc.dart';
import '../../logic/quiz_state.dart';


class QuizHomePage extends StatelessWidget {
  const QuizHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        centerTitle: true,
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuizError) {
            return const Center(child: Text('Failed to load questions'));
          } else if (state is QuizLoaded) {
            return QuestionWidget(questions: state.questions);
          }
          return Container();
        },
      ),
    );
  }
}



class QuestionWidget extends StatefulWidget {
  final List<Question> questions;
  const QuestionWidget({super.key, required this.questions});

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int currentIndex = 0;
  int score = 0;

  void checkAnswer(String selectedAnswer) {
    if (selectedAnswer == widget.questions[currentIndex].correctAnswer) {
      score++;
    }
    if (currentIndex < widget.questions.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      Navigator.pushReplacementNamed(context, '/score', arguments: score);
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentIndex];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Question ${currentIndex + 1} of ${widget.questions.length}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            question.question,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 30),
          ...question.options.map((option) => ElevatedButton(
            onPressed: () => checkAnswer(option),
            child: Text(option),
          )),
        ],
      ),
    );
  }
}

