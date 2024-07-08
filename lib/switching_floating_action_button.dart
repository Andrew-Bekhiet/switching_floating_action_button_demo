import 'package:flutter/material.dart';

class SwitchingFloatingActionButton extends StatefulWidget {
  const SwitchingFloatingActionButton({
    super.key,
    required this.animation,
    required this.builder,
    this.child,
  });

  final Animation<double> animation;
  final Widget Function(BuildContext, int, Widget?) builder;
  final Widget? child;

  @override
  State<SwitchingFloatingActionButton> createState() =>
      _SwitchingFloatingActionButtonState();
}

class _SwitchingFloatingActionButtonState
    extends State<SwitchingFloatingActionButton> {
  static const double translationAmount = 56;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = widget.animation;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final double animationValue = animation.value;
        final double offset = animationValue - animationValue.truncate();
        final int oldIndex = animationValue.floor();
        final int newIndex = animationValue.ceil();

        return Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: 1 - offset,
              child: Transform.translate(
                offset: Offset(-offset, 0) * translationAmount,
                child: widget.builder(context, oldIndex, widget.child),
              ),
            ),
            Opacity(
              opacity: offset,
              child: Transform.translate(
                offset: Offset(1 - offset, 0) * translationAmount,
                child: widget.builder(context, newIndex, widget.child),
              ),
            ),
          ],
        );
      },
    );
  }
}
