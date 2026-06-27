// lib/models/subject.dart

class Subject {
  final String name;
  final double _mark; // Private field (Requirement: private _mark)

  Subject({required this.name, required double mark})
    : _mark = mark; // Initialize private field

  // Grade getter (Requirement: A (≥80), B (≥65), C (≥50), or F)
  String get grade {
    if (_mark >= 80) return 'A';
    if (_mark >= 65) return 'B';
    if (_mark >= 50) return 'C';
    return 'F';
  }

  // Getter to access mark (read-only)
  double get mark => _mark;

  // Convert to Map for debugging/storage (optional)
  Map<String, dynamic> toJson() => {'name': name, 'mark': _mark};
}
