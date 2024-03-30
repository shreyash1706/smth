import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompletedTaskWidget extends StatelessWidget {
  final String docID;
  final String title;
  final String description;
  final Timestamp due;
  final String repetition;
  final String? list;
  final Function(String)? onTaskCompleted;

  CompletedTaskWidget({
    required this.docID,
    required this.title,
    required this.description,
    required this.due,
    required this.repetition,
    this.list,
    this.onTaskCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your logic here to handle when a completed task is tapped
      },
      child: Card(
        shadowColor: Colors.blueGrey,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: true, // Assuming completed tasks are always checked
                    onChanged: (bool? value) {
                      // Add your logic here to handle when the checkbox is tapped
                    },
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                      // Other details of the completed task (due date, etc.)
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.selected,
    };
    if (states.any(interactiveStates.contains)) {
      return Color.fromARGB(255, 66, 87, 102);
    }
    return Colors.white;
  }
}
