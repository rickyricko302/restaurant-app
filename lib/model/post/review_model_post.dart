class ReviewModelPost {
  String id;
  String name;
  String review;
  ReviewModelPost({
    required this.id,
    required this.name,
    required this.review,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'review': review,
    };
  }
}
