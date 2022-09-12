import 'package:flutter/material.dart';

class SavedItem extends StatelessWidget {
  const SavedItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.group_add,
        color: Colors.black,
      ),
    );
  }
}
