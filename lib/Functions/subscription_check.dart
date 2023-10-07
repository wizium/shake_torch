import '/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

subscriptionCheck(Timestamp endDate) async {
  if (endDate.toDate().isAfter(DateTime.now())) {
    sharedPreferences.setBool("isPro", true);
  } else {
    sharedPreferences.setBool("isPro", false);
  }
  isPro.init();
}
