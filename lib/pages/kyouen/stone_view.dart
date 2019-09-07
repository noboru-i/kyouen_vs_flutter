import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';

@immutable
class StoneView extends StatelessWidget {
  const StoneView({
    @required this.state,
    @required this.onTap,
  });

  final StoneState state;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (state == StoneState.none) {
      return InkWell(
        child: const _StoneBackgroundView(),
        onTap: onTap,
      );
    }

    final bool isBlack = state == StoneState.black;
    return ClipOval(
      child: Material(
        color: isBlack ? Colors.black87 : Colors.white, // button color
        child: InkWell(
          splashColor:
              isBlack ? Colors.white60 : Colors.black45, // inkwell color
          onTap: onTap,
        ),
      ),
    );
  }
}

@immutable
class _StoneBackgroundView extends StatelessWidget {
  const _StoneBackgroundView();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _StoneBackgroundViewPaint(),
    );
  }
}

class _StoneBackgroundViewPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black45
      ..strokeWidth = 2;
    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
