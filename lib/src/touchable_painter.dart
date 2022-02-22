import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:flutter_circular_chart_two/src/circular_chart.dart';
import 'package:flutter_circular_chart_two/src/stack.dart';
import 'package:touchable/touchable.dart';

import 'consts.dart';

class TouchableCircularChartPainter extends CustomPainter {
  TouchableCircularChartPainter(
    this.animation,
    this.labelPainter,
    this.context,
    this.onSelectSegment,
  ) : super(repaint: animation);

  final Animation<CircularChart> animation;
  final TextPainter labelPainter;
  final BuildContext context;
  final Function(String id) onSelectSegment;
  @override
  void paint(Canvas canvas, Size size) {
    _paintLabel(canvas, size, labelPainter);
    _paintChart(canvas, size, animation.value, context, onSelectSegment);
  }

  @override
  bool shouldRepaint(TouchableCircularChartPainter old) => false;
}

class CircularChartPainter extends CustomPainter {
  CircularChartPainter(this.chart, this.labelPainter, this.context, this.onSelectSegment);

  final CircularChart chart;
  final TextPainter labelPainter;
  final BuildContext context;
  final Function(String id) onSelectSegment;
  @override
  void paint(Canvas canvas, Size size) {
    _paintLabel(canvas, size, labelPainter);
    _paintChart(
      canvas,
      size,
      chart,
      context,
      this.onSelectSegment,
    );
  }

  @override
  bool shouldRepaint(CircularChartPainter old) => false;
}

const double _kRadiansPerDegree = Math.pi / 180;

void _paintLabel(Canvas canvas, Size size, TextPainter labelPainter) {
  if (labelPainter != null) {
    labelPainter.paint(
      canvas,
      Offset(
        size.width / 2 - labelPainter.width / 2,
        size.height / 2 - labelPainter.height / 2,
      ),
    );
  }
}

void _paintChart(
  Canvas canvas,
  Size size,
  CircularChart chart,
  BuildContext context,
  Function(String id) onSelectSegment,
) {
  final Paint segmentPaint = Paint()
    ..style = chart.chartType == CircularChartType.Radial ? PaintingStyle.stroke : PaintingStyle.fill
    ..strokeCap = chart.edgeStyle == SegmentEdgeStyle.round ? StrokeCap.round : StrokeCap.butt;

  var myCanvas = TouchyCanvas(context, canvas);

  for (final CircularChartStack stack in chart.stacks) {
    for (final segment in stack.segments) {
      segmentPaint.color = segment.color;
      segmentPaint.strokeWidth = stack.width;

      myCanvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: stack.radius,
        ),
        stack.startAngle * _kRadiansPerDegree,
        segment.sweepAngle * _kRadiansPerDegree,
        chart.chartType == CircularChartType.Pie,
        segmentPaint,
        onTapDown: (_) {
          onSelectSegment(segment.id);
        },
      );
    }
  }
}
