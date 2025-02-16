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
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
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
