import 'package:flutter/material.dart';

void main() {
  runApp(AlphabetApp());
}

class AlphabetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AlphabetScreen(),
    );
  }
}

class AlphabetScreen extends StatefulWidget {
  @override
  _AlphabetScreenState createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> {
  String selectedLetter = '';
  String imagePath = '';

  List<String> alphabets =
      List.generate(26, (index) => String.fromCharCode(65 + index));

  void showImage(String letter) {
    setState(() {
      selectedLetter = letter;
      imagePath = 'assets/images/${letter.toLowerCase()}.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alphabet App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: alphabets.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => showImage(alphabets[index]),
                  child: Card(
                    child: Center(
                      child: Text(
                        alphabets[index],
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          if (imagePath.isNotEmpty)
            Column(
              children: [
                Text(
                  "Selected: $selectedLetter",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Image.asset(
                  imagePath,
                  height: 150,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
