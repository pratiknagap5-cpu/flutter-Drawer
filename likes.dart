import 'package:flutter/material.dart';

void main() {
  runApp(PollApp());
}

class PollApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PollScreen(),
    );
  }
}

class PollScreen extends StatefulWidget {
  @override
  _PollScreenState createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {
  int likeCount = 0;
  int dislikeCount = 0;

  void voteLike() {
    setState(() {
      likeCount++;
    });
  }

  void voteDislike() {
    setState(() {
      dislikeCount++;
    });
  }

  void resetVotes() {
    setState(() {
      likeCount = 0;
      dislikeCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Opinion Poll"),
        centerTitle: true,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Do you like Flutter?",
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(height: 30),

          Text("👍 Likes: $likeCount", style: TextStyle(fontSize: 18)),
          Text("👎 Dislikes: $dislikeCount", style: TextStyle(fontSize: 18)),

          SizedBox(height: 40),

          ElevatedButton(
            onPressed: voteLike,
            child: Text("Like"),
          ),
          ElevatedButton(
            onPressed: voteDislike,
            child: Text("Dislike"),
          ),
        ],
      ),

      // Floating Action Button as Hit Counter / Reset
      floatingActionButton: FloatingActionButton(
        onPressed: resetVotes,
        child: Icon(Icons.refresh),
        tooltip: "Reset Counter",
      ),
    );
  }
}
