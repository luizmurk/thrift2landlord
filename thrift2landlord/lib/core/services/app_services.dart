import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dio/dio.dart';

class AppService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final Dio dio = Dio();

  /// 🔥 **Fetch Entire Collection**
  Future<List<Map<String, dynamic>>> fetchCollection(
      String collectionPath) async {
    try {
      QuerySnapshot snapshot = await firestore.collection(collectionPath).get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw Exception("Error fetching collection: $e");
    }
  }

  /// 🔥 **Find Documents by Fields (Returns Multiple)**
  Future<List<Map<String, dynamic>>> findDocuments(
      String collectionPath, Map<String, dynamic> queryFields) async {
    try {
      Query query = firestore.collection(collectionPath);

      // Dynamically add where clauses based on provided fields
      queryFields.forEach((key, value) {
        query = query.where(key, isEqualTo: value);
      });

      QuerySnapshot snapshot = await query.get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw Exception("Error finding documents: $e");
    }
  }

  /// 🔥 **Add a Document**
  Future<void> addDocument(
      String collectionPath, Map<String, dynamic> data) async {
    try {
      await firestore.collection(collectionPath).add(data);
    } catch (e) {
      throw Exception("Error adding document: $e");
    }
  }

  /// 🔥 **Update a Document**
  Future<void> updateDocument(
      String collectionPath, String docId, Map<String, dynamic> data) async {
    try {
      await firestore.collection(collectionPath).doc(docId).update(data);
    } catch (e) {
      throw Exception("Error updating document: $e");
    }
  }

  /// 🔥 **Delete a Document**
  Future<void> deleteDocument(String collectionPath, String docId) async {
    try {
      await firestore.collection(collectionPath).doc(docId).delete();
    } catch (e) {
      throw Exception("Error deleting document: $e");
    }
  }

  /// 🔥 **Upload Image to Firebase Storage**
  // Future<String> uploadImage(String path, String fileName, List<int> fileBytes) async {
  //   try {
  //     final ref = storage.ref().child("$path/$fileName");
  //     final uploadTask = await ref.putData(fileBytes);
  //     return await uploadTask.ref.getDownloadURL();
  //   } catch (e) {
  //     throw Exception("Error uploading image: $e");
  //   }
  // }
}
