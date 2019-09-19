import 'dart:io';
import 'dart:ui';

import 'package:pfeed/models/picture.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as imagePgk;
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

const watermark = "/flutter.png";
const watermarkPath = "assets/icons/flutter.png";
const defaultQuality = 100;

class ImageOptions {
  Image image;
  String localPath;

  ImageOptions(File fileImage, {int originalSize}) {
    Image imgObject = imagePgk.decodeJpg(fileImage.readAsBytesSync());
    if (imgObject.width > originalSize) {
      this.image = imagePgk.copyResize(imgObject, width: originalSize);
    } else {
      this.image = imgObject;
    }
  }

  Future<Picture> toPicture(
    String pictureName, {
    int imageQuality,
    int thumbSize,
  }) async {
    var pic = new Picture();
    pic.name = pictureName;
    pic.originalFile =
        await buildFinalImage(pic.name, imageQuality: imageQuality);
    pic.thumbnail = await buildThumbnailImage(pic.name, thumbSize: thumbSize);

    return pic;
  }

  Future<File> buildThumbnailImage(
    String pictureName, {
    int thumbSize = 480,
    int imageQuality = 100,
  }) async {
    Image thumbnail;

    thumbnail = imagePgk.copyResizeCropSquare(this.image, thumbSize);

    var thumbnailPath = this.localPath +
        "/" +
        pictureName +
        "_thumbnail_" +
        DateTime.now().millisecond.toString() +
        ".jpg";
    File(thumbnailPath)
        .writeAsBytesSync(imagePgk.encodeJpg(thumbnail, quality: imageQuality));

    print("File Thumbnail: " + thumbnailPath);

    return File(thumbnailPath);
  }

  Future<File> buildFinalImage(
    String pictureName, {
    int imageQuality,
  }) async {
    var imageComplete = imagePgk.copyInto(this.image, await loadWatermark());
    var imageCompletePath = this.localPath +
        "/" +
        pictureName +
        "_" +
        DateTime.now().millisecond.toString() +
        ".jpg";
    File(imageCompletePath).writeAsBytesSync(
        imagePgk.encodeJpg(imageComplete, quality: imageQuality));

    print("File Original: " + imageCompletePath);

    return File(imageCompletePath);
  }

  Future<Image> loadWatermark() async {
    Directory directory = await getApplicationDocumentsDirectory();
    this.localPath = directory.path;
    var watermarkDir = directory.path + watermark;

    if (!(await File(watermarkDir).exists())) {
      var data = await rootBundle.load(watermarkPath);
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      File(watermarkDir).writeAsBytesSync(bytes);
    }

    Image wtmkImage = imagePgk.decodePng(File(watermarkDir).readAsBytesSync());

    return wtmkImage;
  }
}
