import 'package:thrift2landlord/core/models/data/listings/installment_plan_model.dart';
import 'package:thrift2landlord/core/models/data/listings/location_model.dart';

import 'category_model.dart';
import 'document_model.dart';
import 'payment_model.dart';
import 'review_model.dart';

// Listing Model
class ListingModel {
  final String id;
  final String title;
  final String? description;
  final LocationModel location;
  final String state;
  final String country;
  final String city;
  final String address;
  final double price;
  final String? owner;
  final String? ownershipType;
  final String? landStatus;
  final List<String> imageUrls;
  final List<CategoryModel> categories;
  final List<String> tags;
  final double rating;
  final List<ReviewModel> reviews;
  final String realtorId;
  final List<DocumentModel> documents;
  final bool isInstallmentAvailable;
  final int installmentMonths;
  final InstallmentPlanModel? installmentPlan;
  final double totalPaidAmount;
  final bool isFullyPaid;
  final String? buyerId;
  final List<PaymentModel> paymentHistory;

  ListingModel({
    required this.id,
    required this.title,
    this.description,
    required this.location,
    required this.state,
    required this.country,
    required this.city,
    required this.address,
    required this.price,
    required this.owner,
    this.ownershipType,
    this.landStatus,
    required this.imageUrls,
    required this.categories,
    required this.tags,
    required this.rating,
    required this.reviews,
    required this.realtorId,
    required this.documents,
    required this.isInstallmentAvailable,
    required this.installmentMonths,
    required this.installmentPlan,
    required this.totalPaidAmount,
    required this.isFullyPaid,
    this.buyerId,
    required this.paymentHistory,
  });

  factory ListingModel.fromMap(Map<String, dynamic> map, String id) {
    return ListingModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      location: LocationModel.fromJson(map['location']),
      state: map['state'] ?? '',
      country: map['country'] ?? '',
      city: map['city'] ?? '',
      address: map['address'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      owner: map['owner'],
      ownershipType: map['ownershipType'] ?? '',
      landStatus: map['landStatus'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      categories: (map['categories'] as List?)
              ?.map((e) => CategoryModel.fromMap(e, e['id']))
              .toList() ??
          [],
      tags: List<String>.from(map['tags'] ?? []),
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviews: (map['reviews'] as List?)
              ?.map((e) => ReviewModel.fromMap(e))
              .toList() ??
          [],
      realtorId: map['realtorId'] ?? '',
      documents: (map['documents'] as List?)
              ?.map((e) => DocumentModel.fromMap(e))
              .toList() ??
          [],
      isInstallmentAvailable: map['isInstallmentAvailable'] ?? false,
      installmentMonths: map['installmentMonths'] ?? 10,
      installmentPlan: InstallmentPlanModel.fromMap(map['installmentPlan']),
      totalPaidAmount: (map['totalPaidAmount'] ?? 0.0).toDouble(),
      isFullyPaid: map['isFullyPaid'] ?? false,
      buyerId: map['buyerId'],
      paymentHistory: (map['paymentHistory'] as List?)
              ?.map((e) => PaymentModel.fromMap(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'location': location.toJson(),
      'state': state,
      'country': country,
      'city': city,
      'address': address,
      'price': price,
      'owner': owner,
      'ownershipType': ownershipType,
      'landStatus': landStatus,
      'imageUrls': imageUrls,
      'categories': categories
          .map((e) => {'id': e.id, 'name': e.name, 'imageUrl': e.imageUrl})
          .toList(),
      'tags': tags,
      'rating': rating,
      'reviews': reviews
          .map((e) =>
              {'userId': e.userId, 'comment': e.comment, 'rating': e.rating})
          .toList(),
      'realtorId': realtorId,
      'documents':
          documents.map((e) => {'name': e.name, 'url': e.url}).toList(),
      'isInstallmentAvailable': isInstallmentAvailable,
      'installmentMonths': installmentMonths,
      'installmentPlan': installmentPlan!.toMap(),
      'totalPaidAmount': totalPaidAmount,
      'isFullyPaid': isFullyPaid,
      'buyerId': buyerId,
      'paymentHistory': paymentHistory
          .map((e) => {
                'id': e.paymentId,
                'amount': e.amount,
                'date': e.date.toIso8601String(),
                'method': e.status,
              })
          .toList(),
    };
  }
}
