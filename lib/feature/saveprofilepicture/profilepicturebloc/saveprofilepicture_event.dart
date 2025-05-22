part of 'saveprofilepicture_bloc.dart';

sealed class ProfilPictureEvent {}

final class ProilePictureSaveEvent extends ProfilPictureEvent {
  final CameraWithPosition profiledata;
  ProilePictureSaveEvent(this.profiledata);
}

final class ResetProfileDataEvent extends ProfilPictureEvent {}