import 'package:intl/intl.dart';

// 时间转换将秒转换为分钟：秒
String durationTransform(int seconds) {
  int m = (seconds / 60).truncate();
  int s = seconds - m * 60;
  if (s < 10) {
    return '$m:0$s';
  }
  return '$m:$s';
}

// 数字转万
String countFormat(int count) {
  String views = "";
  if (count > 9999) {
    views = "${(count / 10000).toStringAsFixed(2)}万";
  } else {
    views = count.toString();
  }
  return views;
}

// 日期格式化，2006-01-02 15:04:05 -> 06-11
String dataMonthAndDay(String dateStr) {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('MM-dd');
  String formatted = formatter.format(now);
  return formatted;
}
