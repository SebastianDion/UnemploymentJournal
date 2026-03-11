import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:unemployementjournal/app_colors.dart';
import 'package:unemployementjournal/dailynotes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unemployementjournal/models/daily_notes.dart';
import 'package:unemployementjournal/widgets/buildweeklyitem.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

List<DateTime> generateRangeDates(int start, int end) {
  DateTime now = DateTime.now();
  List<DateTime> dates = [];

  for (int i = start; i <= end; i++) {
    dates.add(now.add(Duration(days: i)));
  }

  return dates;
}

Widget buildMonth(DateTime month) {
  DateTime firstDay = DateTime(month.year, month.month, 1);
  int daysInMonth = DateTime(month.year, month.month + 1, 0).day;

  List<DateTime> days = List.generate(
    daysInMonth,
    (index) => DateTime(month.year, month.month, index + 1),
  );

  return Column(
    children: [
      const SizedBox(height: 8),
      Text(
        DateFormat('MMMM yyyy').format(month),
        style: const TextStyle(
          fontFamily: 'AzeretMono',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      Expanded(
        child: GridView.builder(
          padding: const EdgeInsets.all(5),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: days.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          itemBuilder: (context, index) {
            return buildDateCell(days[index], context);
          },
        ),
      ),
    ],
  );
}

Widget buildDateCell(DateTime date, BuildContext context) {

  DateTime today = DateTime.now();

  bool isToday =
      date.day == today.day &&
      date.month == today.month &&
      date.year == today.year;

  String formattedDate =
      date.toIso8601String().split('T')[0];

  final box = Hive.box<DailyNotes>('daily_notes');

  bool hasNote = box.containsKey(formattedDate);

  String dayNumber = DateFormat('d').format(date);

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Dailynotes(selectedDate: date),
        ),
      );
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(
          dayNumber,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'AzeretMono',
            color: isToday ? Colors.red : Colors.black,
          ),
        ),

        const SizedBox(height: 3),

        if (isToday)
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          )

        else if (hasNote)
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
      ],
    ),
  );
}

class _HomescreenState extends State<Homescreen> {
  bool studyDone = false;
  bool lookForJobDone = false;
  bool makeVideoDone = false;

  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> saveNote() async {
    final box = Hive.box<DailyNotes>('daily_notes');

    String today = DateTime.now().toIso8601String().split('T')[0];

    final existingNote = box.get(today);

    if (existingNote != null) {
      existingNote.content = _controller.text;
      await existingNote.save();
    } else {
      final newNote = DailyNotes(date: today, content: _controller.text);

      await box.put(today, newNote);
    }
  }

  void loadTodayNote() {
    final box = Hive.box<DailyNotes>('daily_notes');

    String today = DateTime.now().toIso8601String().split('T')[0];

    final note = box.get(today);

    if (note != null) {
      _controller.text = note.content;
    }
  }

  Future<void> saveStudyStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('studyDone', value);
    // print("Saved study: $value");
  }

  Future<void> saveLookForJobStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('lookForJobDone', value);
  }

  Future<void> saveMakeVideoStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('makeVideoDone', value);
  }

  Future<void> loadStudyStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      studyDone = prefs.getBool('studyDone') ?? false;
    });
  }

  Future<void> loadLookForJobStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      lookForJobDone = prefs.getBool('lookForJobDone') ?? false;
    });
  }

  Future<void> loadMakeVideoStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      makeVideoDone = prefs.getBool('makeVideoDone') ?? false;
    });
  }

  int weekNumber(DateTime date) {
    final weekString = DateFormat("w").format(date);
    return int.tryParse(weekString) ?? 0;
  }

  @override
  void initState() {
    super.initState();
    loadTodayNote();
    initData();
  }

  Future<void> initData() async {
    final prefs = await SharedPreferences.getInstance();

    int currentWeek = weekNumber(DateTime.now());
    int currentYear = DateTime.now().year;

    int savedWeek = prefs.getInt('savedWeek') ?? currentWeek;
    int savedYear = prefs.getInt('savedYear') ?? currentYear;
    if (savedWeek != currentWeek || savedYear != currentYear) {
      await prefs.setBool('studyDone', false);
      await prefs.setBool('lookForJobDone', false);
      await prefs.setBool('makeVideoDone', false);
      await prefs.setInt('savedWeek', currentWeek);
      await prefs.setInt('savedYear', currentYear);
    }

    // print("Study before load: ${prefs.getBool('studyDone')}");
    setState(() {
      studyDone = prefs.getBool('studyDone') ?? false;
      lookForJobDone = prefs.getBool('lookForJobDone') ?? false;
      makeVideoDone = prefs.getBool('makeVideoDone') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 100.0),
              child: Text(
                'Welcome back, Dion',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'AzeretMono',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Center(
              child: Container(
                height: 260,
                width: 320,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.calendarColor,
                ),
                child: PageView.builder(
                  controller: PageController(initialPage: 1000),
                  itemBuilder: (context, index) {
                    final now = DateTime.now();

                    DateTime month = DateTime(
                      now.year,
                      now.month + (index - 1000),
                    );

                    return buildMonth(month);
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 20.0),
              child: Text(
                "Daily Log",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'AzeretMono',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Center(
              child: Container(
                height: 150,
                width: 290,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.dailynotes,
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE,dd MMMM yyyy').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'AzeretMono',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onChanged: (value) {
                          saveNote();
                        },
                        maxLines: null,
                        expands: true,
                        decoration: const InputDecoration(
                          hintText: "Daily Notes goes here",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: 'AzeretMono',
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'AzeretMono',
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 20.0),
              child: Text(
                "Weekly Check-Up",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'AzeretMono',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            buildweeklyitem(
              title: "Study a concept",
              isDone: studyDone,
              onTap: () {
                setState(() {
                  studyDone = !studyDone;
                });
                saveStudyStatus(studyDone);
              },
            ),

            buildweeklyitem(
              title: "Look for a J*b",
              isDone: lookForJobDone,
              onTap: () {
                setState(() {
                  lookForJobDone = !lookForJobDone;
                });
                saveLookForJobStatus(lookForJobDone);
              },
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: buildweeklyitem(
                title: "Make a YouTube video",
                isDone: makeVideoDone,
                onTap: () {
                  setState(() {
                    makeVideoDone = !makeVideoDone;
                  });
                  saveMakeVideoStatus(makeVideoDone);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
