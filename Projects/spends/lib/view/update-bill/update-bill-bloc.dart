import 'package:spends/repository/bill-repository/bill-repository.dart';

import '../../model/bill.dart';

class UpdateBillBloc {
  final BillRepository _repository = BillRepository();

  void updateBill(Bill bill) async {
    await _repository.update(bill);
  }
}

final bloc = UpdateBillBloc();
