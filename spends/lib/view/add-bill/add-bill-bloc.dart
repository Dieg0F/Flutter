import 'package:rxdart/rxdart.dart';
import 'package:spends/repository/add-bill-repository/add-bill-repository.dart';

import '../../model/bill.dart';

class AddBillBloc {
  final BillRepository _repository = BillRepository();
  final BehaviorSubject<Bill> _subject = BehaviorSubject<Bill>();

  void saveBill(Bill bill) async {
    await _repository.save(bill);
  }

  void getAllBills() async {
    var list = await _repository.getAll();
    _subject.sink.add(list);
  }

  BehaviorSubject<Bill> get subject => _subject;
}

final bloc = AddBillBloc();
