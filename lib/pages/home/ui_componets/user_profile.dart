import 'package:flutter/material.dart';
import 'package:foodzik/pages/home/ui_componets/shimmar_effect.dart';

class ProfileImage extends StatelessWidget {
  final Future<String> userImageFuture;
  final double size;

  const ProfileImage({required this.userImageFuture, this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: userImageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the data to load, show a loading indicator
          return Container(
            width: size,
            height: size,
            child: ShimmerEffect(width: size, height: size),
          );
        } else if (snapshot.hasError) {
          // If there's an error, show an error image
          return _buildImageWidget('assets/avatar.png');
        } else {
          // If the data is available, show the user's image
          final userImage = snapshot.data ?? '';
          if (userImage.isEmpty) {
            // If the user's image is empty, show the default avatar image
            return _buildImageWidget('assets/avatar.png');
          } else {
            // If the user's image is available, show it as the background of a circular image
            return CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(userImage),
              radius: size / 2,
            );
          }
        }
      },
    );
  }

  Widget _buildImageWidget(String imagePath) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
