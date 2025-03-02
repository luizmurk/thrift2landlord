part of '../../index.dart';

class PropertySkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: 8),
                Container(
                  width: 150,
                  height: 12,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
