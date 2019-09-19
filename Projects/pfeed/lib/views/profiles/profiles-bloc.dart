import 'package:pfeed/models/profile.dart';
import 'package:pfeed/views/profiles/profiles-repository.dart';
import 'package:rxdart/rxdart.dart';

class ProfilesBloc {
  final ProfilesRepository _repository = ProfilesRepository();
  final BehaviorSubject<ProfileResponse> _subject =
      BehaviorSubject<ProfileResponse>();

  getProfiles() async {
    ProfileResponse profileResponse = await _repository.getProfiles();
    _subject.sink.add(profileResponse);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ProfileResponse> get subject => _subject;
}

final profilesBloc = ProfilesBloc();
