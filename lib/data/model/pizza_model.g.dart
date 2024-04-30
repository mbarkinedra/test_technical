
part of 'pizza_model.dart';


class PizzaAdapter extends TypeAdapter<Pizza> {
  @override
  final int typeId = 5;

  @override
  Pizza read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pizza(
      id: fields[0] as int,
      name: fields[1] as String,
      price: fields[2] as double,
      description: fields[3] as String,
      img: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Pizza obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.img);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PizzaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
