import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String trailing;
  final Color color;
  final dynamic onTap;
  const CustomListTile(
      {Key? key,
      required this.title,
      required this.icon,
      required this.trailing,
      required this.color,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white),
      child: ListTile(
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: color.withAlpha(30)),
            child: Center(
              child: Icon(
                icon,
                color: color,
              ),
            ),
          ),
          title: Text(title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold)),
          trailing: SizedBox(
            width: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(trailing,
                    style:
                        const TextStyle(color: Colors.black, fontSize: 13.0)),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          onTap: onTap),
    );
  }
}
