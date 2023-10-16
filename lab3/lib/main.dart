import 'package:flutter/material.dart';

void main() => runApp(PsychologicalTestApp());

class PsychologicalTestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PsychologicalTest(),
    );
  }
}

class PsychologicalTest extends StatefulWidget {
  @override
  _PsychologicalTestState createState() => _PsychologicalTestState();
}

class _PsychologicalTestState extends State<PsychologicalTest> {
  int questionIndex = 0;
  int score = 0;

  final List<Map<String, dynamic>> questions = [
    {
      'questionText': "Питання 1: Як ви оцінюєте ваш психологічний стан?",
      'answers': <Map<String, Object>>[
        {'text': 'Чудовий', 'score': 10},
        {'text': 'Задовільний', 'score': 5},
        {'text': 'Дуже сумнівний', 'score': 0},
      ],
    },
    {
      'questionText': 'Питання 2: Як часто ви відчуваєте стрес?',
      'answers': <Map<String, Object>>[
        {'text': 'Рідко', 'score': 10},
        {'text': 'Часто', 'score': 0},
      ],
    },
  ];

  void answerQuestion(int score) {
    this.score += score;

    setState(() {
      questionIndex++;
    });
  }

  void resetTest() {
    setState(() {
      questionIndex = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Психологічний тест'),
      ),
      body: questionIndex < questions.length
          ? Column(
              children: [
                Text(
                  questions[questionIndex]['questionText'] as String,
                  style: TextStyle(fontSize: 18),
                ),
                ...(questions[questionIndex]['answers']
                        as List<Map<String, Object>>)
                    .map((answer) {
                  return ElevatedButton(
                    onPressed: () => answerQuestion(answer['score'] as int),
                    child: Text(answer['text'] as String),
                  );
                }).toList(),
              ],
            )
          : Center(
              child: Column(
                children: [
                  Text(
                      "Ви завершили тест! Ваше ментальне здоров'я оцінюється в $score балів з 20"),
                  ElevatedButton(
                    onPressed: resetTest,
                    child: Text('Почати знову'),
                  ),
                ],
              ),
            ),
    );
  }
}
