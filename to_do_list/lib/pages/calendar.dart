import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_list/pages/addTask.dart';
import 'package:to_do_list/services/firestore.dart';
import 'package:to_do_list/widgets/streak_counter.dart';
import 'package:to_do_list/widgets/task_wigdet.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  List<List> tasks = [
    ["Task 1", 1, DateTime.now()],
    ["Task 2", 2, DateTime.now()],
  ]; // List to hold tasks
  String taskName = '';
  int priorityValue = 0;

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
        backgroundColor: Color.fromRGBO(18, 26, 38, 1),
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
              width: _mediaQuery.width,
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    'Tasks for the day',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 22, 103, 206),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  // Display tasks
                  Expanded(
                    child: Container(
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
                                    List<DocumentSnapshot> tasksForSelectedDay =
                                        snapshot.data!.docs.where((doc) {
                                      DateTime dueDate =
                                          (doc['due'] as Timestamp).toDate();
                                      return isSameDay(dueDate,
                                          _focusedDay); // Filter tasks for selected day
                                    }).toList();

                                    if (tasksForSelectedDay.isEmpty) {
                                      return Center(
                                        child: Text(
                                          "No Tasks for Selected Day",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    }

                                    return ListView.builder(
                                      itemCount: tasksForSelectedDay.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot dS =
                                            tasksForSelectedDay[index];
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
                                    );
                                  } else {
                                    return Center(
                                      child: Text(
                                        "No Tasks Yet",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  }
                                },
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
                  )
                ],
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
              builder: (context) => AddTask(),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Calendar App',
    home: Calendar(),
  ));
}
