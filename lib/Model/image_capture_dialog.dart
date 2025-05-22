import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsee/AppData/app_constants.dart';

/* 
@author         :   faneshkumar.b    14/05/2025
@description    :   Action Sheet for accessing camera, gallery or file.
@props          :   possible props BuildContext, List<FilePickingOptionList>

 */

showMediaPickerActionSheet(
  {
    required BuildContext context,
    required List<FilePickingOptionList> actions
  }
) {
  // return showCupertinoModalPopup(
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: actions.map((option) {
            return ListTile(
              leading: Icon(option.icon),
              title: Text(option.title),
              onTap: () {
                if(context.mounted && option.title != 'CANCEL') {
                  Navigator.pop(context, option);
                } else {
                  Navigator.pop(context);
                }
              },
            );
          }).toList()
        ),
      )
        
        // actions.where((option) => option.title != 'CANCEL').map((picker) => 
        // BottomSheetAction(
        //   title: const Text('Document Type'),
        //   leading: const Text('select document from '),
        //   onPressed: (context) {}
        // )
    

      
          // (BuildContext context) => (
          //   title: const Text('Document Type'),
          //   // message: const Text('select document from '),
          //   onPressed: actions
          //     .where((option) => option.title != 'CANCEL')
          //     .map((picker) => CupertinoActionSheetAction
          //       child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Icon(picker.icon),
          //             SizedBox(width: 8),
          //             Text(picker.title),
          //           ],
          //         ),
          //       onPressed: () async {
          //         if(context.mounted) {
          //           Navigator.pop(context, picker);
          //         }
          //       },
          //     )).toList(),
          //     cancelButton: CupertinoActionSheetAction(
          //       isDestructiveAction: true,
          //       onPressed: () {
          //         Navigator.pop(context);
          //         // actions.firstWhere((a) => a.title == "CANCEL").callback(context);
          //       },
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(Icons.cancel),
          //           SizedBox(width: 8),
          //           Text("Cancel"),
          //         ],
          //       ),
          //     ),
           
          // ),
    );
}