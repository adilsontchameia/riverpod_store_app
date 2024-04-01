import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/camera_gallery/camera_gallery_service.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> selectPhoto() async {
    return await chooseMediaSource(false);
  }

  @override
  Future<String?> takePhoto() async {
    return await chooseMediaSource(true);
  }

  @override
  Future<String?> chooseMediaSource(bool isCamera) async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
      );

      if (photo == null) return null;

      log('Image: ${photo.path}');

      return photo.path;
    } catch (e) {
      isCamera ? log('Camera Error: $e') : log('Gallery Error: $e');
    }
    return null;
  }
}
