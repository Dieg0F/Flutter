import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:sqflite_test/repository/breed-repository.dart';

class BreedDetailsBloc {
  final BreedRepository _repository = BreedRepository();
  final BehaviorSubject<String> _subjectActions = BehaviorSubject<String>();
  final BehaviorSubject<bool> _loading = BehaviorSubject<bool>();

  removeBreed(int breedId) async {
    _subjectActions.value = "Removing";
    await _repository.deleteBreed(breedId);
    _subjectActions.value = "Removed";
  }

  dispose() {
    print("BreedsBloc: dispose");
    _subjectActions.close();
  }

  showLoading() {
    _loading.value = true;
  }

  hideLoading() {
    _loading.value = false;
  }

  BehaviorSubject<String> get subjectActions => _subjectActions;
  BehaviorSubject<bool> get loading => _loading;
}

final bloc = BreedDetailsBloc();
