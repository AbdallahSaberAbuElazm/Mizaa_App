import 'package:hive/hive.dart';
import 'package:mizaa/models/companies/CompanyModel.dart';

class CompanyModelAdapter extends TypeAdapter<CompanyModel> {
  @override
  final int typeId = 4; // Unique identifier for the adapter

  @override
  CompanyModel read(BinaryReader reader) {
    final map = reader.readMap();
    final json = map.cast<String, dynamic>(); // Cast to Map<String, dynamic>
    return CompanyModel.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, CompanyModel obj) {
    final jsonData = obj.toJson();
    writer.writeMap(jsonData);
  }
}
