

import 'package:flutter/material.dart';
import 'package:unemployementjournal/app_colors.dart';

class Dailynotes extends StatefulWidget {
  const Dailynotes({super.key});

  @override
  State<Dailynotes> createState() => _DailynotesState();
}

class _DailynotesState extends State<Dailynotes> {
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
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 16,
              ),
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
                  "Wednesday,\n12th of June",
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
                  height: 150,
                  width: 350.0,
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
        ],
      ),
    );
  }
}