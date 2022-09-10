import 'package:flutter/material.dart';

class PlayerItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final bool buttonToggle;
  final VoidCallback onTap;
  const PlayerItem({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.buttonToggle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(imageUrl)),
            shape: BoxShape.circle,
          ),
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 30,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: buttonToggle ? Colors.red : Colors.blue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              buttonToggle ? 'Remove' : 'Add',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
