import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      // Write 500 words
      body: const Padding(
        padding: EdgeInsets.all(32.0),
        child: Text(
          "Welcome to our application. By using our services, you agree to comply with and be bound by the following terms and conditions. Please review them carefully. If you do not agree with any of these terms, you are prohibited from using or accessing this app. The content of the pages of this application is for your general information and use only. It is subject to change without notice. Unauthorized use of this application may give rise to a claim for damages and/or be a criminal offense. Your use of any information or materials on this application is entirely at your own risk, for which we shall not be liable. It shall be your own responsibility to ensure that any products, services, or information available through this application meet your specific requirements. This application contains material which is owned by or licensed to us. Reproduction is prohibited without prior consent.",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
