import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ProgressStepsWidget extends StatelessWidget {
  final int currentStep;

  const ProgressStepsWidget({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildStepItem(0, 'Address', Icons.location_on_outlined, currentStep,context),
          _buildStepConnector(0, currentStep,context),
          _buildStepItem(1, 'Payment', Icons.payment_outlined, currentStep,context),
          _buildStepConnector(1, currentStep,context),
          _buildStepItem(2, 'Review', Icons.rate_review_outlined, currentStep,context),
        ],
      ),
    );
  }

  Widget _buildStepItem(int index, String label, IconData icon, int currentStep,context) {
    final isActive = index <= currentStep;
    final isCompleted = index < currentStep;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: isActive
                  ? LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.8),
                ],
              )
                  : null,
              color: !isActive ? Colors.grey[300] : null,
              shape: BoxShape.circle,
              boxShadow: isActive
                  ? [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                   blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ]
                  : null,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 24,
              )
                  : Icon(
                icon,
                color: isActive ? Colors.white : Colors.grey[600],
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              color: isActive ? Theme.of(context).primaryColor : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildStepConnector(int index, int currentStep,context) {
    final isActive = index < currentStep;

    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.5),
            ],
          )
              : null,
          color: !isActive ? Colors.grey[300] : null,
        ),
      ),
    );
  }
}