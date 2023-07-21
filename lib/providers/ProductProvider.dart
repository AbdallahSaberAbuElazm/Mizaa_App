import 'package:test_ecommerce_app/models/products/ProductModel.dart';
import 'package:test_ecommerce_app/repositories/ProductRepository.dart';

class ProductProvider {
  final ProductRepository _productRepository;

  ProductProvider(this._productRepository);
}
