// lib/screens/add_subject_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';
import '../theme/app_theme.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _markController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _markController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text.trim();
      double mark = double.parse(_markController.text);

      Provider.of<SubjectProvider>(
        context,
        listen: false,
      ).addSubject(name, mark);

      _nameController.clear();
      _markController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Subject "$name" added successfully!'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Add New Subject',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Subject Name',
                        prefixIcon: Icon(
                          Icons.book_rounded,
                          color: Colors.blueAccent,
                        ),
                        hintText: 'e.g., Mathematics',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '⚠️ Please enter a subject name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _markController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Mark (0-100)',
                        prefixIcon: Icon(Icons.score, color: Colors.deepOrange),
                        hintText: 'e.g., 85',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '⚠️ Please enter a mark';
                        }
                        double? mark = double.tryParse(value);
                        if (mark == null) {
                          return '⚠️ Please enter a valid number';
                        }
                        if (mark < 0 || mark > 100) {
                          return '⚠️ Mark must be between 0 and 100';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'ADD SUBJECT',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Icon(Icons.info, size: 40),
                            const SizedBox(height: 10),
                            Text(
                              'Grading Scale',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 10),
                            _buildGradeInfo(
                              'A',
                              '80 - 100',
                              Theme.of(context).extension<GradeColors>()!.a!,
                            ),
                            _buildGradeInfo(
                              'B',
                              '65 - 79',
                              Theme.of(context).extension<GradeColors>()!.b!,
                            ),
                            _buildGradeInfo(
                              'C',
                              '50 - 64',
                              Theme.of(context).extension<GradeColors>()!.c!,
                            ),
                            _buildGradeInfo(
                              'F',
                              '0 - 49',
                              Theme.of(context).extension<GradeColors>()!.f!,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGradeInfo(String grade, String range, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            grade,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            range,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}
