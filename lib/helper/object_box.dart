import 'package:objectbox_example/models/user_model.dart';
import 'package:objectbox_example/objectbox.g.dart';

class ObjectBox {
  late final Store _store;
  late final Box<UserModel> _userBox;

  ObjectBox._init(this._store) {
    _userBox = Box<UserModel>(_store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();

    if (Sync.isAvailable()) {
      final synClient = Sync.client(
        store,
        "ws//0.0.0.0:9999",
        SyncCredentials.none(),
      );
      synClient.start();
    }

    return ObjectBox._init(store);
  }

  UserModel? getUser(int id) => _userBox.get(id);

  Stream<List<UserModel>> getUsers() => _userBox
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());

  int insertUser(UserModel user) => _userBox.put(user);

  bool deleteUser(int id) => _userBox.remove(id);
}
