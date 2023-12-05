import '../../domain/entities/local.dart';

class LocalModel extends Local {
  LocalModel({
    required int id,
    required String title,
    required String image,
    // required String price,
    required String description,
    required String category,
    required int rating,
  }) : super(
          id: id,
          title: title,
          image: image,
          // price: price,
          description: description,
          category: category,
          rating: rating,
        );

  factory LocalModel.fromJson(Map<String, dynamic> json) {
    return LocalModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      // price: json['price'],
      description: json['description'],
      category: json['category'],
      rating: json['rating']['count'],
    );
  }

  factory LocalModel.fromEntity(Local local) {
    return LocalModel(
      id: local.id,
      title: local.title,
      image: local.image,
      // price: local.price,
      description: local.description,
      category: local.category,
      rating: local.rating,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      // 'price': price,
      'description': description,
      'category': category,
      'rating': rating,
    };
  }
}
