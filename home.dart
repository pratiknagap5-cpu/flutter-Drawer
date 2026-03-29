import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedValue = "Select";

  List<String> options = [
    "Google",
    "Yahoo",
    "Gmail",
    "Login"
  ];

  void navigateToPage(String value) {
    if (value == "Google") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GoogleScreen()),
      );
    } else if (value == "Yahoo") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => YahooScreen()),
      );
    } else if (value == "Gmail") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GmailScreen()),
      );
    } else if (value == "Login") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dropdown Navigation"),
      ),
      body: Center(
        child: DropdownButton<String>(
          value: selectedValue == "Select" ? null : selectedValue,
          hint: Text("Select Option"),
          items: options.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedValue = value!;
            });
            navigateToPage(value!);
          },
        ),
      ),
    );
  }
}

// Screens

class GoogleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google")),
      body: Center(child: Text("Welcome to Google Page")),
    );
  }
}

class YahooScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yahoo")),
      body: Center(child: Text("Welcome to Yahoo Page")),
    );
  }
}

class GmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gmail")),
      body: Center(child: Text("Welcome to Gmail Page")),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: username,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Login Clicked")),
                );
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
