part of '../index.dart';

class RealtorCard extends StatelessWidget {
  final String profileImage;
  final String name;
  final double rating;
  final int propertiesListed;

  const RealtorCard({
    required this.profileImage,
    required this.name,
    required this.rating,
    required this.propertiesListed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: AppSizes.primaryPadding),
      padding: EdgeInsets.all(AppSizes.primaryPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: AppSizes.realtorImageWidth,
            height: AppSizes.realtorImageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
              image: DecorationImage(
                image: NetworkImage(profileImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: AppSizes.primaryGapWidth),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppSizes.secondaryGapHeight),
              Row(
                children: [
                  Icon(Icons.star,
                      color: AppColors.primary, size: AppSizes.mediumIcon),
                  SizedBox(width: AppSizes.secondaryGapWidth),
                  Text('$rating', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              SizedBox(height: AppSizes.secondaryGapHeight),
              Text(
                '$propertiesListed Properties',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
