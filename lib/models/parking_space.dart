class ParkingSpace {
  final String id;
  final bool isOccupied;

  const ParkingSpace({required this.id, required this.isOccupied});

  ParkingSpace copyWith({bool? isOccupied}) =>
      ParkingSpace(id: id, isOccupied: isOccupied ?? this.isOccupied);
}
