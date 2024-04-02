import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/logic/streak_logic.dart';
import 'package:to_do_list/services/firestore.dart';

class Profile extends StatelessWidget {
  Future<void> _updateCounts() async {
    await FireStoreServices().countCompletedTasks();
    await FireStoreServices().countPendingTasks();
    await StreakLogic().getCounter();
    await StreakLogic().getMaxCounter();
    
  }
  
  @override
  Widget build(BuildContext context) {
    final streakLogic = Provider.of<StreakLogic>(context);
    int streakCounter = streakLogic.streakCounter;
    int maxCounter = streakLogic.maxCounter;
    var _mediaQuery =MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(_mediaQuery.height*0.1),
          child: Container(
            color: Color.fromARGB(255, 18, 35, 60),
            child: SafeArea(
              
              child: AppBar(
                backgroundColor: Color.fromARGB(255, 18, 35, 60),
                flexibleSpace: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 18, top: 4, bottom: 4, right: 18),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 33,
                              backgroundImage: NetworkImage(
                                  'https://icon-library.com/images/default-user-icon/default-user-icon-23.jpg'),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'User',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontFamily: 'Lato',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'some information...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Lato',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Tasks Overview',
                  style: TextStyle(fontSize: 20, fontFamily: 'Lato'),
                ),
              ),
            ),
            SizedBox(height: 5),
            
            FutureBuilder(
              future: _updateCounts(),
              builder: (context,snapshot) {
                return Expanded(
                  child: ListView(
                    children: [
                      buildCategoryRow(context, ['Current Task Streak',streakLogic.streakCounter , Icons.trending_up]),
                      buildCategoryRow(context, ['Maximum Task Streak', streakLogic.maxCounter, Icons.leaderboard]),
                      FutureBuilder<int>(
    future: FireStoreServices().countCompletedTasks(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return buildCategoryRow(context, ['Completed Tasks', snapshot.data ?? 0, Icons.check_circle]);
      }
    },
  ),
                    FutureBuilder<int>(
    future: FireStoreServices().countPendingTasks(),
    builder: (context, snapshot) {
      // if (snapshot.connectionState == ConnectionState.waiting) {
      //   return CircularProgressIndicator(); // Show a loading indicator while fetching data
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return buildCategoryRow(context, ['Pending Task', snapshot.data ?? 0, Icons.access_time]);
      }
    },
  ),
                    ]
                  ),
                );
              }
            ),
          ],
        ),
      ),
      
    );
      
  }

  Widget buildCategoryRow(BuildContext context, List<dynamic> categoryData) {
    String categoryName = categoryData[0];
    int integerValue = categoryData[1];
    IconData iconData = categoryData[2];

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 2, horizontal: 10),
      child: Card(
        elevation: 5, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 54, 68, 152), Color.fromARGB(255, 59, 149, 223)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(iconData, color: Colors.white),
                  SizedBox(width: 10),
                
                  Text(
                    categoryName,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 10), 
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 34),
                  
                  Text(
                    '$integerValue',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
