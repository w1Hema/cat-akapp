import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final bool isDark;
  const AnimatedBackground({super.key, required this.isDark});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 10 seconds duration for a full cycle of movement
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: widget.isDark
              ? SpiderWebPainter(_controller.value, Theme.of(context).primaryColor)
              : CubesPainter(_controller.value, Theme.of(context).primaryColor),
        );
      },
    );
  }
}

// ─── SPIDER WEB PAINTER (Dark Mode) ───
class SpiderWebPainter extends CustomPainter {
  final double progress;
  final Color color;
  SpiderWebPainter(this.progress, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;

    final paint = Paint()
      ..color = color.withOpacity(0.15)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()..color = color.withOpacity(0.5);

    // Fixed seed to keep nodes stable across repaints
    final random = math.Random(42); 
    final nodes = <Offset>[];

    // Generate nodes moving over time
    int numNodes = (size.width * size.height / 15000).clamp(20, 80).toInt();

    for (int i = 0; i < numNodes; i++) {
      double startX = random.nextDouble() * size.width;
      double startY = random.nextDouble() * size.height;
      // Random speed and direction
      double speedX = (random.nextDouble() - 0.5) * 150;
      double speedY = (random.nextDouble() - 0.5) * 150;

      // Calculate current position with wrap-around
      double x = (startX + speedX * progress) % size.width;
      double y = (startY + speedY * progress) % size.height;
      if (x < 0) x += size.width;
      if (y < 0) y += size.height;

      nodes.add(Offset(x, y));
    }

    // Draw lines between close nodes
    double connectDistance = 110.0;
    for (int i = 0; i < nodes.length; i++) {
      canvas.drawCircle(nodes[i], 2.5, dotPaint);
      for (int j = i + 1; j < nodes.length; j++) {
        double dist = (nodes[i] - nodes[j]).distance;
        if (dist < connectDistance) {
          paint.color = color.withOpacity((1 - dist / connectDistance) * 0.3);
          canvas.drawLine(nodes[i], nodes[j], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(SpiderWebPainter oldDelegate) => oldDelegate.progress != progress;
}

// ─── CUBES PAINTER (Light Mode) ───
class CubesPainter extends CustomPainter {
  final double progress;
  final Color color;
  CubesPainter(this.progress, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;

    final paint = Paint()
      ..color = color.withOpacity(0.04)
      ..style = PaintingStyle.fill;
      
    final strokePaint = Paint()
      ..color = color.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final random = math.Random(123);
    int numCubes = (size.width * size.height / 25000).clamp(10, 30).toInt();

    for (int i = 0; i < numCubes; i++) {
      double startX = random.nextDouble() * size.width;
      double startY = random.nextDouble() * size.height;
      double sizeBase = 25 + random.nextDouble() * 45;
      // Ascending speed
      double speedY = 50 + random.nextDouble() * 100;
      double rotationSpeed = (random.nextDouble() - 0.5) * 4 * math.pi;

      // Float upwards
      double y = (startY - speedY * progress * 2) % size.height;
      if (y < -sizeBase) y += size.height + sizeBase;

      // Slight horizontal drift
      double x = startX + math.sin(progress * 4 * math.pi + i) * 30;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(progress * rotationSpeed);
      
      // Draw a pseudo-3D cube
      Path path = Path();
      path.moveTo(-sizeBase/2, -sizeBase/2);
      path.lineTo(sizeBase/2, -sizeBase/2);
      path.lineTo(sizeBase/2, sizeBase/2);
      path.lineTo(-sizeBase/2, sizeBase/2);
      path.close();

      canvas.drawPath(path, paint);
      canvas.drawPath(path, strokePaint);
      
      // Inner cube lines for 3D effect
      double innerSize = sizeBase / 2.5;
      canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: innerSize, height: innerSize), strokePaint);
      
      canvas.drawLine(Offset(-sizeBase/2, -sizeBase/2), Offset(-innerSize/2, -innerSize/2), strokePaint);
      canvas.drawLine(Offset(sizeBase/2, -sizeBase/2), Offset(innerSize/2, -innerSize/2), strokePaint);
      canvas.drawLine(Offset(sizeBase/2, sizeBase/2), Offset(innerSize/2, innerSize/2), strokePaint);
      canvas.drawLine(Offset(-sizeBase/2, sizeBase/2), Offset(-innerSize/2, innerSize/2), strokePaint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CubesPainter oldDelegate) => oldDelegate.progress != progress;
}
