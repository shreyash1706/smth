// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_list/pages/addTask.dart';
import 'package:to_do_list/services/firestore.dart';
import 'package:to_do_list/widgets/task_wigdet.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalenderState();
}

class _CalenderState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _focusedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        backgroundColor: const Color.fromARGB(255, 18, 26, 38),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TableCalendar(
            rowHeight: 45,
            headerStyle:
                HeaderStyle(formatButtonVisible: false, titleCentered: true),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2010, 01, 01),
            lastDay: DateTime.utc(2030, 12, 31),
            onDaySelected: _onDaySelected,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              // Update calendar format
              setState(() {
                _calendarFormat = (_calendarFormat == CalendarFormat.month)
                    ? CalendarFormat.week
                    : CalendarFormat.month;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
          ),
          Expanded(
            child: Container(
              // width: _mediaQuery.width,
              // height: _mediaQuery.height*0.35,
              color: Colors.white,

              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Text(
                      'tasks for the day',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Color.fromARGB(255, 22, 103, 206)),
                    ),
                    StreamBuilder<QuerySnapshot>(
  stream: FireStoreServices().getTasksForDay(_focusedDay),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
      return SizedBox(    
        height: MediaQuery.of(context).size.height * 0.42, // Adjust the height as needed
        child: ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot dS = snapshot.data!.docs[index];
            String docID = dS.id;
            return TaskWidget(
              docID: docID,
              title: dS['title'],
              description: dS['description'],
              due: dS['due'],
              repetition: dS['repetition'],
              list: dS['list'],
            );
          },
        ),
      );
    } else {
      return Center(child: Text('No Tasks'));
    }
  },
)

                  ],
                ),
              ),
            ),
          )
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
  builder: (context) => AddTask(duedate: _focusedDay),
)

              );
        },
      ),
    );
  }
}
