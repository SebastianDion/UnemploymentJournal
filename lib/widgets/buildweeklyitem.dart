import 'package:flutter/material.dart';
import 'package:unemployementjournal/app_colors.dart';

Widget buildweeklyitem({
  required String title,
  required bool isDone,
  required VoidCallback onTap,
}){
  return Center(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.0,
        width: 290.0,
        margin: const EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.calendarGradientStart,
              AppColors.calendarGradientEnd,
            ],
            stops: [0.59, 1.0],
          ),
        ),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'AzeretMono',
                  fontWeight: FontWeight.w200,
                  decoration:
                      isDone ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),

          isDone ? 
          Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child:
                 const Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 20,
                ),
              )
              : Container(
                  width: 20,
                  height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                ),),
            ],)
        ),
      )
    ),
  );

}