import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoExpansionTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;
  final double? cardWidthValue;
  final bool isExpanded;
  final VoidCallback onTap;

  const CupertinoExpansionTileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
    this.cardWidthValue,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double cardwidth = cardWidthValue ?? 12;
    print("cardwidth $cardwidth");
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.teal),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(subtitle,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black54)),
                    ],
                  ),
                ),
                Icon(
                  isExpanded
                      ? CupertinoIcons.minus_circled
                      : CupertinoIcons.add_circled,size: 20,
                  color: Colors.teal,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Card(
            margin: EdgeInsets.symmetric(horizontal: cardwidth, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0.25,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: child,
            ),
          ),
      ],
    );
  }
}