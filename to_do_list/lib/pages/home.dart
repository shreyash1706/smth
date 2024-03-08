import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_list/pages/addTask.dart';
import 'package:to_do_list/pages/settings.dart';
import 'package:to_do_list/services/firestore.dart';
import 'package:to_do_list/widgets/streak_counter.dart';
import 'package:to_do_list/widgets/task_wigdet.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  void OpenUpdateBox({required docID}){
    
  }
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context).size;
    // Stream? taskStream;

    // getontheload() async{
    //   taskStream=await FireStoreServices().getTasks();
    //   setState(() {
        
    //   });
    // }

    // @override
    // void initState(){
    //   getontheload();
    //   super.initState();
    // }

    return DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Scaffold(
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => settings()));
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
      Container(
        height:_mediaQuery.height * 0.606, 
        child: StreamBuilder<QuerySnapshot>(
          stream: FireStoreServices().getTasks(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot dS = snapshot.data!.docs[index];
                  String docID = dS.id;
                  return TaskWidget(
                    title: dS['title'],
                    description: dS['description'],
                    due: dS['due'],
                    repetition: dS['repetition'],
                    list: dS['list'],
                  );
                },
              );
            } else {
              return Center(child: Text("No Tasks Yet",style: TextStyle(color: Colors.white),));
            }
          },
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
                  child: Column()),
              Container(
                  height: _mediaQuery.height,
                  width: _mediaQuery.width,
                  color: const Color.fromARGB(255, 19, 32, 48),
                  child: Column()),
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
        ));
  }

  // int taskstreak=0;
  // int max_taskstreak=0;
  // int daystreak=0;
  // Widget streakcounter(){
  //   var _mediaQuery=MediaQuery.of(context).size;
  //   return Card(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //     child: Container(
  //       padding: EdgeInsets.all(10),
  //       height: _mediaQuery.height*0.16,
  //       child: Row(
  //         children: [
  //           Container(
  //             child: Column(children: [
  //               Text(
  //                 '$taskstreak',
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(fontSize: 20,),
  //               ),
  //               Text(
  //                 'Current Task Streak',
  //                 textAlign: TextAlign.center,
  //               )
  //             ]),
  //           ),
  //           Container(
  //             child: Column(children: [
  //               Text(
  //                 '$max_taskstreak',
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(fontSize: 20,),
  //               ),
  //               Text(
  //                 'Max Task Streak',
  //                 textAlign: TextAlign.center,
  //               )
  //             ]),
  //           ),
  //           Container(
  //             child: Column(children: [
  //               Text(
  //                 '$daystreak',
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(fontSize: 20,),

  //               ),
  //               Text(
  //                 'Current Day Streak',
  //                 textAlign: TextAlign.center,
  //               )
  //             ]),
  //           ),
  //         ],

  //       ),
  //     ),
  //   );
  // }
}
