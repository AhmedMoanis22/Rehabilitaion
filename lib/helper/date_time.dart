import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formattedDate(Timestamp timestamp) {
  var dateFromTimeStamp =
  DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
  return DateFormat('hh:mm a').format(dateFromTimeStamp);
}
