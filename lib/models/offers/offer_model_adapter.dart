import 'package:hive/hive.dart';
import 'package:mizaa/models/offers/OfferModel.dart';

class OfferModelAdapter extends TypeAdapter<OfferModel> {
  @override
  final typeId = 2; // Provide a unique typeId for the adapter

  @override
  OfferModel read(BinaryReader reader) {
    final map = reader.readMap();
    final json = map.cast<String, dynamic>(); // Cast to Map<String, dynamic>
    return OfferModel.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, OfferModel obj) {
    // Implement the serialization logic
    writer.writeMap(obj.toJson());
  }
}
