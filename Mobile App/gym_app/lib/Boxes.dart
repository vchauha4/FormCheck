
import 'package:hive/hive.dart';

import 'modelClassStats.dart';

class Boxes{
  static Box<DataStats> getData() =>
      Hive.box<DataStats>('stats');

}