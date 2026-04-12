import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

//////////////////// LOGIN PAGE ////////////////////

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  Future login() async {
    final prefs = await SharedPreferences.getInstance();

    String? savedUser = prefs.getString('username');
    String? savedPass = prefs.getString('password');

    if (username == savedUser && password == savedPass) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid Credentials")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Username"),
                validator: (v) => v!.isEmpty ? "Enter username" : null,
                onChanged: (v) => username = v,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (v) =>
                    v!.length < 6 ? "Minimum 6 characters" : null,
                onChanged: (v) => password = v,
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    login();
                  }
                },
                child: Text("Login"),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterPage()),
                  );
                },
                child: Text("Create Account"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////// REGISTER PAGE ////////////////////

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String age = '';
  String gender = 'Male';
  String dob = '';
  String username = '';
  String password = '';
  File? image;

  Future pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  Future register() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', name);
    await prefs.setString('age', age);
    await prefs.setString('gender', gender);
    await prefs.setString('dob', dob);
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setString('image', image!.path);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Registration Successful")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      image != null ? FileImage(image!) : null,
                  child: image == null
                      ? Icon(Icons.camera_alt, size: 30)
                      : null,
                ),
              ),

              SizedBox(height: 10),

              TextFormField(
                decoration: InputDecoration(labelText: "Name"),
                validator: (v) => v!.isEmpty ? "Enter name" : null,
                onChanged: (v) => name = v,
              ),

              TextFormField(
                decoration: InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v!.isEmpty) return "Enter age";
                  if (int.tryParse(v) == null)
                    return "Only numbers allowed";
                  return null;
                },
                onChanged: (v) => age = v,
              ),

              DropdownButtonFormField(
                value: gender,
                items: ["Male", "Female", "Other"]
                    .map((g) => DropdownMenuItem(
                          value: g,
                          child: Text(g),
                        ))
                    .toList(),
                onChanged: (v) => gender = v!,
                decoration: InputDecoration(labelText: "Gender"),
              ),

              TextFormField(
                decoration: InputDecoration(labelText: "Date of Birth"),
                validator: (v) => v!.isEmpty ? "Enter DOB" : null,
                onChanged: (v) => dob = v,
              ),

              TextFormField(
                decoration: InputDecoration(labelText: "Username"),
                validator: (v) =>
                    v!.isEmpty ? "Enter username" : null,
                onChanged: (v) => username = v,
              ),

              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (v) =>
                    v!.length < 6 ? "Min 6 characters" : null,
                onChanged: (v) => password = v,
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      image != null) {
                    register();
                  } else if (image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Select profile image")),
                    );
                  }
                },
                child: Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////// HOME PAGE ////////////////////

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      name = prefs.getString('name');
      imagePath = prefs.getString('image');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              CircleAvatar(
                radius: 60,
                backgroundImage: FileImage(File(imagePath!)),
              ),

            SizedBox(height: 10),

            Text(
              "Welcome ${name ?? ''}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
