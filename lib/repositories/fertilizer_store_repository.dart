import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/fertilizer_store_model.dart';

class FertilizerStoreRepository {

  final FirebaseFirestore _firebaseFirestore;

  FertilizerStoreRepository({FirebaseFirestore? firebaseFirestore}) :
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<List<FertilizerStoreModel>> getFertilizerStore() async {
    List<FertilizerStoreModel> listStore = <FertilizerStoreModel>[];

    final result = await _firebaseFirestore.collection('store').get();
    for (var e in result.docs) {
      listStore.add(FertilizerStoreModel.fromJson(e.data()));
    }

    return listStore;
  }

}