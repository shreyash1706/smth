import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices{
  final Taskdoc =FirebaseFirestore.instance.collection('Tasks').doc();

  //CREATE
  Future createTask(Map <String,dynamic> taskMap) async{
    
    taskMap['id']= Taskdoc.id;

    //create document and write data to firebase
    await Taskdoc.set(taskMap);
  }
}


