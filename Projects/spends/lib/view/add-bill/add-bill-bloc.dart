import 'package:spends/repository/bill-repository/bill-repository.dart';

import '../../model/bill.dart';

class AddBillBloc {
  final BillRepository _repository = BillRepository();

  void saveBill(Bill bill) async {
    await _repository.save(bill);
  }
}

final bloc = AddBillBloc();
