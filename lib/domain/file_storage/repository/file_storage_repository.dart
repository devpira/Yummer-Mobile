import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:yummer/config/config.dart';

@lazySingleton
class FileStorageRepository {
//  late FirebaseStorage _firebaseStorage;
  final AppValues _appValues;

  FileStorageRepository({
    required AppValues appValues,
  }) : _appValues = appValues {
    // _firebaseStorage = FirebaseStorage.instance;
    // _firebaseStorage.bucket = _appValues.firebaseStorageBucketPath;
  }
  Future<String?> uploadProfileImage({
    required File file,
    required String userUid,
  }) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child("/user/$userUid/profile/mainheadshot");
      final uploadTask = await storageRef.putFile(file);
      if (uploadTask.state != TaskState.success) {
        return null;
      }
      final url = await uploadTask.ref.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }
}
