import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/logic/streak_logic.dart';

//TODO: streak counter fix
class StreakCounter extends StatefulWidget {
  StreakCounter({super.key});

  

  @override
  State<StreakCounter> createState() => _StreakCounterState();
}

class _StreakCounterState extends State<StreakCounter> {
  late StreakLogic streakLogic ;
  // final _prefs= StreakCounter()._prefs; 
  @override
  void initState() {
    super.initState();
    streakLogic = Provider.of<StreakLogic>(context, listen: false);
    streakLogic.startTimer();
    }
    
      
  
  // int maxTaskStreak=0;




  

  @override
  Widget build(BuildContext context) {
    final streakLogic = Provider.of<StreakLogic>(context);
    int streakCounter = streakLogic.streakCounter;
    int maxCounter = streakLogic.maxCounter;
    var _mediaQuery = MediaQuery.of(context).size;
    return Card(
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
                      '${streakCounter}',
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
            Expanded(child: SizedBox()),
            Container(
              width: _mediaQuery.width * 0.3,
              child: Column(children: [
                Text(
                  '$maxCounter',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  'Max Task \nStreak',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
