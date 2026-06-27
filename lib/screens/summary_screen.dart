// lib/screens/summary_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_grade_tracker/theme/app_theme.dart';
import '../providers/subject_provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

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
                    Icons.analytics,
                    size: 80,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.color?.withOpacity(0.3),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No data to summarize',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Add some subjects to see your summary',
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

          final totalSubjects = subjectProvider.totalSubjects;
          final averageMark = subjectProvider.averageMark;
          final overallGrade = subjectProvider.overallGrade;
          final passingCount = subjectProvider.passingSubjects.length;
          final failingCount = subjectProvider.failingSubjects.length;

          final gradeColors = Theme.of(context).extension<GradeColors>()!;
          Color gradeColor;
          switch (overallGrade) {
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

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Academic Summary',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          gradeColor.withOpacity(0.3),
                          gradeColor.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Overall Grade',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.color?.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          overallGrade,
                          style: TextStyle(
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                            color: gradeColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Average: ${averageMark.toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        '📚 Total Subjects',
                        totalSubjects.toString(),
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        '📊 Average',
                        '${averageMark.toStringAsFixed(1)}%',
                        Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        '✅ Passing',
                        passingCount.toString(),
                        gradeColors.a!,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        '❌ Failing',
                        failingCount.toString(),
                        gradeColors.f!,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Subject Breakdown',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 15),
                        ...subjectProvider.subjects.map((subject) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  subject.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${subject.mark.toStringAsFixed(1)}%',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getGradeColor(
                                          context,
                                          subject.grade,
                                        ).withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        subject.grade,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _getGradeColor(
                                            context,
                                            subject.grade,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge?.color?.withOpacity(0.7),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getGradeColor(BuildContext context, String grade) {
    final gradeColors = Theme.of(context).extension<GradeColors>();
    if (gradeColors == null) return Colors.grey;
    switch (grade) {
      case 'A':
        return gradeColors.a!;
      case 'B':
        return gradeColors.b!;
      case 'C':
        return gradeColors.c!;
      default:
        return gradeColors.f!;
    }
  }
}
