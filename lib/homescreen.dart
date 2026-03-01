import 'package:flutter/material.dart';
import 'package:unemployementjournal/app_colors.dart';
import 'package:unemployementjournal/dailynotes.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
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
              onTap: (){
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
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "Calendar wdiget goes here",
                    style: TextStyle(color: Colors.black, fontSize: 12),
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
              width: 290.0,
              margin: const EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  "Daily Notes goes here",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
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

          Center(
            child: Container(
              height: 50.0,
              width: 290.0,
              margin: const EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Study a concept",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'AzeretMono',
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
            ),

            Center(
            child: Container(
              height: 50.0,
              width: 290.0,
              margin: const EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Apply for a J*b",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'AzeretMono',
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
            ),

            Center(
            child: Container(
              height: 50.0,
              width: 290.0,
              margin: const EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Make a YouTube video",
                  style: TextStyle(
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
    ),
    );
  }
}
