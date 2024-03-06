import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor:  Color.fromARGB(255,18,26,38),
          elevation: 0.0,
          flexibleSpace: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircleAvatar(
                          backgroundColor:  Colors.white,
                          radius: 30,
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 40,
                          ),
                        ),
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'User profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
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
      body: ProfileSection(),
    );
  }
}

class ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context).size;
    int completedTasks =
        0; // Example: Replace with actual completed tasks count
    int pendingTasks = 0; // Example: Replace with actual pending tasks count

    return Row(
      children: [
        SizedBox(
          width: _mediaQuery.width * 0.05,
        ),
        Container(
          height: _mediaQuery.height,
          width: _mediaQuery.width * 0.9,
          // color: Colors.yellow,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _mediaQuery.height * 0.025,
                ),
                Container(
                  child: Text(
                    'Tasks Overview', // New Container for "Tasks Overview"
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: _mediaQuery.height * 0.025,
                ),
                Row(
                  children: <Widget>[
                    Card(
                      elevation: 10,
                      child: Container(
                        width: _mediaQuery.width * 0.42,
                        height: 80,//_mediaQuery.height * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Completed Tasks',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '$completedTasks', // Display completed tasks count
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: _mediaQuery.width * 0.015,
                      height: _mediaQuery.height * 0.15,
                    ),
                    Card(
                      elevation: 10,
                      child: Container(
                        width: _mediaQuery.width * 0.42,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Pending Tasks',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '$pendingTasks', // Display completed tasks count
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: _mediaQuery.width * 0.05,
        ),
      ],
    );
  }
}