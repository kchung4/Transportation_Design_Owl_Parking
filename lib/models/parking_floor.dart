import 'parking_space.dart';

class ParkingFloor {
  final String label;
  final List<ParkingSpace> spaces;

  const ParkingFloor({required this.label, required this.spaces});

  int get totalSpaces => spaces.length;
  int get availableSpaces => spaces.where((s) => !s.isOccupied).length;
  int get occupiedSpaces => spaces.where((s) => s.isOccupied).length;
}
