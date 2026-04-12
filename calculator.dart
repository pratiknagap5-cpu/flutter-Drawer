import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String input = "";
  String result = "0";

  void onButtonClick(String value) {
    setState(() {
      if (value == "C") {
        input = "";
        result = "0";
      } else if (value == "=") {
        calculate();
      } else {
        input += value;
      }
    });
  }

  void calculate() {
    try {
      String finalInput = input.replaceAll("×", "*").replaceAll("÷", "/");
      result = _evaluate(finalInput).toString();
    } catch (e) {
      result = "Error";
    }
  }

  double _evaluate(String expression) {
    // Simple parser (basic)
    List<String> tokens = expression.split(RegExp(r'(?<=[-+*/])|(?=[-+*/])'));
    double res = double.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i += 2) {
      String op = tokens[i];
      double num = double.parse(tokens[i + 1]);

      if (op == "+") res += num;
      if (op == "-") res -= num;
      if (op == "*") res *= num;
      if (op == "/") res /= num;
    }

    return res;
  }

  Widget buildButton(String text, {Color? color}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20),
        backgroundColor: color ?? Colors.blue,
      ),
      onPressed: () => onButtonClick(text),
      child: Text(
        text,
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        children: [
          // DISPLAY
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(fontSize: 28, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    result,
                    style: TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          // GRID BUTTONS
          Expanded(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 4,
              children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("÷", color: Colors.orange),

                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("×", color: Colors.orange),

                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-", color: Colors.orange),

                buildButton("0"),
                buildButton("C", color: Colors.red),
                buildButton("=" , color: Colors.green),
                buildButton("+", color: Colors.orange),
              ],
            ),
          )
        ],
      ),
    );
  }
}
