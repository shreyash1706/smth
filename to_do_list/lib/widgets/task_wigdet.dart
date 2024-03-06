// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/widgets/updateTask.dart';


class TaskWidget extends StatefulWidget {
  final String title;
  final String? description;
  final Timestamp due;
  final String repetition;
  final String? list;

  TaskWidget({
    required this.title,
    this.description,
    required this.due,
    required this.repetition,
    this.list
  });

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isChecked = false;


  

  @override
  Widget build(BuildContext context) {

    var due=widget.due;
    var due_DT=due.toDate();
    final dueDate= DateFormat('dd/MM/yyyy').format(due_DT!);
    final dueTime = TimeOfDay(hour: due_DT.hour, minute: due_DT.minute);

    DateTime now = DateTime.now();
    return Padding(
        padding: const EdgeInsets.all(1), 
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
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
                            value: isChecked,
                            shape: CircleBorder(),
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text(
                              widget.title,
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.left ,
                            ),
                            Row(
                        children: [
                          Text(
                            '${dueDate} ,',
                            style: TextStyle(fontSize: 17),
                          ),
                          // SizedBox(width: 3),
                          Text(
                            dueTime.format(context),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                            ]
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              
                            },
                          ),
                        ],
                      ),
                      
                      
                      SizedBox(height: 12),
                      
                        
                      
                    ],
                  ),
                ),
              ),
            ],
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