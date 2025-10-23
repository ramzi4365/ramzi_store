import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ramzi_store/data/model/cartModel.dart';

import '../../../../controller/cartController.dart';
import '../../../../core/constant/routes.dart';

class CheckoutSectionCart extends StatefulWidget {
  final Widget buildPromoCodeSection;
  final Widget buildOrderSummary;
  final Widget buildCheckoutButton;
  final double total;

  const CheckoutSectionCart({
    super.key,
    required this.buildPromoCodeSection,
    required this.buildOrderSummary,
    required this.buildCheckoutButton,
    required this.total,
  });

  @override
  State<CheckoutSectionCart> createState() => _CheckoutSectionState();
}

class _CheckoutSectionState extends State<CheckoutSectionCart>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;
  bool _isExpanded = true;

  // Swipe detection variables
  double _dragStartY = 0;
  double _dragDistance = 0;
  final double _swipeThreshold = 50.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Start expanded
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
    HapticFeedback.lightImpact();
  }

  void _handleVerticalDragStart(DragStartDetails details) {
    _dragStartY = details.globalPosition.dy;
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    _dragDistance = details.globalPosition.dy - _dragStartY;
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    // Swipe down to collapse (when expanded)
    if (_dragDistance > _swipeThreshold && _isExpanded) {
      _toggleExpanded();
    }
    // Swipe up to expand (when collapsed)
    else if (_dragDistance < -_swipeThreshold && !_isExpanded) {
      _toggleExpanded();
    }

    // Reset drag distance
    _dragDistance = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: _handleVerticalDragStart,
      onVerticalDragUpdate: _handleVerticalDragUpdate,
      onVerticalDragEnd: _handleVerticalDragEnd,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Collapsible Header
              GestureDetector(
                onTap: _toggleExpanded,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Column(
                    children: [
                      // Handle bar with visual feedback
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: _isExpanded ? 40 : 60,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: _isExpanded ? Colors.grey[300] : Theme.of(context).primaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),

                      // Header Content
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left side - Summary info
                          Expanded(
                            child: Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).primaryColor.withOpacity(_isExpanded ? 0.1 : 0.15),
                                        Theme.of(context).primaryColor.withOpacity(_isExpanded ? 0.05 : 0.1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    _isExpanded ? Icons.shopping_cart_checkout : Icons.shopping_cart,
                                    color: Theme.of(context).primaryColor,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AnimatedDefaultTextStyle(
                                        duration: const Duration(milliseconds: 300),
                                        style: TextStyle(
                                          fontSize: _isExpanded ? 16 : 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                        child: Text(
                                          _isExpanded ? 'Order Summary' : 'Checkout',
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      GetBuilder<CartController>(
                                        builder: (controller) {

                                          return AnimatedDefaultTextStyle(
                                            duration: const Duration(milliseconds: 300),
                                            style: TextStyle(
                                              fontSize: _isExpanded ? 14 : 16,
                                              color: Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            child: Text(
                                              'Total: \$${widget.total.toStringAsFixed(2)}',
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Right side - Expand/Collapse icon with animation
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _isExpanded ? Colors.grey[100] : Theme.of(context).primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: RotationTransition(
                              turns: _rotateAnimation,
                              child: Icon(
                                Icons.expand_more,
                                color: _isExpanded ? Colors.grey[700] : Theme.of(context).primaryColor,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Swipe hint (shows when collapsed)
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: _isExpanded ? 0 : 1,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: _isExpanded ? 0 : 20,
                          margin: EdgeInsets.only(top: _isExpanded ? 0 : 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.swipe_up,
                                size: 14,
                                color: Colors.grey[500],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Swipe up to expand',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[500],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Expandable Content
              SizeTransition(
                sizeFactor: _expandAnimation,
                child: FadeTransition(
                  opacity: _expandAnimation,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Column(
                      children: [
                        // Divider
                        Container(
                          height: 1,
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.grey[200]!,
                                Colors.grey[200]!,
                                Colors.transparent,
                              ],
                              stops: const [0, 0.2, 0.8, 1],
                            ),
                          ),
                        ),

                        // Promo Code Section - FIXED: Use widget.
                        widget.buildPromoCodeSection,
                        const SizedBox(height: 24),

                        // Order Summary - FIXED: Use widget.
                        widget.buildOrderSummary,
                        const SizedBox(height: 24),

                        // Checkout Button - FIXED: Use widget.
                        widget.buildCheckoutButton,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}