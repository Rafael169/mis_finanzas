import 'package:flutter/material.dart';

class PieSlice {
  const PieSlice({required this.value, required this.color, required this.label});

  final double value;
  final Color color;
  final String label;
}

/// Dona simple dibujada a mano, sin dependencias externas. Con leyenda al
/// lado. Si todos los valores son cero, muestra un anillo gris.
class SimplePieChart extends StatelessWidget {
  const SimplePieChart({super.key, required this.slices, this.size = 120});

  final List<PieSlice> slices;
  final double size;

  @override
  Widget build(BuildContext context) {
    final total = slices.fold<double>(0, (sum, s) => sum + s.value);
    final visible = slices.where((s) => s.value > 0).toList();

    return Row(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _PiePainter(
              slices: visible,
              total: total,
              trackColor: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final slice in visible)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: slice.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          slice.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              if (visible.isEmpty)
                Text(
                  'Sin datos todavía',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PiePainter extends CustomPainter {
  _PiePainter({required this.slices, required this.total, required this.trackColor});

  final List<PieSlice> slices;
  final double total;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    const strokeWidth = 16.0;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    if (total <= 0) {
      paint.color = trackColor;
      canvas.drawArc(
        rect.deflate(strokeWidth / 2),
        0,
        6.28319,
        false,
        paint,
      );
      return;
    }

    var start = -1.5708; // -90 grados: empieza arriba.
    for (final slice in slices) {
      final sweep = (slice.value / total) * 6.28319;
      paint.color = slice.color;
      canvas.drawArc(
        rect.deflate(strokeWidth / 2),
        start,
        sweep,
        false,
        paint,
      );
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _PiePainter oldDelegate) {
    return oldDelegate.slices != slices || oldDelegate.total != total;
  }
}