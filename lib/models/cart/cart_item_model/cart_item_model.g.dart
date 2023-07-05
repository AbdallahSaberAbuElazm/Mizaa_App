// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartItemModelAdapter extends TypeAdapter<CartItemModel> {
  @override
  final int typeId = 1;

  @override
  CartItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemModel(
      arOfferTitle: fields[0] as String,
      enOfferTitle: fields[1] as String,
      offerId: fields[2] as int,
      offerKey: fields[9] as String,
      offerOptionsId: fields[3] as int,
      cartId: fields[4] as int,
      pricePerItem: fields[5] as double,
      count: fields[6] as RxInt,
      totalPrice: fields[7] as double,
      mainImage: fields[10] as String,
      companyLogo: fields[11] as String,
      companyName: fields[12] as String,
      enCompanyName: fields[13] as String,
      id: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.arOfferTitle)
      ..writeByte(1)
      ..write(obj.enOfferTitle)
      ..writeByte(2)
      ..write(obj.offerId)
      ..writeByte(3)
      ..write(obj.offerOptionsId)
      ..writeByte(4)
      ..write(obj.cartId)
      ..writeByte(5)
      ..write(obj.pricePerItem)
      ..writeByte(6)
      ..write(obj.count)
      ..writeByte(7)
      ..write(obj.totalPrice)
      ..writeByte(8)
      ..write(obj.id)
      ..writeByte(9)
      ..write(obj.offerKey)
      ..writeByte(10)
      ..write(obj.mainImage)
      ..writeByte(11)
      ..write(obj.companyLogo)
      ..writeByte(12)
      ..write(obj.companyName)
      ..writeByte(13)
      ..write(obj.enCompanyName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
