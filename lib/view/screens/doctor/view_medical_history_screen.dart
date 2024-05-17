import 'package:flutter/material.dart';

class ViewMedicalHistoryScreen extends StatelessWidget {
  const ViewMedicalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Medical History', style: TextStyle(
            color: Colors.black
        ),
        ),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
