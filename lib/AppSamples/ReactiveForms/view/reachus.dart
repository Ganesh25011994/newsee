import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'contactUs.dart';
import 'package:url_launcher/url_launcher.dart';

void reachUsActionSheet(
  BuildContext context,
  String title,
  String heading1,
  String heading2,
  String heading3,
  IconData icon1,
  IconData icon2,
  IconData icon3,
) {
  showCupertinoModalPopup<void>(
    context: context,
    builder:
        (BuildContext context) => CupertinoActionSheet(
          title: Padding(
            padding: const EdgeInsets.all(20),
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
            //whatsapp
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CupertinoActionSheetAction(
                  onPressed: () async {
                    //  whasapp();
                    final phoneNumber = "919940362579";
                    final Uri _url = Uri.parse(
                      'https://wa.me/sms:$phoneNumber',
                    );
                    // final Uri _url = Uri.parse('https://flutter.dev');

                    if (!await canLaunchUrl(_url)) {
                      throw 'Could not launch $_url';
                    } else {
                      await launchUrl(_url);
                    }
                  },
                  child: Column(
                    children: [
                      Icon(
                        icon1,
                        color: const Color.fromARGB(255, 32, 219, 35),
                        size: 30,
                      ),
                      SizedBox(height: 20),
                      Text(
                        heading1,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                //contactus
                CupertinoActionSheetAction(
                  onPressed: () {
                    contact(
                      context,
                      "Contact US",
                      "1888762666",
                      "1903833773",
                      Icons.phone,
                    );
                  },
                  child: Column(
                    children: [
                      Icon(
                        icon2,
                        color: const Color.fromARGB(255, 231, 9, 9),
                        size: 30,
                      ),
                      SizedBox(height: 20),
                      Text(
                        heading2,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                //location
                CupertinoActionSheetAction(
                  onPressed: () {},
                  child: Column(
                    children: [
                      Icon(
                        icon3,
                        color: const Color.fromARGB(255, 3, 9, 110),
                        size: 30,
                      ),
                      SizedBox(height: 20),
                      Text(
                        heading3,
                        style: TextStyle(color: Colors.black, fontSize: 20),
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
