// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class TaskWidget extends StatefulWidget {
  final String docID;
  final String title;
  final String description;
  final Timestamp due;
  final String repetition;
  final String? list;

  TaskWidget(
      {required this.docID,
      required this.title,
      this.description="",
      required this.due,
      required this.repetition,
      this.list});

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isChecked = false;

  

  TextEditingController _titleController = TextEditingController();
  TextEditingController? _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedRepetition;
  String? _selectedList;

  

  @override
  Widget build(BuildContext context) {
    _selectedList=widget.list;
    _selectedRepetition= widget.repetition;
    _titleController.text = widget.title;
    _descriptionController!.text = widget.description;

    var due = widget.due;
    var due_DT = due.toDate();
    var dueDate = DateFormat('dd/MM/yyyy').format(due_DT);
    var dueTime = TimeOfDay(hour: due_DT.hour, minute: due_DT.minute);

    void OpenUpdateBox({required docID}) {
    showDialog<void>(
        context: context,
        builder: (context) => SingleChildScrollView(
          child: AlertDialog(
                title: Text('Update Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Title'),
                    TextField(
                      controller: _titleController,
                    ),
                    Text('Description'),
                    TextField(
                      controller: _descriptionController,
                    ),
                    Row(
                      children: [
                        Text(
                            'Due Date: ${DateFormat('dd/MM/yyyy').format(due_DT)}'),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030),
                            );
                            if (selectedDate != null) {
                              setState(() {
                                due_DT = selectedDate;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Text('Due Time: ${dueTime.format(context)}'),
                        IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () async {
                            final selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (selectedTime != null) {
                              setState(() {
                                dueTime = selectedTime;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _selectedRepetition,
                      onChanged: (value) {
                        setState(() {
                          _selectedRepetition = value;
                        });
                      },
                      items: ["None", "Daily", "Weekly", "Monthly"]
                          .map((repetition) => DropdownMenuItem(
                                value: repetition,
                                child: Text(repetition),
                              ))
                          .toList(),
                      decoration: InputDecoration(
                        labelText: 'Repetition',
                        // border: OutlineInputBorder(), // Add border to dropdown
                      ),
                    ),
                    SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _selectedList,
                      onChanged: (value) {
                        setState(() {
                          _selectedList = value;
                        });
                      },
                      items: ["Default", "Personal", "Wishlist", "Work"]
                          .map((list) => DropdownMenuItem(
                                value: list,
                                child: Text(list),
                              ))
                          .toList(),
                      decoration: InputDecoration(
                        labelText: 'Add to List',
                        // border: OutlineInputBorder(), // Add border to dropdown
                      ),
                    ),
                  ],
                ),
              ),
        ));
  }

  
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
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
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
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.left,
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
                            ]),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            OpenUpdateBox(docID: widget.docID);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {},
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
