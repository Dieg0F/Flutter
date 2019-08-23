import 'package:flutter/services.dart' show rootBundle;
import 'package:pfeed/models/profile.dart';

class Database {
  Future<ProfileResponse> getProfiles() async {
    var dbPath = "assets/data/profiles.json";
    var data = await rootBundle.loadString(dbPath);

    return ProfileResponse.fromJson(data);
  }
}
