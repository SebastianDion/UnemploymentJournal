import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:unemployementjournal/app_colors.dart';
import 'package:unemployementjournal/models/daily_notes.dart';

class Dailynotes extends StatefulWidget {
  final DateTime selectedDate;

  const Dailynotes({super.key, required this.selectedDate});

  @override
  State<Dailynotes> createState() => _DailynotesState();
}

class _DailynotesState extends State<Dailynotes> {
  String noteContent = "";

  void loadNote() {
    final box = Hive.box<DailyNotes>('daily_notes');

    String dateKey = widget.selectedDate.toIso8601String().split('T')[0];

    final note = box.get(dateKey);

    if (note != null) {
      setState(() {
        noteContent = note.content;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 10.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 16),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 30.0),
            child: Row(
              children: [
                Text(
                  DateFormat('EEEE,\ndd MMMM yyyy').format(widget.selectedDate),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'AzeretMono',
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          Center(
            child: Container(
              width: 350.0,
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColors.dailynotes,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  noteContent.isEmpty ? "No note for this day" : noteContent,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'AzeretMono',
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
