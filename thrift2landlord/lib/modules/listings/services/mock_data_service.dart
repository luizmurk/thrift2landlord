part of '../index.dart';

class MockDataService {
  static Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(
        Duration(milliseconds: 500)); // Simulating network delay
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
        Duration(milliseconds: 500)); // Simulating network delay
    return List.generate(
        10,
        (index) => UserModel(
            id: '$index',
            name: 'Realtor $index',
            email: 'realtor$index@example.com',
            phoneNumber: '123-456-7890',
            photoUrl: ImageUrls.profilePlaceholder,
            rating: index,
            propertiesListed: index + 3));
  }

  static Future<List<ListingModel>> getListings() async {
    await Future.delayed(
        Duration(milliseconds: 500)); // Simulating network delay
    return List.generate(
        10,
        (index) => ListingModel(
              id: '$index',
              title: 'Beautiful House in City $index',
              location: {'lat': 37.7749, 'lng': -122.4194},
              state: 'State $index',
              country: 'Country $index',
              city: 'City $index',
              address: '123 Main St, City $index',
              price: 50000 + (index * 1000),
              owner: 'owner_$index',
              imageUrls: List.generate(7, (i) => ImageUrls.profilePlaceholder),
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
              installmentPlan:
                  List.generate(10, (i) => {'month': i + 1, 'amount': 5000}),
              totalPaidAmount: 0,
              isFullyPaid: false,
              buyerId: null,
              paymentHistory: [],
            ));
  }

  static Future<ListingModel> getListingById(String id) async {
    await Future.delayed(
        Duration(milliseconds: 500)); // Simulating network delay
    return getListings()
        .then((listings) => listings.firstWhere((listing) => listing.id == id));
  }
}
