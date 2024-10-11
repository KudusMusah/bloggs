import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> selectImageFromGalery() async {
  try {
    final XFile? selected_file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (selected_file == null) {
      return null;
    }
    return File(selected_file.path);
  } catch (e) {
    return null;
  }
}
