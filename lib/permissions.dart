import 'package:permission_handler/permission_handler.dart';

class Permissions {
  /// Request Camera Permission
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      print("✅ Camera permission granted");
      return true;
    } else if (status.isDenied) {
      print("❌ Camera permission denied");
      return false;
    } else if (status.isPermanentlyDenied) {
      print("❌ Camera permission permanently denied");
      await openAppSettings(); // Open settings to manually allow
      return false;
    }
    return false;
  }

  /// Request Storage Permissions (Handles Android 13+)
  static Future<bool> requestStoragePermission() async {
    // Android 13 and above uses these
    if (await Permission.photos.isGranted || await Permission.photos.request().isGranted) {
      print("✅ Photos permission granted (Android 13+)");
      return true;
    }

    // Fallback for older Android versions
    final status = await Permission.storage.request();

    if (status.isGranted) {
      print("✅ Storage permission granted");
      return true;
    } else if (status.isDenied) {
      print("❌ Storage permission denied");
      return false;
    } else if (status.isPermanentlyDenied) {
      print("❌ Storage permission permanently denied");
      await openAppSettings();
      return false;
    }

    return false;
  }

  /// Optional: Request Full Access for Android 11+ (not Play Store friendly)
  static Future<bool> requestManageExternalStorage() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      print("✅ MANAGE_EXTERNAL_STORAGE permission granted");
      return true;
    } else {
      print("❌ MANAGE_EXTERNAL_STORAGE permission denied");
      await openAppSettings();
      return false;
    }
  }

  /// Request All Needed Permissions
  static Future<bool> requestAllPermissions() async {
    bool camera = await requestCameraPermission();
    bool storage = await requestStoragePermission();

    return camera && storage;
  }
}
