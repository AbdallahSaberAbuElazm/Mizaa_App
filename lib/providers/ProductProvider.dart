import 'package:mizaa/models/products/ProductModel.dart';
import 'package:mizaa/repositories/ProductRepository.dart';

class ProductProvider {
  final ProductRepository _productRepository;

  ProductProvider(this._productRepository);
}
