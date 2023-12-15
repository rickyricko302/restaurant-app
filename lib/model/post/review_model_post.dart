class ReviewModelPost {
  String id;
  String name;
  String review;
  ReviewModelPost({
    required this.id,
    required this.name,
    required this.review,
  });

  Map<String, dynamic> toJson() {
    return <String, String>{
      'id': id,
      'name': name,
      'review': review,
    };
  }
}
