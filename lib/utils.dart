import 'package:intl/intl.dart';

final format = DateFormat('E, dd-MM-yyyy HH:mm');

String formatDate({int? millis, DateTime? dt}) {
  var dateTime = millis != null ? DateTime.fromMillisecondsSinceEpoch(millis) : (dt ?? DateTime.now());
  return format.format(dateTime);
}
