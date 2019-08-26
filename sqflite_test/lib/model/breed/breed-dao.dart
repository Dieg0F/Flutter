class BreedDao {
  String createQuery() {
    return "CREATE TABLE Breed ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "about TEXT,"
        "registered DATETIME"
        "size INTEGER"
        "weight INTEGER"
        "isActive BIT"
        ")";
  }

  String getAllBreeds() {
    
  }
}
