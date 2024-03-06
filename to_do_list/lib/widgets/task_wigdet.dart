// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class TaskWidget extends StatefulWidget {
  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Padding(
        padding: const EdgeInsets.all(12), 
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
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
                              'Taskvjjvhvgi',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.left ,
                            ),
                            Row(
                        children: [
                          Text(
                            '20/12/23 ,',
                            style: TextStyle(fontSize: 17),
                          ),
                          // SizedBox(width: 3),
                          Text(
                            '10:29 am',
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