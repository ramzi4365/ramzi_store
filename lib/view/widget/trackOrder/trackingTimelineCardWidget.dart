// widgets/track_order/tracking_timeline_card_widget.dart
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TrackingTimelineCardWidget extends StatelessWidget {
  final List<Map<String, dynamic>> trackingSteps;

  const TrackingTimelineCardWidget({
    super.key,
    required this.trackingSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.timeline_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Tracking History',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...trackingSteps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final isLast = index == trackingSteps.length - 1;
            final isCompleted = step['isCompleted'] as bool;

            return TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              isFirst: index == 0,
              isLast: isLast,
              indicatorStyle: IndicatorStyle(
                width: 40,
                height: 40,
                indicator: Container(
                  decoration: BoxDecoration(
                    gradient: isCompleted
                        ? LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.8),
                      ],
                    )
                        : null,
                    color: !isCompleted ? Colors.grey[300] : null,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    )
                        : Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              afterLineStyle: LineStyle(
                color: isCompleted
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300]!,
                thickness: 2,
              ),
              beforeLineStyle: LineStyle(
                color: index > 0 &&
                    trackingSteps[index - 1]['isCompleted'] as bool
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300]!,
                thickness: 2,
              ),
              endChild: Container(
                constraints: const BoxConstraints(minHeight: 80),
                padding: const EdgeInsets.only(left: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      step['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isCompleted ? Colors.black : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      step['subtitle'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        step['time'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          color: isCompleted
                              ? Theme.of(context).primaryColor
                              : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}