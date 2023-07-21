import 'package:test_ecommerce_app/models/cart/cart_item_model/cart_item_model.dart';
import 'package:test_ecommerce_app/models/cart/cart_model/cart_model.dart';
import 'package:test_ecommerce_app/repositories/cart_repository.dart';

class CartProvider {
  CartRepository _cartRepository;
  CartProvider(this._cartRepository);

  Future<void> addToCart({required CartModel cartModel}) async {
    await _cartRepository.addToCart(cartModel: cartModel);
  }

  Future<void> updateCartItem(String cartItemId, int newQuantity) async {
    await _cartRepository.updateCartItem(cartItemId, newQuantity);
  }

  Future<bool> deleteCartItem(String cartItemId) async {
    return await _cartRepository.deleteCartItem(cartItemId);
  }

  Future<List<CartItemModel>> getAllCart() async {
    return await _cartRepository.getAllCart();
  }

  Future<void> clearCart() async {
    return await _cartRepository.clearCart();
  }

  // Future<CartItemModel> getSpecificCartItem(String cartItemId) async {
  //   return await _cartRepository.getSpecificCartItem(cartItemId);
  // }
  //
  // Future<CartModel> getSpecificCart({required int cartId}) async {
  //   return await _cartRepository.getSpecificCart(cartId: cartId);
  // }
}
