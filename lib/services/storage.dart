import 'dart:typed_data';
import 'imports.dart';

/*
Questo pacchetto non si puo usare nel web:
import 'dart:io';
 */

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;
  String error = '';

  ///funziona su computer ma non su mobile
  Future<String?> uploadImage(Uint8List data, String name) async {
    try {
      //Create the reference of the file
      final Reference imageRef = storage.ref('test/$name');

      //Upload the file to firebase
      await imageRef.putData(data);

      //Return the download url of the image
      return await imageRef.getDownloadURL();
    } on FirebaseException catch (e) {
      error = e.message!;
      return null;
    } catch (e) {
      error = e.toString();
      return null;
    }
  }

  ///non funziona
  /*
  Future<void> uploadImage(Uint8List image) async {
    const uuid = Uuid();
    String id = uuid.v1() + '.jpg';

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
    );
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('graphs')
        .child('/$id');
    UploadTask uploadTask;

    File createFileFromBytes(Uint8List image) => File.fromRawPath(image);
    createFileFromBytes(image);
    uploadTask = ref.putData(image, metadata);

  }*/

  Future<String?> getImageUrl(String imageName) async {
    try {
      final Reference imageRef = storage.ref('test/$imageName');
      String imageURL = await imageRef.getDownloadURL();
      print(imageURL);
      return imageURL;
    } on FirebaseException catch (e) {
      error = e.message!;
      return null;
    } catch (e) {
      error = e.toString();
      return null;
    }
  }
}
