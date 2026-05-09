import 'package:flutter/material.dart';
import '../models/parking_lot.dart';
import 'availability_badge.dart';

class LotCard extends StatelessWidget {
  final ParkingLot lot;
  final VoidCallback onTap;

  const LotCard({super.key, required this.lot, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      lot.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  AvailabilityBadge(lot: lot),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    lot.address,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _OccupancyBar(lot: lot),
              const SizedBox(height: 6),
              Text(
                '${lot.occupiedSpaces} / ${lot.totalSpaces} spaces occupied',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OccupancyBar extends StatelessWidget {
  final ParkingLot lot;
  const _OccupancyBar({required this.lot});

  @override
  Widget build(BuildContext context) {
    final rate = lot.occupancyRate;
    final color = rate >= 1.0
        ? Colors.red
        : rate > 0.8
            ? Colors.orange
            : Colors.green;

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: rate,
        minHeight: 8,
        backgroundColor: Colors.grey[200],
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
