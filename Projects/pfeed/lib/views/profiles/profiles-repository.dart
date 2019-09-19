import 'package:pfeed/models/profile.dart';
import 'package:pfeed/services/database/database.dart';

class ProfilesRepository {
  Database _db = Database();

  Future<ProfileResponse> getProfiles() {
    return _db.getProfiles();
  }
}
