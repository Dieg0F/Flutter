import 'package:localstorage/localstorage.dart';
import 'package:uuid/uuid.dart';

import '../../model/bill.dart';

const _localStorageName = "bill_storage";

class BillRepository {
  save(Bill bill) async {
    var storage = LocalStorage(_localStorageName);
    bill.id = Uuid().toString();
    await storage.setItem("bill_0", bill.toJson());
  }

  Future<Bill> getAll() async {
    var storage = LocalStorage(_localStorageName);
    var jsonBill = await storage.getItem("bill_0");

    return Bill.fromJson(jsonBill);
  }
}
