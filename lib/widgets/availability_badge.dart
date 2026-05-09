import 'package:flutter/material.dart';
import '../models/parking_lot.dart';

class AvailabilityBadge extends StatelessWidget {
  final ParkingLot lot;

  const AvailabilityBadge({super.key, required this.lot});

  @override
  Widget build(BuildContext context) {
    final color = lot.availableSpaces == 0
        ? Colors.red
        : lot.occupancyRate > 0.8
            ? Colors.orange
            : Colors.green;

    final label = lot.availableSpaces == 0
        ? 'FULL'
        : '${lot.availableSpaces} free';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1.2),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }
}
