import 'package:rxdart/rxdart.dart';
import 'package:spends/repository/bill-repository/bill-repository.dart';

import '../../model/bill.dart';

class BillsBloc {
  final BillRepository _repository = BillRepository();
  final BehaviorSubject<List<Bill>> _subject = BehaviorSubject<List<Bill>>();

  void getBills() async {
    var list = await _repository.getAll();
    _subject.sink.add(list);
  }

  void removeBill(Bill bill) async {
    await _repository.remove(bill);
    getBills();
  }

  BehaviorSubject<List<Bill>> get subject => _subject;
}

final bloc = BillsBloc();
