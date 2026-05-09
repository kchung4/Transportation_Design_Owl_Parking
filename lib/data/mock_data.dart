import '../models/parking_floor.dart';
import '../models/parking_lot.dart';
import '../models/parking_space.dart';

List<ParkingSpace> _makeSpaces(int total, List<int> occupiedIndices) {
  return List.generate(total, (i) {
    final label = i < 26
        ? String.fromCharCode(65 + i)
        : '${String.fromCharCode(65 + (i ~/ 26) - 1)}${String.fromCharCode(65 + (i % 26))}';
    return ParkingSpace(
      id: '$label${i + 1}',
      isOccupied: occupiedIndices.contains(i),
    );
  });
}

List<ParkingSpace> _makeFloorSpaces(int floor, int total, List<int> occupiedIndices) {
  return List.generate(total, (i) {
    final rowIndex = i ~/ 5;
    final col = (i % 5) + 1;
    final rowLabel = rowIndex < 26
        ? String.fromCharCode(65 + rowIndex)
        : '${String.fromCharCode(65 + (rowIndex ~/ 26) - 1)}${String.fromCharCode(65 + (rowIndex % 26))}';
    return ParkingSpace(
      id: 'F$floor-$rowLabel$col',
      isOccupied: occupiedIndices.contains(i),
    );
  });
}

final List<ParkingLot> mockParkingLots = [
  ParkingLot(
    id: '1',
    name: 'Central Parking 1',
    address: '101 Main St',
    spaces: _makeSpaces(150, [0, 1, 2, 4, 5, 7, 9, 10, 13, 16, 18, 20, 21, 24]),
  ),
  ParkingLot(
    id: '2',
    name: 'Central Parking 2',
    address: '103 Main St',
    spaces: _makeSpaces(150, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 13, 15, 17, 18, 19]),
  ),
  ParkingLot(
    id: '3',
    name: 'Lot Y',
    address: '220 North Ave',
    spaces: _makeSpaces(50, [2, 5, 8, 11]),
  ),
  ParkingLot(
    id: '4',
    name: 'Visitor Parking',
    address: '7 Station Blvd',
    spaces: _makeSpaces(50, List.generate(50, (i) => i)),
  ),
  ParkingLot(
    id: '5',
    name: 'East Parking Lot 1',
    address: '500 East Campus Dr',
    spaces: _makeSpaces(150, [
      0, 1, 3, 5, 6, 8, 10, 12, 14, 15, 17, 19, 22, 25, 27, 29, 31, 33, 35, 38, 40, 43
    ]),
  ),
  ParkingLot(
    id: '6',
    name: 'East Parking Lot 2',
    address: '502 East Campus Dr',
    spaces: _makeSpaces(150, List.generate(150, (i) => i)..removeWhere((i) => i % 7 == 0)),
  ),
  ParkingLot(
    id: '7',
    name: 'East Residence Lot',
    address: '10 East Residence Rd',
    spaces: _makeSpaces(50, [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20]),
  ),
  ParkingLot(
    id: '8',
    name: 'East Economy',
    address: '15 East Economy Blvd',
    spaces: _makeSpaces(150, List.generate(150, (i) => i)..removeWhere((i) => i % 3 == 0)),
  ),
  ParkingLot(
    id: '9',
    name: 'Lot D',
    address: '200 Campus Loop',
    spaces: _makeSpaces(50, [1, 3, 5, 7, 9, 11, 13]),
  ),
  ParkingLot(
    id: '10',
    name: 'Lot E',
    address: '210 Campus Loop',
    spaces: _makeSpaces(50, [0, 2, 4, 6, 8, 10, 14, 20]),
  ),
  ParkingLot(
    id: '11',
    name: 'West Parking Lot',
    address: '300 West Campus Dr',
    spaces: _makeSpaces(150, [0, 1, 5, 6, 10, 11, 15, 16, 20, 21, 25, 26, 30, 31]),
  ),
  ParkingLot(
    id: '12',
    name: 'Lot H',
    address: '310 West Campus Dr',
    spaces: _makeSpaces(50, [0, 1, 2, 3, 4, 5]),
  ),
  ParkingLot(
    id: '13',
    name: 'Lot F',
    address: '320 West Campus Dr',
    spaces: _makeSpaces(50, [0, 3, 6, 9, 12, 15, 18, 21]),
  ),
  ParkingLot(
    id: '14',
    name: 'Lot G',
    address: '330 West Campus Dr',
    spaces: _makeSpaces(50, [1, 4, 7, 10, 13, 16, 19]),
  ),
  ParkingLot(
    id: '15',
    name: 'West Residence Lot',
    address: '10 West Residence Rd',
    spaces: _makeSpaces(150, [0, 1, 2, 7, 8, 9, 14, 15, 16, 21, 22, 23]),
  ),
  ParkingLot(
    id: '16',
    name: 'Shuttle Lot',
    address: '1 Shuttle Dr',
    spaces: _makeSpaces(150, List.generate(150, (i) => i)..removeWhere((i) => i % 5 == 0)),
  ),
  ParkingLot(
    id: '17',
    name: 'West Parking Deck',
    address: '400 West Campus Dr',
    floors: [
      ParkingFloor(
        label: 'Floor 1',
        spaces: _makeFloorSpaces(1, 200, List.generate(200, (i) => i)..removeWhere((i) => i % 4 == 0)),
      ),
      ParkingFloor(
        label: 'Floor 2',
        spaces: _makeFloorSpaces(2, 200, List.generate(200, (i) => i)..removeWhere((i) => i % 3 == 0)),
      ),
      ParkingFloor(
        label: 'Floor 3',
        spaces: _makeFloorSpaces(3, 200, List.generate(200, (i) => i)..removeWhere((i) => i % 2 == 0)),
      ),
      ParkingFloor(
        label: 'Floor 4',
        spaces: _makeFloorSpaces(4, 200, List.generate(200, (i) => i)..removeWhere((i) => i % 5 != 0)),
      ),
    ],
  ),
];
