import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';
import 'package:sqflite_test/model/breed/breed.dart';
import 'package:sqflite_test/repository/breed-repository.dart';
import 'package:sqflite_test/util/request-image.dart';

class UpdateBreedBloc {
  final BreedRepository _repository = BreedRepository();
  final PublishSubject<Breed> _subject = PublishSubject<Breed>();
  final PublishSubject<String> _subjectForImage = PublishSubject<String>();

  updateBreed(Breed breed) async {
    print("AddBreedBloc: insertNewBreed");

    if (breed == null) {
      _subject.addError("DISABLED");
    } else if (breed.name == "") {
      _subject.addError("Insert a name for this breed.");
    } else if (breed.weight == null) {
      _subject.addError("Insert a medium weight for this breed.");
    } else if (breed.size == null) {
      _subject.addError("Insert a medium size for this breed.");
    } else if (breed.about == null) {
      _subject.addError("Insert a basic description for this breed.");
    } else if (breed.picture == "null" ||
        breed.picture == "" ||
        breed.picture == null) {
      breed.picture = "";
      await _repository.updateBreed(breed);
    } else {
      await _repository.updateBreed(breed);
    }
  }

  requestImage(ImageSource source) async {
    print("AddBreedBloc: requestImage");
    var imageFile = await ImagePicker.pickImage(source: source);
    var imgName = "breed_img";

    if (imageFile != null) {
      var pic = await RequestImage(
        imageFile,
        originalSize: 1024,
      ).buildFinalImage(imgName);

      _subjectForImage.sink.add(pic.path);
    } else {
      _subjectForImage.sink.add("");
    }
  }

  dispose() {
    print("AddBreedBloc: dispose");
    _subject.close();
    _subjectForImage.close();
  }

  PublishSubject<Breed> get subject => _subject;

  PublishSubject<String> get subjectForImage => _subjectForImage;
}

final bloc = UpdateBreedBloc();
