part of '../index.dart';

class MockDataService {
  static Random random = Random();
  static final List<String> imageUrlsBucket = [
    'https://firebasestorage.googleapis.com/v0/b/na-wali-b7671.appspot.com/o/laa%2Fland1.webp?alt=media&token=5b1caea4-407e-43dd-ad02-ac2c85b21d78',
    'https://firebasestorage.googleapis.com/v0/b/na-wali-b7671.appspot.com/o/laa%2Fland2.jpg?alt=media&token=7c98b6d4-19f5-4a1f-888f-bff9fdf9798b',
    'https://firebasestorage.googleapis.com/v0/b/na-wali-b7671.appspot.com/o/laa%2Fland3.jpg?alt=media&token=96a065c5-07d0-414d-a749-62bed0c075bd',
    'https://firebasestorage.googleapis.com/v0/b/na-wali-b7671.appspot.com/o/laa%2Fland4.jpg?alt=media&token=cc41ded0-5896-445e-8968-2936111a5cdc',
    'https://firebasestorage.googleapis.com/v0/b/na-wali-b7671.appspot.com/o/laa%2Fland5.jpg?alt=media&token=8de8ddc0-8edb-4e7d-ac39-c11e94a729ce',
    'https://firebasestorage.googleapis.com/v0/b/na-wali-b7671.appspot.com/o/laa%2Fland6.jpg?alt=media&token=ec7d9c0f-e3c7-4cd1-8357-de4f9ad30e93',
    'https://firebasestorage.googleapis.com/v0/b/na-wali-b7671.appspot.com/o/laa%2Fland7.jpg?alt=media&token=7af32933-d675-4a20-9a80-cd2199d6224e',
  ];

  static final List<String> realtorImages = [
    'https://firebasestorage.googleapis.com/v0/b/na-wali-b7671.appspot.com/o/realtors%2Frealtor.jpeg?alt=media&token=9cc174d4-e52d-43a8-8071-870be45eed3e',
    'https://firebasestorage.googleapis.com/v0/b/na-wali-b7671.appspot.com/o/realtors%2Frealtor.webp?alt=media&token=616b4228-29f5-4701-a815-35df0c117a14',
    'https://firebasestorage.googleapis.com/v0/b/na-wali-b7671.appspot.com/o/realtors%2Frealtor2.jpeg?alt=media&token=383e0b57-0b4b-4a80-90eb-5700cf693188',
    'https://firebasestorage.googleapis.com/v0/b/na-wali-b7671.appspot.com/o/realtors%2Frealtor3.jpeg?alt=media&token=ed879f91-e5b4-4efa-a20c-3a90a387d693',
    'https://firebasestorage.googleapis.com/v0/b/na-wali-b7671.appspot.com/o/realtors%2Frealtor4.jpeg?alt=media&token=6b11efdb-2bcb-4be0-abc2-a4f6fce01f2c',
    'https://firebasestorage.googleapis.com/v0/b/na-wali-b7671.appspot.com/o/realtors%2Frealtor5.jpeg?alt=media&token=60e413be-9b5a-46f5-9ed8-1e09cac1e658',
    'https://firebasestorage.googleapis.com/v0/b/na-wali-b7671.appspot.com/o/realtors%2Frealtor2.jpeg?alt=media&token=383e0b57-0b4b-4a80-90eb-5700cf693188',
  ];

  static Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(
        Duration(milliseconds: 1100)); // Simulating network delay
    return [
      CategoryModel(
          id: '1', name: 'Residential', imageUrl: ImageUrls.profilePlaceholder),
      CategoryModel(
          id: '2', name: 'Commercial', imageUrl: ImageUrls.profilePlaceholder),
      CategoryModel(
          id: '3', name: 'Luxury', imageUrl: ImageUrls.profilePlaceholder),
      CategoryModel(
          id: '4', name: 'Undeveloped', imageUrl: ImageUrls.profilePlaceholder),
    ];
  }

  static Future<List<UserModel>> getRealtors() async {
    await Future.delayed(
        Duration(milliseconds: 1700)); // Simulating network delay
    return List.generate(
      10,
      (index) => UserModel(
        id: '$index',
        name: 'Realtor $index',
        email: 'realtor$index@example.com',
        phoneNumber: '123-456-7890',
        photoUrl: realtorImages[
            random.nextInt(realtorImages.length)], // ✅ Random selection
        rating: index, // Random rating between 1 and 5
        propertiesListed: index + 3,
      ),
    );
  }

  static Future<List<ListingModel>> getListings() async {
    await Future.delayed(
        Duration(milliseconds: 1500)); // Simulating network delay
    return List.generate(
        10,
        (index) => ListingModel(
              id: '$index',
              title: 'Amusement park land, old $index',
              location: LocationModel(lat: 37.7749, lng: -122.4194),
              description:
                  'This land is just 10 mins from the University of Abuja, 15 mins from Gwagwalada Teaching Hospital, and 25 mins from the airport. Enjoy a good road network, 24/7 security, and reliable electricity & water supply.\nThe area is safe, peaceful, and rapidly developing with great investment potential.\nPhysical & virtual site inspections are available for your convenience.\n🎉 Special Offer: Get a Free Deed of Assignment when you pay in full! \n C of O (Certificate of Occupancy)',
              state: 'Abuja',
              country: 'Nigeria',
              city: 'Wuse $index',
              address: '123 Main St, City $index',
              price: 50000 + (index * 1000),
              owner: null,
              ownershipType: 'Freehold',
              landStatus: 'Dry Land, Ready for Construction',
              imageUrls: List.generate(
                  7,
                  (i) =>
                      imageUrlsBucket[random.nextInt(imageUrlsBucket.length)]),
              categories: [
                CategoryModel(
                    id: '1',
                    name: 'Residential',
                    imageUrl: 'https://via.placeholder.com/150')
              ],
              tags: ['Luxury', 'Spacious', 'Modern'],
              rating: 4.5,
              reviews: [
                ReviewModel(
                    userId: 'user_$index', comment: 'Great place!', rating: 4.5)
              ],
              realtorId: 'realtor_$index',
              documents: [
                DocumentModel(
                    name: 'Property Deed', url: 'https://example.com/doc.pdf')
              ],
              isInstallmentAvailable: true,
              installmentMonths: 10,
              installmentPlan: InstallmentPlanModel(
                  monthlyPaymentDate: DateTime.now(),
                  amount: 5000,
                  timeFrame: 10),
              totalPaidAmount: 0,
              isFullyPaid: false,
              buyerId: null,
              paymentHistory: [],
            ));
  }

  static Future<List<ListingModel>> getYourListings() async {
    await Future.delayed(
        Duration(milliseconds: 1000)); // Simulating network delay
    return List.generate(
        10,
        (index) => ListingModel(
              id: '$index',
              title: 'Old Takers Land $index',
              location: LocationModel(lat: 37.7749, lng: -122.4194),
              description:
                  'This land is just 10 mins from the University of Abuja, 15 mins from Gwagwalada Teaching Hospital, and 25 mins from the airport. Enjoy a good road network, 24/7 security, and reliable electricity & water supply.\nThe area is safe, peaceful, and rapidly developing with great investment potential.\nPhysical & virtual site inspections are available for your convenience.\n🎉 Special Offer: Get a Free Deed of Assignment when you pay in full! \n C of O (Certificate of Occupancy)',
              state: 'Abuja',
              country: 'Nigeria',
              city: 'Wuse $index',
              address: '123 Main St, City $index',
              price: 50000 + (index * 1000),
              owner: 'owner_',
              ownershipType: 'Freehold',
              landStatus: 'Dry Land, Ready for Construction',
              imageUrls: List.generate(
                  7,
                  (i) =>
                      imageUrlsBucket[random.nextInt(imageUrlsBucket.length)]),
              categories: [
                CategoryModel(
                    id: '1',
                    name: 'Residential',
                    imageUrl: 'https://via.placeholder.com/150')
              ],
              tags: ['Luxury', 'Spacious', 'Modern'],
              rating: 4.5,
              reviews: [
                ReviewModel(
                    userId: 'user_$index', comment: 'Great place!', rating: 4.5)
              ],
              realtorId: 'realtor_$index',
              documents: [
                DocumentModel(
                    name: 'Property Deed', url: 'https://example.com/doc.pdf')
              ],
              isInstallmentAvailable: true,
              installmentMonths: 10,
              installmentPlan: InstallmentPlanModel(
                  monthlyPaymentDate: DateTime.now(),
                  amount: 5000,
                  timeFrame: 10),
              totalPaidAmount: 4000 * (index.isEven ? 1 : 0),
              isFullyPaid: false,
              buyerId: null,
              paymentHistory: demoPaymentHistory,
            ));
  }

  static List<PaymentModel> demoPaymentHistory = [
    PaymentModel(
      paymentId: 'TXN001',
      amount: 50000,
      date: DateTime.now().subtract(Duration(days: 30)),
      status: 'successful',
      completionStatus: '20%',
    ),
    PaymentModel(
      paymentId: 'TXN002',
      amount: 50000,
      date: DateTime.now().subtract(Duration(days: 60)),
      status: 'successful',
      completionStatus: '40%',
    ),
    PaymentModel(
      paymentId: 'TXN003',
      amount: 50000,
      date: DateTime.now().subtract(Duration(days: 90)),
      status: 'pending',
      completionStatus: '40%',
    ),
  ];

  static Future<ListingModel> getListingById(String id) async {
    await Future.delayed(
        Duration(milliseconds: 1600)); // Simulating network delay
    return getListings()
        .then((listings) => listings.firstWhere((listing) => listing.id == id));
  }
}
