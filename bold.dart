import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FontScreen(),
    );
  }
}

class FontScreen extends StatefulWidget {
  @override
  _FontScreenState createState() => _FontScreenState();
}

class _FontScreenState extends State<FontScreen> {
  TextEditingController textController = TextEditingController();

  double selectedFontSize = 16;

  bool isBold = false;
  bool isItalic = false;
  bool isUnderline = false;

  String displayText = "";

  List<double> fontSizes = [16, 18, 20, 24, 28, 32];

  void showText() {
    setState(() {
      displayText = textController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Font Style App"),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Text Input
            TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: "Enter Text",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            // Dropdown for Font Size
            DropdownButton<double>(
              value: selectedFontSize,
              isExpanded: true,
              items: fontSizes.map((size) {
                return DropdownMenuItem(
                  value: size,
                  child: Text("Font Size: $size"),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedFontSize = value!;
                });
              },
            ),

            SizedBox(height: 20),

            // Checkboxes for Style
            Column(
              children: [
                CheckboxListTile(
                  title: Text("Bold"),
                  value: isBold,
                  onChanged: (value) {
                    setState(() {
                      isBold = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Italic"),
                  value: isItalic,
                  onChanged: (value) {
                    setState(() {
                      isItalic = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Underline"),
                  value: isUnderline,
                  onChanged: (value) {
                    setState(() {
                      isUnderline = value!;
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 10),

            // Show Button
            Center(
              child: ElevatedButton(
                onPressed: showText,
                child: Text("Show"),
              ),
            ),

            SizedBox(height: 20),

            // Display Text
            Center(
              child: Text(
                displayText,
                style: TextStyle(
                  fontSize: selectedFontSize,
                  fontWeight:
                      isBold ? FontWeight.bold : FontWeight.normal,
                  fontStyle:
                      isItalic ? FontStyle.italic : FontStyle.normal,
                  decoration: isUnderline
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
