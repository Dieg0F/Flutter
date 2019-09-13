import 'package:rxdart/rxdart.dart';

class LoadingBloc {
  PublishSubject<bool> _loading = new PublishSubject<bool>();

  show() {
    _loading.sink.add(true);
  }

  hide() {
    _loading.sink.add(false);
  }

  PublishSubject<bool> get loading => _loading;
}

final loadingBloc = LoadingBloc();
