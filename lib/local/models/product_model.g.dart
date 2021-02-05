// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    price: (json['price'] as num)?.toDouble(),
    imageUrl: json['imageUrl'] as String,
    is_fav: json['is_fav'] as bool,
    user_id: json['user_id'] as String,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'is_fav': instance.is_fav,
      'user_id': instance.user_id,
    };
