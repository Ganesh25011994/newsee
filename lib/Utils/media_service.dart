// import 'dart:io';
// import 'dart:typed_data';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:newsee/Model/loader.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:newsee/blocs/camera/camera_bloc.dart';
// import 'package:newsee/blocs/camera/camera_event.dart';
// import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsee/Model/loader.dart';
import 'package:path_provider/path_provider.dart';

class LocationResponse {
  final Position? position;
  final String? error;

  LocationResponse({this.position, this.error});
}

class MediaService {
  /* 
@author         :   ganeshkumar.b    14/05/2025
@description    :   getLocation function use GeoLocator Plugin to capture current coordinates
@props          :   BuildContext
@return data     :   Current Cooridnate like latitude and longitude value returned
 */

  Future<LocationResponse> getLocation(BuildContext context) async {
    try {
      final bool locationEnabled = await checkIsLocationServiceEnabled();
      if (!locationEnabled) {
        // return LocationResponse(
        //   error: 'Location services are disabled. Please enable GPS.',
        // );
        await handlePermissions();
      }
      Position position = await Geolocator.getCurrentPosition();
      print("gelocationdata: $position");
      return LocationResponse(position: position);
    } catch (error) {
      return LocationResponse(error: error.toString());
    }
  }

  Future<bool> checkIsLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<void> handlePermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw Exception('Location permission is denied.');
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permission is permanently denied. Please enable it from app settings.',
      );
    }
  }

  /* 
  @author         :   ganeshkumar.b    13/05/2025
  @description    :   Picking image from device and crop the image file and return the bytes data
  @props          :   BuildContext
  @return data     :   bytes(Unit8List) data return;
  */

  Future<Uint8List?> pickimagefromgallery(context, {int? docIndex}) async {
    try {
      final imagepicker = ImagePicker();
      final pickedFile = await imagepicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null && context.mounted) {
        final cropperdata = await cropper(context, pickedFile.path);
        print("croppedFileData: $cropperdata");
        final Uint8List croppedFileData = cropperdata!;
        return croppedFileData;
        // if (croppedFileData != null) {
        //   final result = await GoRouter.of(context).push<Uint8List>(
        //     '/imageview',
        //     extra: {
        //       'imageBytes': croppedFileData,
        //       if (docIndex != null) 'docIndex': docIndex,
        //     },
        //   );
        //   if (result != null && context.mounted) {
        //     return result == 'close' ? null : result;
        //   }
        // }
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Picking From Gallery is failed")));
      return null;
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
      return null;
    }
  }

  /* 
  @author         :   ganeshkumar.b    14/05/2025
  @description    :   File Picking Plugin used pick the file like pdf, jpg, png, etc., file extensions and return the result.
  @return data     :   return FilePickerResult object data
  */
  Future<FilePickerResult?> filePicker() async {
    // FilePickerResult? pdfBytes = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['pdf'],
    // );
    // if (pdfBytes != null) {
    //   return pdfBytes;
    // }
    // return null;
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null && result.files.isNotEmpty) {
        return result;
      }
    } catch (e) {
      debugPrint("File picker error: $e");
    }
    return null;
  }

  /* 
  @author         :   ganeshkumar.b    14/05/2025
  @description    :   Cropper function used to crop the image pick from camera or gallery.
  @props          :   BuildContext, XFile path
  @return data    :   return Unit8List byte data
  */
  Future<Uint8List?> cropper(context, filepath) async {
    try {
      Uint8List? croppedImage;
      double screenwidth = MediaQuery.of(context).size.width;
      double screenheight = MediaQuery.of(context).size.height;

      final intwidth = (screenwidth * 0.5).round();
      final intheight = (screenheight * 0.5).round();
      print("cropper function called is here");
      final cropdata = await ImageCropper().cropImage(
        sourcePath: filepath,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: const Color.fromRGBO(255, 255, 255, 1),
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPresetCustom(),
            ],
          ),
          WebUiSettings(
            context: context,
            presentStyle: WebPresentStyle.dialog,
            size: CropperSize(width: intwidth, height: intheight),
          ),
        ],
      );
      croppedImage = await cropdata?.readAsBytes();

      print("cropdata-imageBytes $croppedImage");
      return (croppedImage != null) ? croppedImage : null;
    } catch (error) {
      print("cropper error paster is here: $error");
      return null;
    }
  }

  Future<File> saveBytesToFile(Uint8List bytes, filename) async {
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/$filename';
    final file = File(path);
    return await file.writeAsBytes(bytes);
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}
