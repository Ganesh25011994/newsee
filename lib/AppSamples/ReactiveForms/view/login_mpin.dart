import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void mpin(
  BuildContext context,
  
) {
  showCupertinoModalPopup<void>(
    context: context,
    builder:
        (BuildContext context) => CupertinoActionSheet(
          title: Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
          ),

          actions: [
            Column(
              children: [
                CupertinoActionSheetAction(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        number1,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Icon(
                        icon,
                        color: const Color.fromARGB(255, 32, 219, 35),
                        size: 30,
                      ),
                    ],
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        number2,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Icon(
                        icon,
                        color: const Color.fromARGB(255, 32, 219, 35),
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
  );
}
