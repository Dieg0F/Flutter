import 'package:sqflite_test/model/breed/breed-dao.dart';
import 'package:sqflite_test/model/breed/breed.dart';
import 'package:sqflite_test/service/database/database.dart';

class BreedRepository {
  BreedDao breedDao;

  BreedRepository() {
    this.breedDao = new BreedDao();
  }

  Future<List<Breed>> getAllBreeds() async {
    var list = await DBProvider.db.select(breedDao.getAllBreeds());

    return list.map<Breed>((c) => Breed.fromMap(c)).toList();
  }

  Future<Breed> getBreedById(Breed breed) async {
    var list = await DBProvider.db.select(breedDao.getBreedById(breed));

    return list.map<Breed>((c) => Breed.fromMap(c)).toList();
  }

  Future<Breed> insertBreed(Breed newBreed) async {
    newBreed.id = await DBProvider.db.insert(breedDao.insertBreed(newBreed));

    return newBreed;
  }
}
