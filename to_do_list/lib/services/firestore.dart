import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreServices{
  final taskdoc =FirebaseFirestore.instance.collection('Tasks');

  //CREATE
  Future createTask(Map <String,dynamic> taskMap) async{
    
    // taskMap['id']= Taskdoc.id;
    //create document and write data to firebase
    await taskdoc.add(taskMap);
  }

  //READ
  Stream<QuerySnapshot> getTasks()  {
    final taskStream= taskdoc.orderBy("due").where("completed", isEqualTo: false).snapshots();  
    return  taskStream;
  }

  //UPDATE
  Future<void> UpdateTask (String docID,Map <String,dynamic> newTaskMap) async{
    return await taskdoc.doc(docID).update(newTaskMap);
  }

  Future<void> TaskChecked(String docID) async{
    bool completed=true;
    return await taskdoc.doc(docID).update({"completed":true});
  }

  //DELETE
  Future<void> DeleteTask(String docID){
    return taskdoc.doc(docID).delete();
  }

//   Future<DateTime> getDueDate(String docID) async {
//   DocumentSnapshot snapshot = await taskdoc.doc(docID).get();
//   Timestamp timestamp = snapshot.get("due");
//   DateTime dueDate = timestamp.toDate();
//   return dueDate;
// }
}

  


