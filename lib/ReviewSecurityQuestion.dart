import 'package:flutter/material.dart';
class ReviewSecurityQuestion extends StatefulWidget {
  const ReviewSecurityQuestion({super.key});

  @override
  State<ReviewSecurityQuestion> createState() => _ReviewSecurityQuestionState();
}

class _ReviewSecurityQuestionState extends State<ReviewSecurityQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security Question Settings'),
      ),
    );
  }
}
