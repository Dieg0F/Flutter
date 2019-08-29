import 'package:sqflite_test/model/breed/breed.dart';

class BreedDao {
  String createBreedTable() {
    return "CREATE TABLE Breed (" +
        "id INTEGER PRIMARY KEY AUTOINCREMENT," +
        "name TEXT," +
        "about TEXT," +
        "registered DATETIME," +
        "size INTEGER," +
        "weight INTEGER," +
        "picture TEXT," +
        "isActive BIT" +
        ")";
  }

  String getAllBreeds() {
    return "SELECT * FROM Breed";
  }

  String getBreedById(Breed breed) {
    return "SELECT * FROM Breed WHERE id = '${breed.id}'";
  }

  String insertBreed(Breed newBreed) {
    return "INSERT Into Breed (name, about, registered, size, weight, picture, isActive)" +
        " VALUES ('${newBreed.name}', '${newBreed.about}', '${newBreed.registered}', '${newBreed.size}', '${newBreed.weight}', '${newBreed.picture}','${newBreed.isActive}')";
  }

  String deleteBreed(int breedId) {
    return "DELETE FROM Breed WHERE id = '$breedId'";
  }
}
