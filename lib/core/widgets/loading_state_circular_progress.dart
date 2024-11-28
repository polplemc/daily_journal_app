import 'package:flutter/material.dart';

// Suggested code may be subject to a license. Learn more: ~LicenseLog:4080622739.
void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: LoadingStateCircularProgress(),
    ),
  ));
}

class LoadingStateCircularProgress extends StatelessWidget {
  const LoadingStateCircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16
          ,),
          Text("Loading... Please wait...")
        ],
      ),
    );
  }
}
