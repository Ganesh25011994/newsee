/*
 @created on : May 16,2025
 @author : Akshayaa 
 Description : A reusable widget that provides a dropdown integrated with the reactive form.
               controlName is the name of the form control tied to this dropdown. label is displayed as the input label.
               items are the list of selectable string options.
*/

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

Widget Dropdown({
  required String controlName,
  required String label,
  required List<String> items,
  required BuildContext context,
  bool? mantatory,
  Function? onchange,
}) {
  return Padding(
    padding: EdgeInsets.all(14),
    child: Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: RichText(
              text: TextSpan(
                text: label,
                style: TextStyle(
                  color: Colors.black, 
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                    text: mantatory == null ? ' *' : '',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
        ),
        SizedBox(
          height: 5,
        ),
        ReactiveDropdownField<String>(
          formControlName: controlName,
          validationMessages: {
            ValidationMessage.required: (error) => '$label is required',
          },
          onChanged: (value) {
            print("onchanging here, $value");
            onchange == null ? null : onchange(value);
          },
          decoration: InputDecoration(
              filled: true, // Enables background color
              fillColor: Colors.grey.shade200, // Your background shade
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none, // Remove default border
              ),
              hintText: 'Select $label',
              hintStyle: TextStyle(
                color: Colors.grey,
                overflow: TextOverflow.fade
              ),
            // label: RichText(
            //   text: TextSpan(
            //     text: label,
            //     style: TextStyle(color: Colors.black, fontSize: 16),
            //     children: [
            //       TextSpan(
            //         text: mantatory == null ? ' *' : '',
            //         style: TextStyle(color: Colors.red),
            //       ),
            //     ],
            //   ),
            // ),
          ),
          items:
              items
                  .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                  .toList(),
        ),
      ],
    ),
  );
}
