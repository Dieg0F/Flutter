import 'package:rxdart/subjects.dart';
import 'package:sqflite_test/model/breed/breed.dart';
import 'package:sqflite_test/repository/breed-repository.dart';

class BreedsBloc {
  final BreedRepository _repository = BreedRepository();
  final BehaviorSubject<List<Breed>> _subject = BehaviorSubject<List<Breed>>();

  getAllBreeds() async {
    print("BreedsBloc: getAllBreeds");
    List<Breed> response = await _repository.getAllBreeds();
    _subject.sink.add(response);
  }  

  dispose() {
    print("BreedsBloc: dispose");
    _subject.close();
  }

  BehaviorSubject<List<Breed>> get subject => _subject;
}

final bloc = BreedsBloc();
