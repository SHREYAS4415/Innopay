import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quize/presentaion/ui_layer/quiz.ui.dart';
import 'package:quize/presentaion/ui_layer/quiz_page.dart';

import 'data/models/quiz_repository.dart';
import 'logic/quiz_bloc.dart';
import 'logic/quiz_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuizBloc>(
          create: (context) => QuizBloc(QuizRepository())..add(LoadQuestions()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        onGenerateRoute: (settings) {
          if (settings.name == '/score') {
            final int score = settings.arguments as int;
            return MaterialPageRoute(
              builder: (context) => ScorePage(score: score),
            );
          }
          return null;
        },
        home: const QuizHomePage(),
      ),
    );
  }
}
