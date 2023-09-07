import 'package:flutter_photography_app/models/User.dart';

class Post {
  final User? user;
  final String location;
  final String dateAgo;
  final List<String> photos;
  final List<String>? relatedPhotos;

  Post({
    this.user,
    required this.location,
    required this.dateAgo,
    required this.photos,
    this.relatedPhotos,
  });
}
