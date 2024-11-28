import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: ErrorStateList(
            imageAssetName: 'assets/images/—Pngtree—red error icon_5418881.png',
            errorMessage:
                'No Internet Connection',
            onRetry: () {
              debugPrint("Reload the Page");
            }),
      ),
    ),
  );
}

class ErrorStateList extends StatelessWidget {
  final String imageAssetName;
  final String errorMessage;
  final VoidCallback onRetry;

  const ErrorStateList(
      {super.key,
      required this.imageAssetName,
      required this.errorMessage,
      required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageAssetName,
              width: 100,
              height: 100,
            ),
            // Suggested code may be subject to a license. Learn more: ~LicenseLog:4090511140.
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Something went wrong...",
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            OutlinedButton(
              onPressed: onRetry,
              child: const Text('Try Again'),
            ),
            const Text("or"),
            TextButton(onPressed: () {}, child: const Text("Contact Support")),
          ],
        ),
      ),
    );
  }
}
