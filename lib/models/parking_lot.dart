import 'parking_floor.dart';
import 'parking_space.dart';

class ParkingLot {
  final String id;
  final String name;
  final String address;
  final List<ParkingSpace> spaces;
  final List<ParkingFloor>? floors;

  const ParkingLot({
    required this.id,
    required this.name,
    required this.address,
    this.spaces = const [],
    this.floors,
  });

  int get totalSpaces => floors != null
      ? floors!.fold(0, (sum, f) => sum + f.totalSpaces)
      : spaces.length;
  int get availableSpaces => floors != null
      ? floors!.fold(0, (sum, f) => sum + f.availableSpaces)
      : spaces.where((s) => !s.isOccupied).length;
  int get occupiedSpaces => floors != null
      ? floors!.fold(0, (sum, f) => sum + f.occupiedSpaces)
      : spaces.where((s) => s.isOccupied).length;
  double get occupancyRate => totalSpaces == 0 ? 0 : occupiedSpaces / totalSpaces;
  bool get hasAvailability => availableSpaces > 0;
}
