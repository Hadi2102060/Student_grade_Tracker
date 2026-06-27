// lib/screens/subject_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';
import '../theme/app_theme.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SubjectProvider>(
        builder: (context, subjectProvider, child) {
          final subjects = subjectProvider.subjects;

          if (subjects.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.book,
                    size: 80,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.color?.withOpacity(0.3),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No subjects added yet',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Add your first subject from the "Add Subject" tab',
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.color?.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index];

              final gradeColors = Theme.of(context).extension<GradeColors>()!;
              Color gradeColor;
              switch (subject.grade) {
                case 'A':
                  gradeColor = gradeColors.a!;
                  break;
                case 'B':
                  gradeColor = gradeColors.b!;
                  break;
                case 'C':
                  gradeColor = gradeColors.c!;
                  break;
                default:
                  gradeColor = gradeColors.f!;
              }

              return Dismissible(
                key: Key(subject.name + index.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                onDismissed: (direction) {
                  subjectProvider.deleteSubject(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('🗑️ "${subject.name}" deleted'),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: gradeColor.withOpacity(0.2),
                      child: Text(
                        subject.grade,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: gradeColor,
                        ),
                      ),
                    ),
                    title: Text(
                      subject.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Mark: ${subject.mark.toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.color?.withOpacity(0.7),
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: gradeColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: gradeColor.withOpacity(0.3)),
                      ),
                      child: Text(
                        subject.grade,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: gradeColor,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
