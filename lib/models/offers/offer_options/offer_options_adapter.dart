import 'package:hive/hive.dart';
import 'package:mizaa/models/offers/offer_options/OfferOptions.dart';

class OfferOptionsAdapter extends TypeAdapter<OfferOptions> {
  @override
  final typeId = 3; // Provide a unique typeId for the adapter

  @override
  OfferOptions read(BinaryReader reader) {
    final map = reader.readMap();
    final json = map.cast<String, dynamic>(); // Cast to Map<String, dynamic>
    return OfferOptions.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, OfferOptions obj) {
    // Implement the serialization logic
    writer.writeMap(obj.toJson());
  }
}
