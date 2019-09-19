import 'package:localstorage/localstorage.dart';
import 'package:uuid/uuid.dart';

import '../../model/bill.dart';

const _localStorageName = "bill_storage";
const _billList = "bill_list";

class BillRepository {
  save(Bill bill) async {
    var storage = LocalStorage(_localStorageName);
    bill.id = Uuid().v1();

    BillResults billResults = new BillResults();
    billResults.bills = await getAll();
    billResults.bills.add(bill);

    storage.setItem(_billList, billResults.toJson());
  }

  Future<List<Bill>> getAll() async {
    var storage = LocalStorage(_localStorageName);
    await storage.ready;
    var jsonBill = await storage.getItem(_billList);

    if (jsonBill == null) {
      return new List<Bill>();
    }

    BillResults billsResults = BillResults.fromJson(jsonBill);
    return billsResults.bills;
  }

  update(Bill bill) async {
    var storage = LocalStorage(_localStorageName);

    BillResults billResults = new BillResults();
    billResults.bills = await getAll();

    for (var i = 0; i < billResults.bills.length; i++) {
      if (billResults.bills[i].id == bill.id) {
        billResults.bills[i] = bill;
      }
    }

    storage.setItem(_billList, billResults.toJson());
  }

  remove(Bill bill) async {
    var storage = LocalStorage(_localStorageName);

    BillResults billResults = new BillResults();
    billResults.bills = await getAll();

    billResults.bills.removeWhere((item) => item.id == bill.id);
    print(billResults.bills.toList());

    storage.setItem(_billList, billResults.toJson());
  }
}
