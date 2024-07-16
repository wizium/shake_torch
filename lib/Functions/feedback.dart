import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';

import '../screens/login.dart';
import '../widgets/Home_Drawer.dart';

void sendEmail({
  required Uint8List image,
  required String messageText,
}) async {
  if (auth.currentUser == null) {
    Get.snackbar(
      "Error",
      "Please login first",
      mainButton: TextButton(
        onPressed: () {
          Get.to(const LoginScreen());
        },
        child: const Text("Login"),
      ),
    );
    return;
  }
  // Get application cache directory
  Directory directory = await getApplicationCacheDirectory();
  File tempFile = File("${directory.path}/Screenshot.png");
  await tempFile.writeAsBytes(image);

  // Configure SMTP server (replace with your actual credentials)
  final smtpServer = gmail('qsssoftnic@gmail.com', 'vulu fwwi psvf zoqh');

  // Create email message
  final message = Message()
    ..from = Address(auth.currentUser!.email!, auth.currentUser!.displayName!)
    ..recipients.add(const Address("wizium123@gmail.com"))
    ..subject = 'Feedback for Shake Torch'
    ..text = messageText
    ..html = '''
      <h1>User Feedback</h1>
      <p><strong>User Email:</strong> ${auth.currentUser!.email}</p>
      <p><strong>User Message:</strong><br>$messageText</p>
      <p><strong>User Profile:</strong></p>
      <p><img src="${auth.currentUser!.photoURL}"></p>
      <p><strong>Device info:</strong> ${await DeviceInfoPlugin().androidInfo}</p>
      <p><strong>Reference Image:</strong></p>
    '''
    ..attachments.add(FileAttachment(tempFile))..html;

  try {
    // Send email
    await send(message, smtpServer);
    Fluttertoast.showToast(msg: "Thank you for your feedback");
  } catch (e) {
    Fluttertoast.showToast(msg: "Failed to send feedback");
    print("Failed to send email: $e");
  }
}
