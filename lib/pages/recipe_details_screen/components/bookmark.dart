import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/dialogs.dart';
import 'dart:developer' as developer show log;
class BookmarkRecipe extends StatefulWidget {
  const BookmarkRecipe({Key? key, required this.recipeName}) : super(key: key);

  final String recipeName;

  @override
  State<BookmarkRecipe> createState() => _BookmarkRecipeState();
}

class _BookmarkRecipeState extends State<BookmarkRecipe> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future<bool> checkBookmark(String userId, String recipeName) async {
    try {
      final database = FirebaseDatabase.instance;
      final userBookmarksRef =
      database.ref().child('Users/$userId/bookmarks');

      DataSnapshot snapshot =
          (await userBookmarksRef.child(recipeName).once()).snapshot;

      // Check if the item exists in bookmarks
      return snapshot.value != null;
    } catch (error) {
      developer.log('Error checking bookmark: $error');
      return false;
    }
  }

  Future<void> addBookmark(String userId, String recipeName) async {
    try {
      final database = FirebaseDatabase.instance;
      final userBookmarksRef =
      database.ref().child('Users/$userId/bookmarks');

      await userBookmarksRef.child(recipeName).set(true);

      Utils.showToast("Added To Bookmarks");
      setState(() {});
    } catch (error) {
      developer.log('Error adding bookmark: $error');
    }
  }

  Future<void> removeBookmark(String userId, String recipeName) async {
    try {
      final database = FirebaseDatabase.instance;
      final userBookmarksRef =
      database.ref().child('Users/$userId/bookmarks');

      await userBookmarksRef.child(recipeName).remove();

      Utils.showToast("Removed from Bookmarks");
      setState(() {});
    } catch (error) {
      developer.log('Error removing bookmark: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkBookmark(userId, widget.recipeName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(strokeWidth: 0.5,));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          bool isBookmarked = snapshot.data ?? false;

          return IconButton(
            onPressed: () async {
              if (isBookmarked) {
                await removeBookmark(userId, widget.recipeName);
              } else {
                await addBookmark(userId, widget.recipeName);
              }
            },
            icon: Icon(
              shadows: [
                BoxShadow(
                    color:  Colors.grey.shade800,
                  spreadRadius: 20,
                  blurRadius: 20,
                  offset:const Offset(0,0)
                )
              ],
               CupertinoIcons.bookmark_fill,
              size: 35,
              color: isBookmarked ? CupertinoColors.systemYellow : Colors.white,
            ),
          );
        }
      },
    );
  }
}
