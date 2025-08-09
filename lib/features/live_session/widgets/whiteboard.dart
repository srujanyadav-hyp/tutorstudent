import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui show PointMode;
import '../services/live_session_service.dart';

class Whiteboard extends ConsumerStatefulWidget {
  final String sessionId;
  final String? initialData;
  final bool isEditable;

  const Whiteboard({
    Key? key,
    required this.sessionId,
    this.initialData,
    required this.isEditable,
  }) : super(key: key);

  @override
  ConsumerState<Whiteboard> createState() => _WhiteboardState();
}

class _WhiteboardState extends ConsumerState<Whiteboard> {
  late List<Offset?> _points;
  double _strokeWidth = 2.0;
  Color _strokeColor = Colors.black;
  bool _isErasing = false;

  @override
  void initState() {
    super.initState();
    _points = [];
    if (widget.initialData != null) {
      _loadInitialData(widget.initialData!);
    }
  }

  void _loadInitialData(String data) {
    // Convert string data to points
    final pointStrings = data.split(';');
    _points = pointStrings.map((str) {
      if (str == 'null') return null;
      final coords = str.split(',');
      return Offset(double.parse(coords[0]), double.parse(coords[1]));
    }).toList();
  }

  String _pointsToString() {
    return _points
        .map((point) => point == null ? 'null' : '${point.dx},${point.dy}')
        .join(';');
  }

  void _updateWhiteboard() {
    ref
        .read(liveSessionServiceProvider)
        .updateWhiteboardData(widget.sessionId, _pointsToString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isEditable)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: !_isErasing ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () => setState(() => _isErasing = false),
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit_off,
                    color: _isErasing ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () => setState(() => _isErasing = true),
                ),
                Slider(
                  value: _strokeWidth,
                  min: 1.0,
                  max: 10.0,
                  onChanged: (value) => setState(() => _strokeWidth = value),
                ),
                IconButton(
                  icon: const Icon(Icons.palette),
                  onPressed: () => _showColorPicker(),
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() => _points.clear());
                    _updateWhiteboard();
                  },
                ),
              ],
            ),
          ),
        Expanded(
          child: GestureDetector(
            onPanStart: widget.isEditable
                ? (details) {
                    setState(() {
                      RenderBox renderBox =
                          context.findRenderObject() as RenderBox;
                      Offset localPosition = renderBox.globalToLocal(
                        details.globalPosition,
                      );
                      _points.add(localPosition);
                    });
                    _updateWhiteboard();
                  }
                : null,
            onPanUpdate: widget.isEditable
                ? (details) {
                    setState(() {
                      RenderBox renderBox =
                          context.findRenderObject() as RenderBox;
                      Offset localPosition = renderBox.globalToLocal(
                        details.globalPosition,
                      );
                      _points.add(localPosition);
                    });
                    _updateWhiteboard();
                  }
                : null,
            onPanEnd: widget.isEditable
                ? (details) {
                    setState(() {
                      _points.add(null);
                    });
                    _updateWhiteboard();
                  }
                : null,
            child: CustomPaint(
              painter: _WhiteboardPainter(
                points: _points,
                strokeColor: _strokeColor,
                strokeWidth: _strokeWidth,
                isErasing: _isErasing,
              ),
              size: Size.infinite,
            ),
          ),
        ),
      ],
    );
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _strokeColor,
            onColorChanged: (color) {
              setState(() => _strokeColor = color);
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _WhiteboardPainter extends CustomPainter {
  final List<Offset?> points;
  final Color strokeColor;
  final double strokeWidth;
  final bool isErasing;

  _WhiteboardPainter({
    required this.points,
    required this.strokeColor,
    required this.strokeWidth,
    required this.isErasing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isErasing ? Colors.white : strokeColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      } else if (points[i] != null && points[i + 1] == null) {
        canvas.drawPoints(ui.PointMode.points, [points[i]!], paint);
      }
    }
  }

  @override
  bool shouldRepaint(_WhiteboardPainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.strokeColor != strokeColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.isErasing != isErasing;
  }
}

class ColorPicker extends StatelessWidget {
  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;

  const ColorPicker({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: Colors.primaries.length,
      itemBuilder: (context, index) {
        final color = Colors.primaries[index];
        return GestureDetector(
          onTap: () => onColorChanged(color),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color: pickerColor == color ? Colors.white : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}
