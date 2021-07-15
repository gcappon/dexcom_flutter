import 'package:moor/moor.dart';
import 'database.dart';

part 'dexcomAccountsDao.g.dart';

@UseDao(tables: [DexcomAccounts])
class DexcomAccountsDao extends DatabaseAccessor<MyDatabase>
    with _$DexcomAccountsDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  DexcomAccountsDao(MyDatabase db) : super(db);

  Stream<DexcomAccount> watchDexcomAccount() {
    return select(dexcomAccounts).watchSingle();
  } // watchDexcomAccount

  Stream<DexcomAccount> watchDexcomAccountByID(String id) {
    final result = select(dexcomAccounts)..where((t) => t.id.equals(id));
    return (result).watchSingle();
  } // watchDexcomAccount

  Future<DexcomAccount> getDexcomAccount() {
    return select(dexcomAccounts).getSingle();
  } // watchDexcomAccount

  Future<int> insertDexcomAccount(DexcomAccount dexcomAccount) {
    return into(dexcomAccounts).insert(dexcomAccount);
  } // insertDexcomAccount

  Future updateDexcomAccount(DexcomAccount dexcomAccount) {
    return update(dexcomAccounts).replace(dexcomAccount);
  } // updateDexcomAccount

  Future deleteDexcomAccountByID(String? id) {
    return (delete(dexcomAccounts)..where((t) => (t.id.equals(id)))).go();
  } // deleteDexcomAccount

} // DexcomAccountsDao
