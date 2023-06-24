import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  final String title;
  final String imageUrl;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 5,
          left: 5,
          top: 10,
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 120,
                  width: 200,
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
                      height: 120,
                      width: 200,
                      alignment: Alignment.center,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
