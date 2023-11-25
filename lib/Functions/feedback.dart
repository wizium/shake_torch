import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';

late Directory directory;
void sendEmail(Uint8List image, messageText) async {
  directory = await getApplicationCacheDirectory();
  File tempFile = File("${directory.path}/.Screenshot.png");
  await tempFile.writeAsBytes(image);
  final smtpServer = gmail('qsssoftnic@gmail.com', 'vulu fwwi psvf zoqh');

  final message = Message()
    ..from = const Address('qsssoftnic@gmail.com')
    ..recipients.add(
      const Address('wizium123@gmail.com'),
    )
    ..subject = 'Feedback To Shake torch'
    ..text = messageText
    ..html = '<h1>Reference Image</h1>'
    ..attachments.add(
      FileAttachment(
        tempFile,
        fileName: "Screenshot.png",
      )..location = Location.attachment,
    );
  try {
    await send(message, smtpServer);
    Get.snackbar("Success", "Thank you for your feedback");
  } catch (e) {
    Get.snackbar("Sorry", "Something went wrong");
  }
}
