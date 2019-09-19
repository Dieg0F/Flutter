import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as imagePgk;
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

const thumbPath = "_thumb";
const watermark = "/watermark.png";
const watermarkPath = "assets/icons/watermark.png";
const watermarkHorizontalPadding = 25;
const watermarkVerticalPadding = 25;
const defaultQuality = 100;

class RequestImage {
  Image image;
  String localPath;

  RequestImage(File fileImage, {int originalSize}) {
    Image imgObject = getImageFromFile(fileImage);
    if (imgObject.width > originalSize) {
      this.image = imagePgk.copyResize(imgObject, width: originalSize);
    } else {
      this.image = imgObject;
    }
  }

  Image getImageFromFile(File fileImage) {
    var fileFullName = fileImage.path.split("/").last;
    var fileType = fileFullName.split('.').last;
    Image image;

    print("Image name: " + fileFullName + " - Type: " + fileType);

    switch (fileType.toLowerCase()) {
      case "png":
        image = imagePgk.decodePng(fileImage.readAsBytesSync());
        break;
      case "tiff":
        image = imagePgk.decodeTiff(fileImage.readAsBytesSync());
        break;
      case "tga":
        image = imagePgk.decodeTga(fileImage.readAsBytesSync());
        break;
      case "gif":
        image = imagePgk.decodeGif(fileImage.readAsBytesSync());
        break;
      case "jpg":
        image = imagePgk.decodeJpg(fileImage.readAsBytesSync());
        break;
      case "jpeg":
        image = imagePgk.decodeJpg(fileImage.readAsBytesSync());
        break;
      default:
        image = imagePgk.decodeImage(fileImage.readAsBytesSync());
    }

    return image;
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
        thumbPath +
        DateTime.now().millisecond.toString() +
        ".jpg";

    File(thumbnailPath)
        .writeAsBytesSync(imagePgk.encodeJpg(thumbnail, quality: imageQuality));

    print("File Thumbnail: " + thumbnailPath);

    return File(thumbnailPath);
  }

  Future<File> buildFinalImage(
    String pictureName, {
    int imageQuality = 100,
  }) async {
    var wmImage = await loadWatermark();

    var wmXPosition =
        (this.image.width - wmImage.width) - watermarkHorizontalPadding;
    var wmYPosition =
        (this.image.height - wmImage.height) - watermarkVerticalPadding;

    var imageComplete = imagePgk.copyInto(this.image, wmImage,
        dstX: wmXPosition, dstY: wmYPosition);

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
