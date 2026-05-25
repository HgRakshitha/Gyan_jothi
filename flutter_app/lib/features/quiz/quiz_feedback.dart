import 'package:flutter/material.dart';

void showQuizSelectAnswer(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Please choose an answer first.')),
  );
}

void showQuizPuzzleIncomplete(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Place all four words first.')),
  );
}
