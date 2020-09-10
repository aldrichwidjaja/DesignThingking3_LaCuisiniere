import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> updateFavorites(String uid, String recipeId) {
  DocumentReference favoritesReference =
  Firestore.instance.collection("users").document(uid);


  return favoritesReference.get().then((datasnapshot) {
    if (datasnapshot.exists) {
      if (!datasnapshot.data['likes'].contains(recipeId)) {
        favoritesReference.updateData({
          'likes': FieldValue.arrayUnion([recipeId])
        });
        // Delete the recipe ID from 'favorites':
      } else {
        favoritesReference.updateData({
          'likes': FieldValue.arrayRemove([recipeId])
        });
      }
      return true;
    }
    else {
      favoritesReference.setData({
        'likes': [recipeId]
      });
      return true;
    }
  }
  );
}


