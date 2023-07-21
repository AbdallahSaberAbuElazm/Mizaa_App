import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_ecommerce_app/models/order/order_model.dart';
import 'package:test_ecommerce_app/services/networking/ApiConstants.dart';
import 'package:test_ecommerce_app/shared/error/exception.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';
import 'package:test_ecommerce_app/models/cart/validate_order_data/order_data_model.dart';

class OrderRepository {
  Future<String> validateOrderData(
      {required OrderDataModel orderDataModel}) async {
    final response = await http.post(
      Uri.parse(ApiConstants.validateOrderData),
      body: json.encode(orderDataModel.toJson()),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SharedPreferencesClass.getToken()}",
      },
    );

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return body['orderKey'];
    } else {
      return 'Error';
    }
  }

  Future<String> makeOrder({required String orderKey}) async {
    final response = await http.post(
      Uri.parse(ApiConstants.makeOrder + orderKey),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SharedPreferencesClass.getToken()}",
      },
    );

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return body['status'];
    } else {
      return 'Error';
    }
  }

  Future<List<OrderModel>> getUserOrders() async {
    var response = await http.get(
      Uri.parse(
          '${ApiConstants.getUserOrders}${SharedPreferencesClass.getApplicationUserId()}'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SharedPreferencesClass.getToken()}",
      },
    );
    print('application id  ${SharedPreferencesClass.getApplicationUserId()}');
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => OrderModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }
}
