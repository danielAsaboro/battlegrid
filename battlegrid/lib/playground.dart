import 'package:battlegrid/features/game/domain/entities/location.dart';
import 'package:collection/collection.dart';

void main() {
  final deepEquality = DeepCollectionEquality.unordered();

  final List<Location> locations1 = [
    Location(2, 3),
    Location(4, 3),

    Location(5, 3),
  ];
  final List<Location> locations2 = [
    Location(5, 3),
    Location(2, 3),
    Location(4, 3),
  ];

  print(deepEquality.equals(locations1, locations2));
}
