import 'package:flutter/material.dart';
import 'package:flutter_circular_chart_two/flutter_circular_chart_two.dart';
import 'dart:math' as Math;

import 'color_palette.dart';



class RandomizedRadialChartExample extends StatefulWidget {
  @override
  _RandomizedRadialChartExampleState createState() => _RandomizedRadialChartExampleState();
}

class _RandomizedRadialChartExampleState extends State<RandomizedRadialChartExample> {
  final GlobalKey<AnimatedCircularChartState> _chartKey = GlobalKey<AnimatedCircularChartState>();
  final _chartSize = const Size(300.0, 300.0);
  final Math.Random random = Math.Random();
  List<CircularStackEntry>? data;

  @override
  void initState() {
    super.initState();
    data = _generateRandomData();
  }

  double value = 50.0;

  void _randomize() {
    setState(() {
      data = _generateRandomData();
      _chartKey.currentState?.updateData(data!);
    });
  }

  List<CircularStackEntry> _generateRandomData() {
    int stackCount = random.nextInt(10);
    List<CircularStackEntry> data = List.generate(stackCount, (i) {
      int segCount = random.nextInt(10);
      List<CircularSegmentEntry> segments = List.generate(segCount, (j) {
        Color randomColor = ColorPalette.primary.random(random);
        return CircularSegmentEntry(random.nextDouble(), randomColor);
      });
      return CircularStackEntry(segments);
    });

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Randomized radial data'),
      ),
      body: Center(
        child: AnimatedCircularChart(
          key: _chartKey,
          size: _chartSize,
          initialChartData: data!,
          chartType: CircularChartType.Radial,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _randomize,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
