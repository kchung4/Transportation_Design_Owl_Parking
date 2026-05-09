import 'package:flutter/material.dart';
import '../models/parking_space.dart';

class SpaceGrid extends StatelessWidget {
  final List<ParkingSpace> spaces;

  const SpaceGrid({super.key, required this.spaces});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.1,
      ),
      itemCount: spaces.length,
      itemBuilder: (context, index) {
        final space = spaces[index];
        return _SpaceTile(space: space);
      },
    );
  }
}

class _SpaceTile extends StatelessWidget {
  final ParkingSpace space;
  const _SpaceTile({required this.space});

  @override
  Widget build(BuildContext context) {
    final color = space.isOccupied ? Colors.red[400]! : Colors.green[500]!;
    final bgColor = space.isOccupied ? Colors.red[50]! : Colors.green[50]!;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            space.isOccupied ? Icons.directions_car : Icons.local_parking,
            color: color,
            size: 18,
          ),
          const SizedBox(height: 2),
          Text(
            space.id,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
