import 'package:flutter/material.dart';
import '../models/parking_lot.dart';
import '../widgets/availability_badge.dart';
import '../widgets/space_grid.dart';

class LotDetailScreen extends StatelessWidget {
  final ParkingLot lot;

  const LotDetailScreen({super.key, required this.lot});

  @override
  Widget build(BuildContext context) {
    final floors = lot.floors;

    if (floors != null) {
      return DefaultTabController(
        length: floors.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(lot.name),
            centerTitle: false,
            bottom: TabBar(
              tabs: floors.map((f) => Tab(text: f.label)).toList(),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: _InfoCard(lot: lot),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: Row(
                  children: [
                    Text(
                      'Parking Spaces',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const Spacer(),
                    _Legend(),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: floors
                      .map((f) => SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SpaceGrid(spaces: f.spaces),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(lot.name),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoCard(lot: lot),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'Parking Spaces',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const Spacer(),
                _Legend(),
              ],
            ),
            const SizedBox(height: 12),
            SpaceGrid(spaces: lot.spaces),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final ParkingLot lot;
  const _InfoCard({required this.lot});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  lot.address,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _Stat(
                  label: 'Available',
                  value: '${lot.availableSpaces}',
                  color: Colors.green,
                ),
                _Stat(
                  label: 'Occupied',
                  value: '${lot.occupiedSpaces}',
                  color: Colors.red,
                ),
                _Stat(
                  label: 'Total',
                  value: '${lot.totalSpaces}',
                  color: Colors.blueGrey,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Status: '),
                AvailabilityBadge(lot: lot),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _Stat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _LegendDot(color: Colors.green[500]!, label: 'Free'),
        const SizedBox(width: 12),
        _LegendDot(color: Colors.red[400]!, label: 'Taken'),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label,
            style:
                Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
      ],
    );
  }
}
