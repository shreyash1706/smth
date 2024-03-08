import 'package:flutter/material.dart';
import 'package:to_do_list/services/firestore.dart';
import 'package:intl/intl.dart';

class UpdateTask extends StatefulWidget {
  // const UpdateTask({super.key});
  final String docID;

  UpdateTask({required this.docID});
  
  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  
  late final task ;

  @override
  Widget build(BuildContext context) {
    task = FireStoreServices().getTask(docID: widget.docID);
    var due=task.due;
    var due_DT=due.toDate();
    final dueDate= DateFormat('dd/MM/yyyy').format(due_DT!);
    var dueTime = TimeOfDay(hour: due_DT.hour, minute: due_DT.minute);

    return showDialog<void>(context: context, builder: (context)=> AlertDialog(
      title: Text('Update Task'),
      content: Column(children: [
        Text('Title'),
        TextField(
          
        ),
        Text('Description'),
        TextField(

        ),
        Row(
                children: [
                  Text('Due Date: ${DateFormat('dd/MM/yyyy').format(due_DT!)}'),
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
                  Text('Due Time: ${dueTime.format(context) }'),
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
                value: task['repetition'],
                onChanged: (value) {
                  setState(() {
                    task['repetition'] = value;
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
                  border: OutlineInputBorder(), // Add border to dropdown
                ),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: task.list,
                onChanged: (value) {
                  setState(() {
                    task.list = value;
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
                  border: OutlineInputBorder(), // Add border to dropdown
                ),
              ),

      ],),
    ));
  }
}
  