import 'package:app/src/common/models/photo.dart';
import 'package:app/src/common/utils/build_context_x.dart';
import 'package:app/src/feature/search/widgets/image_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    super.key,
    required this.photo,
  });

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () => context.push(ImagePreviewer(photo: photo)),
        child: SizedBox(
          width: context.screenWidth,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: CachedNetworkImage(
              imageUrl: photo.src.original,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (
                BuildContext context,
                String _,
                DownloadProgress? loadingProgress,
              ) {
                if (loadingProgress == null) return const SizedBox();
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
              errorWidget: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  width: 200,
                  color: Colors.lightBlue,
                  alignment: Alignment.center,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
