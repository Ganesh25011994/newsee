import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/AppData/app_constants.dart';
import 'package:newsee/Model/image_capture_dialog.dart';
import 'package:newsee/Utils/geolocator.dart';
import 'package:newsee/feature/saveprofilepicture/profilepicturebloc/saveprofilepicture_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  Uint8List? profilebytes;
  Position? geoPosition;

  cancel(BuildContext context) {
    return "cancel string";
  }

  @override 
  Widget build(BuildContext context) {
    final profileBloc = GetIt.instance<SaveProfilePictureBloc>();

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;  

    return BlocProvider.value (
      value: profileBloc,
      child: GestureDetector(
        onVerticalDragDown: (context) => GoRouter.of(this.context).pop(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile Picture',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: BlocBuilder<SaveProfilePictureBloc, ProfilPictureState>(
            builder: (context, state) {
              final image = state.profilepicturedetails?.imageData;
              if (image != null) {
                profilebytes = image;
              }
              return SizedBox(
                child: Column(
                  children: [
                    Center(
                      child: profilebytes != null ? 
                        Image.memory(
                          profilebytes!,
                          width: screenwidth * 0.8,
                          height: screenheight * 0.6,
                        ) : 
                        Container(
                          width: screenwidth * 0.8,
                          height: screenheight * 0.6,
                          color: Colors.grey[300],
                          child: const Icon(Icons.person, size: 50),
                        ),
                    ),
                    Listener(
                      child: (geoPosition != null && profilebytes != null) ? Container(
                        padding: EdgeInsets.fromLTRB(screenwidth * 0.1, 5, screenwidth * 0.1, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.amber
                              ),
                              child: Row(
                                children: [
                                  Text("lat: "),
                                  Text((geoPosition?.latitude).toString(), style: TextStyle(backgroundColor: Colors.white))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.amber
                              ),
                              child: Row(
                                children: [
                                  Text("long: "),
                                  Text((geoPosition?.longitude).toString(), style: TextStyle(backgroundColor: Colors.white))
                                ],
                              ),
                            )
                          ],
                        ),
                      ) : const SizedBox.shrink()
                    ),
                    SizedBox(
                      height: (screenheight * 0.2),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            final List<FilePickingOptionList> actions = [
                              FilePickingOptionList(title: "CAMERA", icon: Icons.linked_camera, location: false),
                              FilePickingOptionList(title: "GALLERY", icon: Icons.satellite_rounded, location: false),
                              FilePickingOptionList(title: "CANCEL", icon: Icons.cancel, location: false)
                            ];
                            final result = await showMediaPickerActionSheet(
                              context: context,
                              actions: actions
                            );
                            if (result != null && context.mounted) {
                              if (result.title == "CAMERA") {
                                final getimage = await onCameraTap(context, result.location );
                                if (getimage != null && context.mounted) {
                                  context.read<SaveProfilePictureBloc>().add(
                                    ProilePictureSaveEvent(
                                      getimage,
                                    )
                                  );
                                }
                              } else if (result.title == "GALLERY") {
                                final getimage = await onGalleryTap(context);
                                if (getimage != null && context.mounted) {
                                  context.read<SaveProfilePictureBloc>().add(
                                    ProilePictureSaveEvent(
                                      getimage!
                                    )
                                  );
                                }
                              } else if (result.title == "FILE") {
                                await onFileTap(context);
                              }
                            }
                          }, 
                          child: Text("Captrue Image")
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          )
        ),
      )
      
    );
  }
}