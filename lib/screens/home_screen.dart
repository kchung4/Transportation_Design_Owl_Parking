import 'package:flutter/material.dart';

enum _Severity { critical, warning, info }

class _Alert {
  final String title;
  final String message;
  final String time;
  final _Severity severity;

  const _Alert({
    required this.title,
    required this.message,
    required this.time,
    required this.severity,
  });
}

const _mockAlerts = [
  _Alert(
    title: 'Road Closure — Main St',
    message: 'Main St closed between 1st Ave and 3rd Ave. Use alternate routes.',
    time: 'Updated 10 min ago',
    severity: _Severity.critical,
  ),
  _Alert(
    title: 'Heavy Traffic — East Campus',
    message: 'Congestion near East Parking Lot 1 & 2. Expect 10–15 min delays.',
    time: 'Updated 5 min ago',
    severity: _Severity.warning,
  ),
  _Alert(
    title: 'Special Event Tonight',
    message: 'West lots may fill by 7:00 PM. Shuttle Lot is available with free shuttle service.',
    time: 'Updated 30 min ago',
    severity: _Severity.warning,
  ),
  _Alert(
    title: 'Shuttle Running Every 20 Min',
    message: 'Shuttle Lot to East Campus shuttle operating until 11:00 PM.',
    time: 'Updated 1 hr ago',
    severity: _Severity.info,
  ),
  _Alert(
    title: 'West Parking Deck — Floor 3',
    message: 'Elevator temporarily out of service on Floor 3. Stairs and ramp available.',
    time: 'Updated 2 hr ago',
    severity: _Severity.info,
  ),
];

class HomeScreen extends StatelessWidget {
  final VoidCallback? onNavigateToParking;
  const HomeScreen({super.key, this.onNavigateToParking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/Kennesaw_State_Owls_logo.svg.png',
              height: 32,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.school, color: Color(0xFFFFFF00), size: 28),
            ),
            const SizedBox(width: 10),
            const Text('Owl Parking', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onNavigateToParking,
            child: _HeroCard(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Color(0xFFFFFF00), size: 20),
                const SizedBox(width: 8),
                Text(
                  'Traffic Alerts',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemCount: _mockAlerts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) => _AlertCard(alert: _mockAlerts[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/Kennesaw_State_Owls_logo.svg.png',
            height: 52,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.school, size: 44, color: Colors.black),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Find Parking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '17 lots available',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withValues(alpha: 0.65),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  final _Alert alert;
  const _AlertCard({required this.alert});

  @override
  Widget build(BuildContext context) {
    final (accent, icon) = switch (alert.severity) {
      _Severity.critical => (Colors.red[400]!, Icons.error_rounded),
      _Severity.warning  => (Colors.orange[400]!, Icons.warning_amber_rounded),
      _Severity.info     => (const Color(0xFFFFFF00), Icons.info_outline_rounded),
    };

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: accent, width: 4)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  alert.message,
                  style: TextStyle(color: Colors.grey[400], fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 6),
                Text(
                  alert.time,
                  style: TextStyle(color: Colors.grey[600], fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
