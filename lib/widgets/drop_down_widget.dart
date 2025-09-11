/*
 @created on : May 16,2025
 @author : Akshayaa 
 Description : A reusable reactive text field integrated with the reactive forms package.
*/

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

// ignore: must_be_immutable
class DropDownWidget extends StatelessWidget {
  String controlName;
  String label;
  List<String> items;
  BuildContext context;
  bool? mantatory;
  Function? onchange;
  DropDownWidget({
    required this.controlName,
    required this.label,
    required this.items,
    required this.context,
    this.mantatory,
    this.onchange,
  });

  @override
  Widget build(BuildContext context) {
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
              onchange == null ? null : onchange!(value);
            },
            decoration: InputDecoration(
              filled: true, // Enables background color
              fillColor: Colors.grey.shade100, // Your background shade
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none, // Remove default border
              ),
            ),
            hint: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                'Select $label',
                style: TextStyle(color: Colors.grey),
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.ellipsis, // or TextOverflow.visible
              ),
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
}
