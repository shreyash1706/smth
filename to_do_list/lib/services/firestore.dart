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
    final taskStream= taskdoc.orderBy("due").snapshots();
    return  taskStream;
  }

  //UPDATE
  Future getTask({required docID}) async{
    return await taskdoc.doc(docID);
  }  
}

  


