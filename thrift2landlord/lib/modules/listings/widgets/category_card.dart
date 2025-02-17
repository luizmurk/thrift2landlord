part of '../index.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String name;

  const CategoryCard({
    Key? key,
    required this.imageUrl,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Stack(
        children: [
          Container(
            width: AppSizes.categoryCardWidth,
            height: AppSizes.categoryCardHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Positioned(
            bottom: AppSizes.ph10,
            left: 8,
            child: Container(
              color: Colors.black54,
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.secondaryGapWidth,
                  vertical: AppSizes.secondaryGapHeight),
              child: Text(
                name,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
