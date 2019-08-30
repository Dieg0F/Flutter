import 'package:rxdart/subjects.dart';
import 'package:sqflite_test/model/breed/breed.dart';
import 'package:sqflite_test/repository/breed-repository.dart';

class BreedsBloc {
  final BreedRepository _repository = BreedRepository();
  final BehaviorSubject<List<Breed>> _subject = BehaviorSubject<List<Breed>>();
  final BehaviorSubject<List<Breed>> _subjectAuxForRemoveItems =
      BehaviorSubject<List<Breed>>();
  final BehaviorSubject<bool> _subjectForEnableMultiSelect =
      BehaviorSubject<bool>();

  getAllBreeds() async {
    print("BreedsBloc: getAllBreeds");
    List<Breed> response = await _repository.getAllBreeds();
    _subject.sink.add(response);
  }

  removeBreeds() async {
    print("removeBreeds: breedMultSelectEnable");
    List<Breed> breedList;
    breedList = _subjectAuxForRemoveItems.value;
    breedList.forEach((breed) async {
      print("Breed to remove: " + breed.id.toString());
      var res = await _repository.deleteBreed(breed.id);
      if (res == 1) {
        var newList = _subject.value;
        newList.remove(breed);
        _subject.value = newList;
        enableMultiSelectItems(false);
        print("Success!");
      } else {
        _subjectAuxForRemoveItems.addError("Fudeu");
      }
    });
  }

  breedMultSelectEnable(Breed breed) {
    print("BreedsBloc: breedMultSelectEnable");
    var itemsList = new List<Breed>();
    itemsList.add(breed);
    _subjectAuxForRemoveItems.sink.add(itemsList);
  }

  breedItemSelected(Breed breed) {
    print("BreedsBloc: breedItemSelected: " + breed.name);
    var itemsList = new List<Breed>();

    if (_subjectAuxForRemoveItems.value != null) {
      itemsList = _subjectAuxForRemoveItems.value;

      if (!itemsList.contains(breed)) {
        itemsList.add(breed);
      } else {
        itemsList.remove(breed);
      }

      if (_subjectAuxForRemoveItems.value.length == 0) {
        enableMultiSelectItems(false);
      } else {
        _subjectAuxForRemoveItems.value = itemsList;
      }
    } else {
      itemsList.add(breed);
      _subjectAuxForRemoveItems.sink.add(itemsList);
    }
  }

  enableMultiSelectItems(bool isEnabled) {
    print("BreedsBloc: enableMultiSelectItems: " + isEnabled.toString());
    _subjectForEnableMultiSelect.value = isEnabled;
    print(_subjectAuxForRemoveItems.value);
    if (_subjectAuxForRemoveItems.value != null) {
      _subjectAuxForRemoveItems.value = null;
    }
  }

  dispose() {
    print("BreedsBloc: dispose");
    _subject.close();
  }

  BehaviorSubject<List<Breed>> get subject => _subject;
  BehaviorSubject<List<Breed>> get subjectAuxForRemoveItems =>
      _subjectAuxForRemoveItems;
  BehaviorSubject<bool> get subjectForEnableMultiSelect =>
      _subjectForEnableMultiSelect;
}

final bloc = BreedsBloc();
