part of './../../index.dart';

class FAQService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<FAQ>> getFAQ() async {
    // Fetch FAQ data from the Firestore collection
    QuerySnapshot querySnapshot = await _firestore.collection('faqs').get();

    // Convert the query snapshot into a list of FAQ objects
    return querySnapshot.docs.map((doc) {
      return FAQ.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
