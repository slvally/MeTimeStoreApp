import 'package:flutter/material.dart';

class chartDataDraw {
  late double value;
  late String time;
  chartDataDraw(this.value, this.time);
}

class Chart extends StatefulWidget {
  final List<chartDataDraw> scores;
  Chart(this.scores);
  @override
  State<StatefulWidget> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late double _min, _max;
  late List<double> _Y;
  late List<String> _X;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var min = double.maxFinite;
    var max = -double.maxFinite;
    widget.scores.forEach((element) {
      min = min > element.value ? element.value : min;
      max = max < element.value ? element.value : max;
    });
    if (min == max && max != 0.0) min = 0.0;
    setState(() {
      _min = min;
      _max = max;
      _Y = widget.scores.map((e) => e.value).toList();
      _X = widget.scores.map((e) => e.time).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        child: Container(),
        painter: ChartPainter(_X, _Y, _min, _max),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<String> x;
  final List<double> y;
  final double min, max;
  static double border = 10.0;
  ChartPainter(this.x, this.y, this.min, this.max);

  final fillPaint = Paint()
    ..strokeWidth = 1.0
    ..style = PaintingStyle.fill
    ..color = Colors.white;

  final strokePaint = Paint()
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke
    ..color = Colors.black;

  final labelStyle = TextStyle(color: Colors.black54, fontSize: 16);

  @override
  void paint(Canvas canvas, Size size) {
    final clipRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(clipRect);
    canvas.drawPaint(Paint()..color = Colors.white);

    final drawableHeight = size.height - 2.0 * border;
    final drawableWidth = size.width - 2.0 * border;
    final hd = drawableHeight / 3.0;
    final wd = drawableWidth / this.x.length.toDouble();
    final height = hd * 2.0;
    final width = drawableWidth;

    if (height <= 0 || width <= 0) return;
    // if (max - min > 1.0e-6) return;

    final hr = height / (max - min);

    final left = border;
    final top = border;
    final c = Offset(left + wd / 2.0, top + height / 2.0);
    // _drawOutline(canvas, c, wd, height);

    final points = _computePoint(c, wd, height, hr);
    final path = _computePath(points);
    final labels = _computeLabels();
    canvas.drawPath(path, strokePaint);
    _drawCircle(canvas, points);
    _drawLabel(canvas, labels, wd, points, top);
    final c2 = Offset(c.dx, drawableHeight - border);
    _drawXLabel(canvas, c2, wd);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawXLabel(Canvas canvas, Offset c, double width) {
    x.forEach((e) {
      _drawText(canvas, c, e, labelStyle, width);
      c += Offset(width, 0);
    });
  }

  void _drawLabel(Canvas canvas, List<String> labels, double width,
      List<Offset> points, double top) {
    int i = 0;
    labels.forEach((e) {
      final dp = points[i];
      final dy = (dp.dy - 15.0) < top ? 15.0 : -15.0;
      final ly = dp + Offset(0, dy);
      _drawText(canvas, ly, e, labelStyle, width);
      i++;
    });
  }

  void _drawCircle(Canvas canvas, List<Offset> points) {
    points.forEach((e) {
      canvas.drawCircle(e, 5.0, fillPaint);
      canvas.drawCircle(e, 5.0, strokePaint);
    });
  }

  void _drawOutline(Canvas canvas, Offset c, double width, double height) {
    y.forEach((e) {
      final rect = Rect.fromCenter(center: c, width: width, height: height);
      canvas.drawRect(rect, strokePaint);

      c += Offset(width, 0);
    });
  }

  TextPainter measureText(
      String s, double maxWidth, TextStyle style, TextAlign align) {
    final span = TextSpan(text: s, style: style);
    final tp = TextPainter(
        text: span, textAlign: align, textDirection: TextDirection.ltr);
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp;
  }

  void _drawText(
      Canvas canvas, Offset c, String text, TextStyle style, double maxWidth) {
    final tp = measureText(text, maxWidth, style, TextAlign.center);
    final offset = c + Offset(-tp.width / 2.0, -tp.height / 2.0);
    tp.paint(canvas, offset);
  }

  List<Offset> _computePoint(Offset c, double width, double height, double hr) {
    List<Offset> points = [];
    y.forEach((e) {
      final hr2 = e == 0 ? 1.0 : hr;
      final yy = height - (e - min) * hr2;
      final dp = Offset(c.dx, c.dy - height / 2.0 + yy);
      points.add(dp);
      c += Offset(width, 0);
    });

    return points;
  }

  Path _computePath(List<Offset> points) {
    final path = Path();
    int i = 0;
    points.forEach((e) {
      if (i == 0) {
        path.moveTo(e.dx, e.dy);
        i = 1;
      } else {
        path.lineTo(e.dx, e.dy);
      }
    });

    return path;
  }

  List<String> _computeLabels() => y.map((e) => e.toStringAsFixed(0)).toList();
}
