import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_list/pages/addTask.dart';
import 'package:to_do_list/pages/settings.dart';
import 'package:to_do_list/services/firestore.dart';
import 'package:to_do_list/widgets/streak_counter.dart';
import 'package:to_do_list/widgets/task_wigdet.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/widgets/completed_task_widget.dart';

class home extends StatefulWidget {
  const home({Key? key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<String> completedTasks = [];
  List<String> activeTasks = [];
  List<CompletedTaskWidget> completedTaskWidgets = []; // Added list for completed task widgets

  @override
  void initState() {
    super.initState();
    // Fetch tasks from Firestore and initialize activeTasks list
    FireStoreServices().getTasks().listen((snapshot) {
      setState(() {
        activeTasks = snapshot.docs.map((doc) => doc.id).toList();
      });
    });
  }

  void handleTaskCompletion(String docID) {
  FirebaseFirestore.instance.collection('tasks').doc(docID).get().then((completedTaskSnapshot) {
    setState(() {
      activeTasks.remove(docID);
      completedTasks.add(docID);

      // Create a completed task widget and add it to the list of completed task widgets
      CompletedTaskWidget completedTaskWidget = CompletedTaskWidget(
        docID: docID,
        title: completedTaskSnapshot['title'],
        description: completedTaskSnapshot['description'],
        due: completedTaskSnapshot['due'],
        repetition: completedTaskSnapshot['repetition'],
        list: completedTaskSnapshot['list'],
        onTaskCompleted: handleTaskCompletion, // Pass the same method to handle un-completing tasks
      );

      completedTaskWidgets.add(completedTaskWidget);
    });
  }).catchError((error) {
    print("Error fetching completed task: $error");
  });
}

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context).size;

    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 18, 26, 38),
          title: const Text('Tasks'),
          foregroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              color: Colors.white,
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => settings()),
                );
              },
            ),
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'All',
              ),
              Tab(
                text: 'Work',
              ),
              Tab(
                text: 'Personal',
              ),
              Tab(
                text: 'Wishlist',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              height: _mediaQuery.height,
              width: _mediaQuery.width,
              color: const Color.fromARGB(255, 19, 32, 48),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: _mediaQuery.height * 0.606,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FireStoreServices().getTasks(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.data!.docs.isNotEmpty) {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot dS =
                                    snapshot.data!.docs[index];
                                String docID = dS.id;
                                return TaskWidget(
                                  docID: docID,
                                  title: dS['title'],
                                  description: dS['description'],
                                  due: dS['due'],
                                  repetition: dS['repetition'],
                                  list: dS['list'],
                                  onTaskCompleted: handleTaskCompletion,
                                );
                                
                              },
                            );
                          } else {
                            return Center(
                                child: Text(
                              "No Tasks Yet",
                              style: TextStyle(color: Colors.white),
                            ));
                          }
                        },
                      ),
                    ),
                  ),
                  // Completed task section
                  
                  SingleChildScrollView(
                    child: Container(
                      // Add your completed tasks widgets here
                      child: Column(
                        children: completedTaskWidgets,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: _mediaQuery.height * 0.135,
                      width: _mediaQuery.width * 0.8,
                      child: StreakCounter(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: _mediaQuery.height,
                width: _mediaQuery.width,
                color: const Color.fromARGB(255, 19, 32, 48),
                child: Column()),
            Container(
                height: _mediaQuery.height,
                width: _mediaQuery.width,
                color: const Color.fromARGB(255, 19, 32, 48),
                child: Column()
              ),
            Container(
                height: _mediaQuery.height,
                width: _mediaQuery.width,
                color: const Color.fromARGB(255, 19, 32, 48),
                child: Column()
              ),
            
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          autofocus: true,
          shape: CircleBorder(),
          backgroundColor: Color.fromARGB(255, 22, 103, 206),
          elevation: 100,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTask(),
              ),
            );
          },
        ),
      ),
    );
  }
}
