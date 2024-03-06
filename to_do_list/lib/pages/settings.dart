import 'package:flutter/material.dart';



class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  bool isDarkModeEnabled = false; // A placeholder for the theme changer
  bool areNotificationsEnabled = true; // A placeholder for notifications
  String selectedTimeFormat = '12-hour'; // Default time format
  String selectedFirstDayOfWeek = 'Sunday'; // Default first day of the week
  String selectedStartupList = 'All'; // Default startup list

  void _showTimeFormatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Time Format'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('12-hour'),
                onTap: () {
                  setState(() {
                    selectedTimeFormat = '12-hour';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('24-hour'),
                onTap: () {
                  setState(() {
                    selectedTimeFormat = '24-hour';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFirstDayOfWeekDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select First Day of the Week'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Sunday'),
                onTap: () {
                  setState(() {
                    selectedFirstDayOfWeek = 'Sunday';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Monday'),
                onTap: () {
                  setState(() {
                    selectedFirstDayOfWeek = 'Monday';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showStartupListDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select List to Show at Start-up'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('All'),
                onTap: () {
                  setState(() {
                    selectedStartupList = 'All';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Work'),
                onTap: () {
                  setState(() {
                    selectedStartupList = 'Work';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Personal'),
                onTap: () {
                  setState(() {
                    selectedStartupList = 'Personal';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Wishlist'),
                onTap: () {
                  setState(() {
                    selectedStartupList = 'Wishlist';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        // Add a back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('Enable Dark Mode'),
            trailing: Switch(
              value: isDarkModeEnabled,
              onChanged: (value) {
                // Placeholder: Toggle the dark mode state (does nothing)
                setState(() {
                  isDarkModeEnabled = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Enable Notifications'),
            trailing: Switch(
              value: areNotificationsEnabled,
              onChanged: (value) {
                // Placeholder: Toggle the notifications state (does nothing)
                setState(() {
                  areNotificationsEnabled = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Time Format'),
            subtitle: Text(selectedTimeFormat),
            onTap: () {
              // Show the time format dialog
              _showTimeFormatDialog(context);
            },
          ),
          ListTile(
            title: Text('First Day of the Week'),
            subtitle: Text(selectedFirstDayOfWeek),
            onTap: () {
              // Show the first day of the week dialog
              _showFirstDayOfWeekDialog(context);
            },
          ),
          ListTile(
            title: Text('List to Show at Start-up'),
            subtitle: Text(selectedStartupList),
            onTap: () {
              // Show the startup list dialog
              _showStartupListDialog(context);
            },
          ),
        ],
      ),
    );
  }
}