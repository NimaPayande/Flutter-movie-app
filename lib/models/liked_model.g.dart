// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liked_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LikedModelAdapter extends TypeAdapter<LikedModel> {
  @override
  final int typeId = 0;

  @override
  LikedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LikedModel(
      isLiked: fields[0] as bool,
      title: fields[1] as String,
      genres: (fields[2] as List).cast<int>(),
      voteAverage: fields[3] as double,
      posterPath: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LikedModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.isLiked)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.genres)
      ..writeByte(3)
      ..write(obj.voteAverage)
      ..writeByte(4)
      ..write(obj.posterPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LikedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
