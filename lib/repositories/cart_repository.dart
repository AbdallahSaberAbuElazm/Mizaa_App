import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_ecommerce_app/models/cart/cart_item_model/cart_item_model.dart';
import 'package:test_ecommerce_app/models/cart/cart_model/cart_model.dart';
import 'package:test_ecommerce_app/services/networking/ApiConstants.dart';
import 'package:test_ecommerce_app/shared/error/exception.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';

class CartRepository {
  Future<void> addToCart({required CartModel cartModel}) async {
    final body = {
      "creationDate": DateTime.now().toIso8601String(),
      "userMobile": SharedPreferencesClass.getPhoneNumber(),
      "token": SharedPreferencesClass.getToken(),
      "cartDetails": cartModel.items.map((item) => item.toJson()).toList(),
    };

    print(
        'token is ${SharedPreferencesClass.getToken()} and user mobile is ${SharedPreferencesClass.getPhoneNumber()}');

    final response = await http.post(
      Uri.parse(ApiConstants.addToCart),
      body: json.encode(body),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SharedPreferencesClass.getToken()}",
      },
    );

    if (response.statusCode == 200) {
      print('Items added to cart successfully');
    } else {
      // Product addition failed, handle the error here
      print(
          'Error: ${response.statusCode} and response body is ${response.body}');
    }
  }

  // Function to update a cart item's quantity
  Future<void> updateCartItem(String cartItemId, int newQuantity) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.updateCartItem}$cartItemId/$newQuantity'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${SharedPreferencesClass.getToken()}",
        },
      );

      if (response.statusCode == 200) {
        // Cart item updated successfully, handle the response here
        print('cart item update successfully');
        // Update your app's cart or show a success message
      } else {
        // Cart item update failed, handle the error here
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions or network errors here
      print('Error: $e');
    }
  }

  // Function to delete a cart item
  Future<bool> deleteCartItem(String cartItemId) async {
    try {
      final response = await http.get(
          Uri.parse('${ApiConstants.deleteCartItem}/${cartItemId.toString()}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${SharedPreferencesClass.getToken()}',
          });
      if (response.statusCode == 200) {
        // Cart item deleted successfully, handle the response here
        print('cart item deleted successfully');
        return true;
        // Update your app's cart or show a success message
      } else {
        // Cart item deletion failed, handle the error here
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle any exceptions or network errors here
      print('Error: $e');
      return false;
    }
  }

  Future<List<CartItemModel>> getAllCart() async {
    var response = await http.get(
      Uri.parse(
          '${ApiConstants.getCartByUserMobile}${SharedPreferencesClass.getPhoneNumber()}'),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List<CartItemModel> cartItems = [];
      if (body is List && body.isNotEmpty) {
        final cartDetails = body[0]['cartDetails'];

        if (cartDetails is List) {
          cartItems = cartDetails
              .map((cartItem) => CartItemModel.fromJson(cartItem))
              .toList();
        }
      }
      return cartItems;
    } else {
      throw ServerException();
    }
  }

  Future<void> clearCart() async {
    try {
      final response = await http.get(
          Uri.parse(
              '${ApiConstants.deleteSpecificCart}${SharedPreferencesClass.getPhoneNumber()}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${SharedPreferencesClass.getToken()}',
          });
      if (response.statusCode == 200) {
        // Cart item deleted successfully, handle the response here
        print('cart cleared successfully');
        // Update your app's cart or show a success message
      } else {
        // Cart item deletion failed, handle the error here
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions or network errors here
      print('Error: $e');
    }
  }

  // // Function to get a specific cart item
  // Future<CartItemModel> getSpecificCartItem(String cartItemId) async {
  //   final response = await http
  //       .get(Uri.parse('${ApiConstants.cartSpecificCartItem}/$cartItemId'), headers: {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${SharedPreferencesClass.getToken()}',
  //   });
  //
  //   if (response.statusCode == 200) {
  //     final body = json.decode(response.body);
  //     return CartItemModel.fromJson(body['data']);
  //   } else {
  //     throw ServerException();
  //   }
  //
  // }
  //
  // Future<CartModel> getSpecificCart({required int cartId}) async {
  //   final response = await http
  //       .get(Uri.parse('${ApiConstants.cartSpecificCart}/$cartId'), headers: {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${SharedPreferencesClass.getToken()}',
  //   });
  //
  //   if (response.statusCode == 200) {
  //     final body = json.decode(response.body);
  //     return CartModel.fromJson(body['data']);
  //   } else {
  //     throw ServerException();
  //   }
  // }
}
