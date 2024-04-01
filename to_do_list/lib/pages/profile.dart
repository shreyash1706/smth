import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 18, 35, 60),
            elevation: 0,
            flexibleSpace: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 18, top: 40, bottom: 38, right: 18),
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
                          'User 123',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontFamily: 'Lato',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'meow meow id',
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
            
            Expanded(
              child: ListView(
                children: [
                  buildCategoryRow(context, ['Current Task Streak', 1, Icons.trending_up]),
                  buildCategoryRow(context, ['Maximum Task Streak', 2, Icons.leaderboard]),
                  buildCategoryRow(context, ['Completed Tasks', 3, Icons.check_circle]),
                  buildCategoryRow(context, ['Pending Task', 4, Icons.access_time]),
                ],
              ),
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
                    '0',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
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
