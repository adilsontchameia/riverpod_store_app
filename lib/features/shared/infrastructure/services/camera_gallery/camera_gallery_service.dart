abstract class CameraGalleryService {
  Future<String?> takePhoto();
  Future<String?> selectPhoto();
  Future<String?> chooseMediaSource(bool isCamera);
}
