import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController controller = TextEditingController();
  String result = "";

  void calculateSquare() {
    int num = int.parse(controller.text);
    setState(() {
      result = "Square = ${num * num}";
    });
  }

  void calculateCube() {
    int num = int.parse(controller.text);
    setState(() {
      result = "Cube = ${num * num * num}";
    });
  }

  void checkEvenOdd() {
    int num = int.parse(controller.text);
    setState(() {
      result = (num % 2 == 0) ? "Even Number" : "Odd Number";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Number Operations"),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [

            // Input Field
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter a number",
              ),
            ),

            SizedBox(height: 20),

            // Buttons Row (Row Layout)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: calculateSquare,
                  child: Text("Square"),
                ),
                ElevatedButton(
                  onPressed: calculateCube,
                  child: Text("Cube"),
                ),
                ElevatedButton(
                  onPressed: checkEvenOdd,
                  child: Text("Even/Odd"),
                ),
              ],
            ),

            SizedBox(height: 30),

            // Result Card (Card Layout)
            Expanded(
              child: Center(
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      result,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
