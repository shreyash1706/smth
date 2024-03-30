import 'package:flutter/material.dart';

class StreakCounter extends StatefulWidget {
  const StreakCounter({super.key});

  @override
  State<StreakCounter> createState() => _StreakCounterState();
}

class _StreakCounterState extends State<StreakCounter> {
  // int maxTaskStreak=0;
  int taskStreak = 0;
  int dayStreak = 0;

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context).size;
    return Container(
      // color: Colors.blue,
      child: Card(
        color: Color.fromARGB(255, 121, 124, 147),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: _mediaQuery.width * 0.3,
                child: Column(children: [
                  Text(
                    '$taskStreak',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    'Current Task \n Streak',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )
                ]),
              ),
              // Container(
              //   width: _mediaQuery.width*0.3,
              //   child: Column(children: [
              //     Text(
              //       '$maxTaskStreak',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(fontSize: 20,color: Colors.white),
              //     ),
              //     Text(
              //       'Max Task \n Streak',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(color: Colors.white),
              //     )
              //   ]),
              // ),
              Expanded(child: SizedBox()),
              Container(
                width: _mediaQuery.width * 0.3,
                child: Column(children: [
                  Text(
                    '$dayStreak',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    'Current Day Streak',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  // int max_taskstreak=0;
  // int taskstreak=0;
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