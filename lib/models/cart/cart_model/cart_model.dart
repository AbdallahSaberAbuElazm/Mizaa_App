import 'package:hive/hive.dart';
import 'package:mizaa/models/cart/cart_item_model/cart_item_model.dart';

part 'cart_model.g.dart'; // Generated by Hive

@HiveType(typeId: 0)
class CartModel extends HiveObject {
  @HiveField(0)
  String cartId;

  // @HiveField(1)
  //  double price;
  //
  // @HiveField(2)
  //  double totalPrice;

  @HiveField(3)
  List<CartItemModel> items;

  CartModel({required this.cartId, required this.items});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final cartId = json['cartId'] as String;
    final itemsData = json['items'] as List<dynamic>;
    final List<CartItemModel> items = itemsData
        .map<CartItemModel>((itemData) => CartItemModel.fromJson(itemData))
        .toList();

    return CartModel(
      cartId: json['cartId'] as String,
      items: items,
    );
  }
}
