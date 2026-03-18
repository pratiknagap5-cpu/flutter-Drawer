import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  int questionIndex = 0;
  int score = 0;

  final List<Map<String, Object>> questions = [
    {
      'question': 'What is Flutter?',
      'options': [
        'Programming Language',
        'SDK for App Development',
        'Database',
        'Operating System'
      ],
      'answer': 1
    },
    {
      'question': 'Which language is used in Flutter?',
      'options': [
        'Java',
        'Kotlin',
        'Dart',
        'Python'
      ],
      'answer': 2
    },
    {
      'question': 'Who developed Flutter?',
      'options': [
        'Facebook',
        'Google',
        'Microsoft',
        'Apple'
      ],
      'answer': 1
    }
  ];

  void answerQuestion(int selectedIndex) {

    if (selectedIndex == questions[questionIndex]['answer']) {
      score++;
    }

    setState(() {
      questionIndex++;
    });
  }

  void restartQuiz() {
    setState(() {
      questionIndex = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (questionIndex < questions.length) {

      var question = questions[questionIndex];

      return Scaffold(
        appBar: AppBar(
          title: const Text("Quiz App"),
          centerTitle: true,
        ),

        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Text(
                question['question'] as String,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              ...(question['options'] as List<String>).asMap().entries.map((entry) {

                int index = entry.key;
                String option = entry.value;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ElevatedButton(
                    onPressed: () => answerQuestion(index),
                    child: Text(option),
                  ),
                );

              }).toList()
            ],
          ),
        ),
      );
    }

    else {

      return Scaffold(
        appBar: AppBar(
          title: const Text("Quiz Result"),
          centerTitle: true,
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                "Your Score: $score / ${questions.length}",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: restartQuiz,
                child: const Text("Restart Quiz"),
              )
            ],
          ),
        ),
      );
    }
  }
}
