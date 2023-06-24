import 'package:app/src/common/models/photo.dart';
import 'package:app/src/common/resources/assets.dart';
import 'package:app/src/common/utils/build_context_x.dart';
import 'package:app/src/feature/favorites/viewmodel/favorites_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ImagePreviewer extends StatefulWidget {
  const ImagePreviewer({
    super.key,
    required this.photo,
  });

  final Photo photo;

  @override
  State<ImagePreviewer> createState() => _ImagePreviewerState();
}

class _ImagePreviewerState extends State<ImagePreviewer> {
  Future<void> downloadImage() async {
    try {
      await GallerySaver.saveImage(
        widget.photo.src.original,
        toDcim: true,
        albumName: 'Wallpaper-verse',
      );

      context.showSnackBar(message: 'Wallaper downloaded');
    } catch (e) {
      context.showSnackBar(message: e.toString());
    }
  }

  Future<void> saveToFav() async {
    FavoritesViewModel favoritesViewModel = context.read();
    favoritesViewModel.addToFavorite(photo: widget.photo);
  }

  Future<void> removeFromFav() async {
    FavoritesViewModel favoritesViewModel = context.read();
    favoritesViewModel.removeFromFav(photo: widget.photo);
  }

  @override
  Widget build(BuildContext context) {
    FavoritesViewModel favoritesViewModel = context.watch();
    bool isInFav = favoritesViewModel.isInFavorite(photo: widget.photo);
    return Scaffold(
      appBar: AppBar(title: Text(widget.photo.photographer)),
      body: ListView(
        children: [
          Container(
            width: context.screenWidth,
            height:
                context.screenWidth * widget.photo.height / widget.photo.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: NetworkImage(widget.photo.src.original),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(widget.photo.photographer),
                  subtitle: Text(widget.photo.alt),
                ),
              ),
              IconButton(
                onPressed: downloadImage,
                icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.download_rounded,
                      size: 20,
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: isInFav ? removeFromFav : saveToFav,
                icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      isInFav ? AppSvg.bookmarkFill : AppSvg.bookmark,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.onPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ],
      ),
    );
  }
}
