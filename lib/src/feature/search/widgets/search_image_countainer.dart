import 'package:app/src/common/models/photo.dart';
import 'package:app/src/feature/search/widgets/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchImageContainer extends StatelessWidget {
  const SearchImageContainer({
    super.key,
    required this.photo,
  });

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImagePreviewer(
              photo: photo,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          photo.src.medium,
          fit: BoxFit.cover,
          loadingBuilder: (
            BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) return child;
            return SizedBox(
              height: 200,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade200,
                highlightColor: Colors.grey.shade400,
                child: Container(
                  color: Colors.white,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 120,
              width: 200,
              alignment: Alignment.center,
            );
          },
        ),
      ),
    );
  }
}
