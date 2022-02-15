import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key? key,
    required this.icon,
    required this.couleur,
  }) : super(key: key);
  final IconData icon;
  final MaterialColor couleur;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: couleur,
        child: Icon(
          icon,
          color: Colors.white,
          size: 36,
        ),
      ),
    );
  }
}
