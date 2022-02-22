// The default chart tween animation duration.
const Duration kDuration = const Duration(milliseconds: 300);
// The default angle the chart is oriented at.
const double kStartAngle = -90.0;

enum CircularChartType {
  Pie,
  Radial,
}

/// Determines how the ends of a chart's segments should be drawn.
enum SegmentEdgeStyle {
  /// Segments begin and end with a flat edge.
  flat,

  /// Segments begin and end with a semi-circle.
  round,
}
