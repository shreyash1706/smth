// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreakLogic extends ChangeNotifier {
  int _streakCounter = 0;
  int _maxCounter = 0;
  int get streakCounter => _streakCounter;
  int get maxCounter => _maxCounter;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> getCounter() async {
    final SharedPreferences prefs = await _prefs;
    _streakCounter = prefs.getInt("streak_counter") ?? 0;
    notifyListeners(); // Notify listeners after updating the streak counter
  }

  Future<void> getMaxCounter() async {
    final SharedPreferences prefs = await _prefs;
    _maxCounter = prefs.getInt("max_counter") ?? 0;
    notifyListeners();
  }

  Future<void> incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    if (_maxCounter == _streakCounter) {
      _maxCounter++;
      await prefs.setInt("max_counter", maxCounter);
    }
    _streakCounter++;
    await prefs.setInt(
        "streak_counter", _streakCounter); // Save to SharedPreferences
    notifyListeners(); // Notify listeners after updating the streak counter
  }

  Future<void> resetCounter() async {
    final SharedPreferences prefs = await _prefs;
    _streakCounter = 0; // Reset the counter
    await prefs.setInt(
        "streak_counter", _streakCounter); // Save to SharedPreferences
    notifyListeners(); // Notify listeners after updating the streak counter
  }

  //Reseting counter logic
  late Timer _timer;
  void startTimer() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      checknReset();
    });
  }

  Future<void> checknReset() async {
    QuerySnapshot tasksnapshot =
        await FirebaseFirestore.instance.collection('Tasks').get();
    DateTime now = DateTime.now();
    for (var doc in tasksnapshot.docs.where((doc) => !doc['completed'])) {
      DateTime dueDate = (doc['due'] as Timestamp).toDate();
      if (now.difference(dueDate).inSeconds >= 1) {
        resetCounter();
      }
    }
  }
}
