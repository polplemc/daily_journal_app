import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: EmptyStateList(
        imageAssetName: 'assets/images/_Pngtree_empty_box_icon_for_your_4820798-removebg-preview.png',
        title: 'Oppsss... There are no Journal Entries here',
        description: "Tap the '+' to add a new journal entry",
      ),
    ),
  ));
}

class EmptyStateList extends StatelessWidget {
  final String imageAssetName;
  final String title;
  final String description;

  const EmptyStateList(
      {super.key,
      required this.imageAssetName,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Center(
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
          Text(
            title,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            description,
          ),
        ],
      ),
    );
  }
}
