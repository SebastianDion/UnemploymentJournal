import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unemployementjournal/app_colors.dart';
import 'package:unemployementjournal/dailynotes.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

Widget buildDateCell(DateTime date) {
  String dayNumber = DateFormat('dd').format(date);
  String dayName = DateFormat('E').format(date);

  return Column(
    mainAxisSize: MainAxisSize.min,

    children: [
      Text(
        dayNumber,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w100,
          fontFamily: 'AzeretMono',
        ),
      ),
      Text(
        dayName,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w100,
          fontFamily: 'AzeretMono',
        ),
      ),
    ],
  );
}

class _HomescreenState extends State<Homescreen> {
  bool studyDone = false;
  bool lookForJobDone = false;
  bool makeVideoDone = false;

  Future<void> saveStudyStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('studyDone', value);
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
  return int.parse(DateFormat("w").format(date));
  } 
  

  Future<void> checkWeeklyReset() async {
  final prefs = await SharedPreferences.getInstance();

  int currentWeek = weekNumber(DateTime.now());
  int year = DateTime.now().year;
  int? savedWeek = prefs.getInt('savedWeek');

  int currentYear = DateTime.now().year;
  int? savedYear = prefs.getInt('savedYear');

if (savedWeek != currentWeek || savedYear != currentYear) {
    await prefs.setBool('studyDone', false);
    await prefs.setBool('lookForJobDone', false);
    await prefs.setBool('makeVideoDone', false);
    await prefs.setInt('savedWeek', currentWeek);
    await prefs.setInt('savedYear', year);

    setState(() {
      studyDone = false;
      lookForJobDone = false;
      makeVideoDone = false;
    });
  }
}

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await checkWeeklyReset();
    await loadStudyStatus();
    await loadLookForJobStatus();
    await loadMakeVideoStatus();
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
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Dailynotes()),
                  );
                },
                child: Container(
                  height: 150,
                  width: 290.0,
                  margin: const EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.calendarColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: generateRangeDates(
                                  -7,
                                  -1,
                                ).map((date) => buildDateCell(date)).toList(),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: generateRangeDates(
                                  0,
                                  6,
                                ).map((date) => buildDateCell(date)).toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
                      child: const TextField(
                        maxLines: null,
                        expands: true,
                        decoration: InputDecoration(
                          hintText: "Daily Notes goes here",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: 'AzeretMono',
                          ),
                        ),
                        style: TextStyle(
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

            buildweeklyitem(title: "Study a concept", isDone: studyDone,
             onTap: () {
              setState(() {
                studyDone = !studyDone;
              });
              saveStudyStatus(studyDone);
             }
            ),

            buildweeklyitem(title: "Look for a J*b", isDone: lookForJobDone,
             onTap: () {
              setState(() {
                lookForJobDone = !lookForJobDone;
              });
              saveLookForJobStatus(lookForJobDone);
             }
            ),

            buildweeklyitem(title: "Make a YouTube video", isDone: makeVideoDone,
             onTap: () {
              setState(() {
                makeVideoDone = !makeVideoDone;
              });
              saveMakeVideoStatus(makeVideoDone);
             }
            ),
          ],
        ),
      ),
    );
  }
}
