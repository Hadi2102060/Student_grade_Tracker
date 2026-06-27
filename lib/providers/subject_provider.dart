// lib/providers/subject_provider.dart

import 'package:flutter/material.dart';
import '../models/subject.dart';

class SubjectProvider extends ChangeNotifier {
  List<Subject> _subjects = []; // Store subjects

  // Getter for subjects list
  List<Subject> get subjects => _subjects;

  // Get passing subjects using .where() (Requirement: use .where())
  List<Subject> get passingSubjects {
    return _subjects.where((subject) => subject.grade != 'F').toList();
  }

  // Get failing subjects using .where()
  List<Subject> get failingSubjects {
    return _subjects.where((subject) => subject.grade == 'F').toList();
  }

  // Get subject names using .map() (Requirement: use .map())
  List<String> get subjectNames {
    return _subjects.map((subject) => subject.name).toList();
  }

  // Add new subject
  void addSubject(String name, double mark) {
    _subjects.add(Subject(name: name, mark: mark));
    notifyListeners(); // Notify UI to update
  }

  // Delete subject (used with Dismissible)
  void deleteSubject(int index) {
    _subjects.removeAt(index);
    notifyListeners(); // Notify UI to update
  }

  // Calculate average mark
  double get averageMark {
    if (_subjects.isEmpty) return 0.0;
    double total = _subjects.fold(0.0, (sum, subject) => sum + subject.mark);
    return total / _subjects.length;
  }

  // Get overall grade based on average
  String get overallGrade {
    double avg = averageMark;
    if (avg >= 80) return 'A';
    if (avg >= 65) return 'B';
    if (avg >= 50) return 'C';
    return 'F';
  }

  // Get total subjects
  int get totalSubjects => _subjects.length;

  // Clear all subjects (optional)
  void clearAll() {
    _subjects.clear();
    notifyListeners();
  }
}
