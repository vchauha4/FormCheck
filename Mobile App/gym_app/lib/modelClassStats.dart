import 'package:hive/hive.dart';

part 'modelClassStats.g.dart';


@HiveType(typeId: 0)
class DataStats extends HiveObject{

  @HiveField(0)
  int BenchCount=0;

  @HiveField(1)
  int SquatsCount=0;

  @HiveField(2)
  int DeadliftCount=0;


  @HiveField(3)
  double BenchScore=0.0;

  @HiveField(4)
  double SquatsScore=0.0;

  @HiveField(5)
  double DeadliftScore=0.0;

  @HiveField(6)
  String Name="Itachi Uchiha";

  @HiveField(7)
  String picture='';




}