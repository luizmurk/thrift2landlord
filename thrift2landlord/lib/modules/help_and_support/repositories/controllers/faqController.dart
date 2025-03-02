part of './../../index.dart';

class FAQController extends GetxController {
  var faqList = <FAQ>[].obs;
  var faqId = "my_account".obs;
  var loading = true.obs;
  var questions = [].obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch FAQ data from Firebase when the controller is initialized
    // fetchFAQ();
    fetchQuestions();
  }

  Future<void> fetchFAQ() async {
    loading.value = false;
    faqList.value = await FAQService().getFAQ();
    loading.value = true;
  }

  void fetchQuestions() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('iyawali-faq').get();
      if (querySnapshot.docs.isNotEmpty) {
        final List<String> loadedQuestions = querySnapshot.docs.map((doc) {
         
          return doc['question'] as String;
        }).toList();
        questions.value = loadedQuestions;
      } else {
        throw ("No documents found in the collection.");
      }
    } catch (e) {
      throw ("Error fetching questions: $e");
    }
  }

  FAQ filterFAQById() {
    if (faqId.isEmpty || faqList.isEmpty) {
      // You might want to return a default FAQ or handle this case accordingly
      return FAQ(name: "", id: "", content: [
        FAQContent(
            sectionHeader: "",
            sectionHeaderContent: [HeaderContent(title: "", description: "")])
      ]);
    }

    List<FAQ> matchingFAQ =
        faqList.where((faq) => faq.id == faqId.value).toList();

    if (matchingFAQ.isNotEmpty) {
      return matchingFAQ[0];
    } else {
      throw ("No matching FAQ found for faqId: $faqId");
      // You might want to return a default FAQ or handle this case accordingly
      return FAQ(name: "", id: "", content: [
        FAQContent(
            sectionHeader: "",
            sectionHeaderContent: [HeaderContent(title: "", description: "")])
      ]);
    }
  }
}
