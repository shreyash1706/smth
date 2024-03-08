// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/services/firestore.dart';

class TaskWidget extends StatefulWidget {
  final String docID;
  final String title;
  final String description;
  Timestamp due;
  final String repetition;
  final String? list;

  TaskWidget(
      {required this.docID,
      required this.title,
      this.description = "",
      required this.due,
      required this.repetition,
      this.list});

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isChecked = false;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedRepetition;
  String? _selectedList;

  @override
  Widget build(BuildContext context) {
    _selectedList = widget.list;
    _selectedRepetition = widget.repetition;
    _titleController.text = widget.title;
    _descriptionController.text = widget.description;

    var due = widget.due;
    _selectedDate = due.toDate();
    var dueDate = DateFormat('dd/MM/yyyy').format(_selectedDate!);
    _selectedTime =
        TimeOfDay(hour: _selectedDate!.hour, minute: _selectedDate!.minute);

    void OpenUpdateBox({required docID}) {
      showDialog<void>(
          context: context,
          builder: (context) => SingleChildScrollView(
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    title: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back)),
                        Text('Update Task'),
                      ],
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Title',
                        ),
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
                                'Due Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}'),
                            IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () async {
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030),
                                );
                                if (selectedDate != _selectedDate) {
                                  setState(() {
                                    _selectedDate = selectedDate;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Text(
                                'Due Time: ${_selectedTime?.format(context) ?? "Not set"}'),
                            IconButton(
                              icon: Icon(Icons.access_time),
                              onPressed: () async {
                                final selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (selectedTime != _selectedTime) {
                                  setState(() {
                                    _selectedTime = selectedTime;
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
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                Map<String, dynamic> newTaskMap = {
                                  'title': _titleController.text,
                                  'description': _descriptionController.text,
                                  'due': DateTime(
                                      _selectedDate!.year,
                                      _selectedDate!.month,
                                      _selectedDate!.day,
                                      _selectedTime!.hour,
                                      _selectedTime!.minute),
                                  'repetition': _selectedRepetition,
                                  'list': _selectedList,
                                };
                                FireStoreServices().UpdateTask(docID, newTaskMap).then((value) => Navigator.pop(context));
                               
                              },
                              child: Text("Update")),
                        )
                      ],
                    ),
                  );
                }),
              ));
    }

    return Padding(
      padding: const EdgeInsets.all(1),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.15,
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
                                    '$dueDate ,',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  // SizedBox(width: 3),
                                  Text(
                                    _selectedTime!.format(context),
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
                          onPressed: () {
                            FireStoreServices().DeleteTask(widget.docID);
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
