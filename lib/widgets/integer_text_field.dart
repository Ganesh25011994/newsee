/*
 @created on : May 16,2025
 @author : Akshayaa 
 Description : A reusable text input field for accepting only integer values,integrated with the reactive forms package.
*/

import 'package:flutter/material.dart';
import 'package:newsee/pages/rupeeformatter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class IntegerTextField extends StatelessWidget {
  final String controlName;
  final String label;
  final bool mantatory;
  final int? maxlength;
  final int? minlength;
  final bool isRupeeFormat;
  final Key? fieldKey;
  IntegerTextField({
    this.fieldKey,
    required this.controlName,
    required this.label,
    required this.mantatory,
    this.maxlength,
    this.minlength,
    this.isRupeeFormat = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: RichText(
                text: TextSpan(
                  text: label,
                  style: const TextStyle(
                    color: Colors.black, 
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                  children: [
                    TextSpan(
                      text: mantatory ? ' *' : '',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
          ),
          SizedBox(
            height: 5,
          ),
          ReactiveTextField<String>(
            key: fieldKey,
            autofocus: false,
            formControlName: controlName,
            keyboardType: TextInputType.number,
            maxLength: maxlength,
            inputFormatters: [if (isRupeeFormat) Rupeeformatter()],
            decoration: InputDecoration(
              filled: true, // Enables background color
              fillColor: Colors.grey.shade100, // Your background shade
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none, // Remove default border
              ),
              hintText: 'Select $label',
              hintStyle: TextStyle(
                color: Colors.grey
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never, // Disable floating
              // label: RichText(
              //   text: TextSpan(
              //     text: label,
              //     style: TextStyle(color: Colors.black, fontSize: 16),
              //     children: [
              //       TextSpan(
              //         text: mantatory ? ' *' : '',
              //         style: TextStyle(color: Colors.red),
              //       ),
              //     ],
              //   ),
              // ),
            ),
            validationMessages: {
              ValidationMessage.required: (error) => '$label is required',
              ValidationMessage.pattern: (error) => 'Valid $label is required',
              ValidationMessage.maxLength:
                  (error) => 'Maximum $maxlength numbers only allowed',
              ValidationMessage.minLength:
                  (error) => 'Minimum $minlength numbers required',
              ValidationMessage.max: (error) => 'Loan Amount not allowed',
            },
          ),
        ],
      ),
    );
  }
}
