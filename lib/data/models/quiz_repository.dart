import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class QuizRepository {
  Future<List<Question>> fetchQuestions() async {
    final response = await http.get(Uri.parse('https://opentdb.com/api.php?amount=10'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List).map((e) => Question.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
