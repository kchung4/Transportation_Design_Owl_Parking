import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/parking_lot.dart';
import '../widgets/lot_card.dart';
import 'lot_detail_screen.dart';

enum AvailabilityFilter { all, available, full }

class LotsListScreen extends StatefulWidget {
  const LotsListScreen({super.key});

  @override
  State<LotsListScreen> createState() => _LotsListScreenState();
}

class _LotsListScreenState extends State<LotsListScreen> {
  String _query = '';
  AvailabilityFilter _filter = AvailabilityFilter.all;

  static int _directionPriority(String name) {
    final n = name.toLowerCase();
    if (n.contains('north')) return 0;
    if (n.contains('east'))  return 1;
    if (n.contains('south')) return 2;
    if (n.contains('west'))  return 3;
    return 4;
  }

  List<ParkingLot> get _filtered {
    final lots = mockParkingLots.where((lot) {
      final matchesQuery =
          lot.name.toLowerCase().contains(_query.toLowerCase()) ||
              lot.address.toLowerCase().contains(_query.toLowerCase());
      final matchesFilter = switch (_filter) {
        AvailabilityFilter.all => true,
        AvailabilityFilter.available => lot.hasAvailability,
        AvailabilityFilter.full => !lot.hasAvailability,
      };
      return matchesQuery && matchesFilter;
    }).toList();

    lots.sort((a, b) {
      final pd = _directionPriority(a.name).compareTo(_directionPriority(b.name));
      if (pd != 0) return pd;
      return a.name.compareTo(b.name);
    });

    return lots;
  }

  @override
  Widget build(BuildContext context) {
    final lots = _filtered;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Availability', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          _SearchBar(onChanged: (q) => setState(() => _query = q)),
          _FilterChips(
            current: _filter,
            onChanged: (f) => setState(() => _filter = f),
          ),
          Expanded(
            child: lots.isEmpty
                ? const _EmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: lots.length,
                    itemBuilder: (context, index) {
                      final lot = lots[index];
                      return LotCard(
                        lot: lot,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LotDetailScreen(lot: lot),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const _SearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search by name or address...',
          prefixIcon: const Icon(Icons.search, size: 20),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  final AvailabilityFilter current;
  final ValueChanged<AvailabilityFilter> onChanged;

  const _FilterChips({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          _Chip(
            label: 'All',
            selected: current == AvailabilityFilter.all,
            onTap: () => onChanged(AvailabilityFilter.all),
          ),
          const SizedBox(width: 8),
          _Chip(
            label: 'Available',
            selected: current == AvailabilityFilter.available,
            color: Colors.green,
            onTap: () => onChanged(AvailabilityFilter.available),
          ),
          const SizedBox(width: 8),
          _Chip(
            label: 'Full',
            selected: current == AvailabilityFilter.full,
            color: Colors.red,
            onTap: () => onChanged(AvailabilityFilter.full),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color? color;
  final VoidCallback onTap;

  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = color ?? Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? activeColor.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? activeColor : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? activeColor : Colors.grey[600],
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_parking, size: 56, color: Colors.grey[300]),
          const SizedBox(height: 12),
          Text(
            'No lots match your search',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
