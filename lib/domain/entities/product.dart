import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends Equatable {
  @HiveField(0)
  final int id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final double price;
  
  @HiveField(3)
  final String description;
  
  @HiveField(4)
  final String category;
  
  @HiveField(5)
  final String image;
  
  @HiveField(6)
  final double rating;
  
  @HiveField(7)
  final int ratingCount;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.ratingCount,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        category,
        image,
        rating,
        ratingCount,
      ];
}
