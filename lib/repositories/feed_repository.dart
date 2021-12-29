import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/feed_model.dart';

class FeedRepository {

  final FirebaseFirestore _firebaseFirestore;

  FeedRepository({FirebaseFirestore? firebaseFirestore}) :
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<List<FeedModel>> getAllFeed() async {
    List<FeedModel> listFeed = <FeedModel>[];

    final result = await _firebaseFirestore.collection('feed').get();
    for (var e in result.docs) {
      listFeed.add(FeedModel.fromJson(e.data(), e.id));
    }

    return listFeed;
  }
}