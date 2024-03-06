import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget{
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalenderState();
}

class _CalenderState extends State<Calendar>{

  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat= CalendarFormat.month;

  
  DateTime today= DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      _focusedDay=day;
    });
  }
  @override
  Widget build(BuildContext context){
    var _mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        backgroundColor: const Color.fromARGB(255,18,26,38),
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
           TableCalendar(
              rowHeight: 45,
              headerStyle: HeaderStyle(formatButtonVisible: false,titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
              focusedDay: _focusedDay, 
              firstDay: DateTime.utc(2010,01,01), 
              lastDay: DateTime.utc(2030,12,31),
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
              color: Colors. white,
                    
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Text('tasks for the day',textAlign: TextAlign.center,style: TextStyle(color: Color.fromARGB(255, 22,103,206)),),
                    ],
                ),
              ),
            ),
          )
        ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add,color: Colors.white,),
          autofocus: true,
          shape: CircleBorder(),
          backgroundColor: Color.fromARGB(255, 22,103,206),
          elevation: 100,
          onPressed: (){
            //do something
          },
        ),
    );

  }
    
}