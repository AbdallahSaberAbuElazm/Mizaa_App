import 'package:test_ecommerce_app/models/favourite/favourite_model.dart';
import 'package:test_ecommerce_app/repositories/favourite_repository.dart';

class FavouriteProvider {
  final FavouriteRepository _favouriteRepository;

  FavouriteProvider(this._favouriteRepository);

  Future<bool> addToFavourites({required int offerId}) async {
    return await _favouriteRepository.addToFavourites(offerId: offerId);
  }

  Future<bool> deleteFromFavourites({required String favouriteKey}) async {
    return await _favouriteRepository.deleteFromFavourites(
        favouriteKey: favouriteKey);
  }

  Future<List<FavouriteModel>> getFavourites() async {
    return await _favouriteRepository.getFavourites();
  }
}
