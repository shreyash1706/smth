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

    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
  }
}
  