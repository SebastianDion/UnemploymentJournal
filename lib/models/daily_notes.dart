
import 'package:hive/hive.dart';

part 'daily_notes.g.dart';

@HiveType(typeId: 0)
class DailyNotes extends HiveObject { 
  @HiveField(0)
  String date;

  @HiveField(1)
  String content;

  DailyNotes({
  required this.date,
  required this.content});
} 