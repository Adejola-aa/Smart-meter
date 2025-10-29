import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class UserData {
  const UserData({required this.email, required this.userName});

  final String? userName;
  final String email;
}

final FirebaseAuth _userAuth = FirebaseAuth.instance;
final firebaseUserProvider = StreamProvider<UserData?>((ref) {
  return _userAuth.authStateChanges().map((user) {
    if (user == null) return null;
    return UserData(userName: user.displayName, email: user.email.toString());
  });
});

class UserImageNotifier extends StateNotifier<File?> {
  UserImageNotifier() : super(null) {
    _loadImage();
  }

  final ImagePicker _imagePicker = ImagePicker();
  final sharedPref = SharedPreferences.getInstance();

  Future<void> pickImage() async {
    final picked = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      state = File(picked.path);
      _saveImagePath(picked.path);
    }
  }

  Future<void> _saveImagePath(String path) async {
    final prefs = await sharedPref;
    await prefs.setString('user_image_path', path);
  }

  Future<void> _loadImage() async {
    final prefs = await sharedPref;
    final savedPath = prefs.getString('user_image_path');
    if (savedPath != null && File(savedPath).existsSync()) {
      state = File(savedPath);
    }
  }
}

final userImageProvider = StateNotifierProvider<UserImageNotifier, File?>(
  (ref) => UserImageNotifier(),
);
