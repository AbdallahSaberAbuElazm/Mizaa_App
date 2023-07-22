import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mizaa/controllers/controllers.dart';
import 'package:mizaa/models/cart/cart_item_model/cart_item_model.dart';
import 'package:mizaa/models/cart/cart_model/cart_model.dart';
import 'package:mizaa/models/offers/OfferModel.dart';
import 'package:mizaa/models/offers/offer_model_adapter.dart';
import 'package:mizaa/models/offers/offer_options/offer_options_adapter.dart';
import 'package:mizaa/providers/cart_provider.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/shared_preferences.dart';

class CartController extends GetxController {
  late CartProvider cartProvider;

  late Box<CartModel> _cartBox;

  CartController(CartProvider provider) {
    _cartBox = Hive.box<CartModel>('cart_box');
    cartProvider = provider;
  }
  // CartController() : _cartBox = Hive.box<CartModel>('cart_box');
  final Rx<CartModel> _cartModel = CartModel(
    cartId: '',
    items: [],
  ).obs;

  final totalCartPrice = 0.0.obs;
  final quantityInCart = 0.obs;

  final checkedData = false.obs;

  // app bar for merchant detail screen
  late ScrollController scrollCartScreenController;
  final isScrolledCartScreen = false.obs;
  final appBarCartScreenColor = Colors.transparent.obs;
  final appBarItemContainerCartScreenColor = Colors.white.obs;
  final appBarItemCartScreenColor = ColorConstants.mainColor.obs;

  @override
  void onInit() async {
    scrollCartScreenController = ScrollController()
      ..addListener(_onScrollCartScreen);
    super.onInit();
    // _initHive();
    // _cartBox = Hive.box<CartModel>('cart_box');
    _loadCart();
    calculateTotalPrice(_cartModel.value.items);
  }

  void _onScrollCartScreen() {
    if (scrollCartScreenController.offset > 20 && !isScrolledCartScreen.value) {
      isScrolledCartScreen.value = true;
      appBarCartScreenColor.value = Colors.white;
      appBarItemContainerCartScreenColor.value = ColorConstants.mainColor;
      appBarItemCartScreenColor.value = Colors.white;
    } else if (scrollCartScreenController.offset <= 20 &&
        isScrolledCartScreen.value) {
      isScrolledCartScreen.value = false;
      appBarCartScreenColor.value = Colors.transparent;
      appBarItemContainerCartScreenColor.value = Colors.white;
      appBarItemCartScreenColor.value = ColorConstants.mainColor;
    }
  }

  Future<void> _initHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(CartModelAdapter());
    Hive.registerAdapter(CartItemModelAdapter());
    Hive.registerAdapter(OfferModelAdapter());
    Hive.registerAdapter(OfferOptionsAdapter());
  }

  Future<void> _loadCart() async {
    final cartModel = _cartBox!.get('cart_1');
    if (cartModel != null) {
      _cartModel.value = cartModel;
    }
  }

  CartModel get cartModel => _cartModel.value;

  calculateTotalPrice(List<CartItemModel> cartItems) {
    totalCartPrice.value = 0.0;
    for (CartItemModel item in cartItems) {
      totalCartPrice.value += item.totalPrice;
    }
    update();
  }

  /*
  Future<void> addToCart( CartItemModel newItem) async {
    final cartModel = _cartModel.value;

    if(cartModel.items.firstWhere(
          (item) => item.id == newItem.id,orElse:()=> CartItemModel(
       arOfferTitle: '',
        enOfferTitle: '',
        offerId: 0,
        offerOptionsId: 0,cartId: 0,pricePerItem: 0.0,count: 0,totalPrice: 0.0,id: 0,
       ).offerOptions.arOfferOptionDesc.isNotEmpty){
      final existingItem = cartModel.items.firstWhere(
              (item) => item.id == newItem.id,);

        existingItem.count += newItem.count;
        existingItem.totalPrice += (newItem.totalPrice * newItem.count);
      calculateTotalPrice(cartModel.items);
      print('///////// Exist ///////');

    } else{
      cartModel.items.add(newItem);
      print('///////// added ///////');

    }

    await _cartBox.put('cart_1', cartModel);

  }
*/

  // delete cart item from hive
  Future<void> deleteCartItem(CartItemModel item) async {
    final cartModel = _cartModel.value;

    if (cartModel != null) {
      cartModel.items.remove(item);

      _cartBox.put('cart_1', cartModel);
      _loadCart();
      calculateTotalPrice(cartModel.items);
      print('Item removed from cart successfully!');
    } else {
      print('Cart not found!');
    }
  }

  // update cart item from hive
  Future<void> updateCartItem({required CartItemModel updatedItem}) async {
    final cartModel = _cartModel.value;

    final existingItem = cartModel.items.isNotEmpty
        ? cartModel.items.firstWhere(
            (item) => item.id == updatedItem.id,
            // orElse: () =>  null as CartItemModel,
          )
        : null;

    if (existingItem != null) {
      existingItem.count = updatedItem.count;
      existingItem.totalPrice = updatedItem.totalPrice;
    }
    calculateTotalPrice(cartModel.items);
    _cartBox.put('cart_1', cartModel);
  }

  // get cart items from hive
  List<CartItemModel> getAllCartItems(String cartId) {
    final cartModel = _cartBox.get(cartId) as CartModel?;

    if (cartModel != null) {
      return cartModel.items;
    } else {
      print('Cart not found!');
      return [];
    }
  }

  ////////////////// TODO APIs for cart

  addToCartApi({required CartModel cartModel}) {
    cartProvider.addToCart(cartModel: cartModel).then((value) {
      if (SharedPreferencesClass.getToken() != null ||
          SharedPreferencesClass.getToken() != '') {
        getCartApi();
      }
    });
  }

  var isLoadingCartItems = true.obs;
  final cartItems = <CartItemModel>[].obs;
  // final offerModelCartScreen = <OfferModel>[].obs;
  getCartApi() {
    isLoadingCartItems.value = true;
    cartProvider.getAllCart().then((items) {
      cartItems.value = items..sort((a, b) => a.offerId.compareTo(b.offerId));
      calculateTotalPrice(items);
      isLoadingCartItems.value = false;
    });
  }

  // Convert function
  List<Map<String, dynamic>> convertList(List<Map<String, dynamic>> inputList) {
    List<Map<String, dynamic>> outputList = [];

    for (var item in inputList) {
      // Check if the offerId and offerOptionsId are not null
      if (item['offerId'] != null && item['offerOptionsId'] != null) {
        // Find the index of the offerId in the outputList
        int index = outputList
            .indexWhere((element) => element['offerId'] == item['offerId']);

        if (index == -1) {
          // If the offerId is not present in the outputList, create a new object
          Map<String, dynamic> newObject = {
            "offerId": item['offerId'],
            "orderDetailsDto": [
              {
                "offerOptionsId": item['offerOptionsId'],
                "coboneCount": item['count'],
                "cobonesCost": item['totalPrice']
              }
            ]
          };

          outputList.add(newObject);
        } else {
          // If the offerId is already present in the outputList, append the order details
          outputList[index]['orderDetailsDto'].add({
            "offerOptionsId": item['offerOptionsId'],
            "coboneCount": item['count'],
            "cobonesCost": item['totalPrice']
          });
        }
      }
    }

    return outputList;
  }

  getCartItemsWithoutLoading() {
    cartProvider.getAllCart().then((items) {
      cartItems.value = items;
      calculateTotalPrice(items);
    });
  }

  deleteCartItemApi({required String cartItemId}) {
    cartProvider.deleteCartItem(cartItemId).then((value) {
      if (value) {
        cartItems.removeWhere((item) => item.id == int.parse(cartItemId));
        // calculateTotalPrice(cartItems);
      }
    });
  }

  clearCartApi() {
    cartProvider.clearCart().then((value) {
      cartItems.clear();
    });
  }

  updateCartItemApi({required String cartItemId, required int newQuantity}) {
    cartProvider.updateCartItem(cartItemId, newQuantity);
    // calculateTotalPrice(cartItems);
  }

  @override
  void dispose() {
    scrollCartScreenController.dispose();
    super.dispose();
  }
}
