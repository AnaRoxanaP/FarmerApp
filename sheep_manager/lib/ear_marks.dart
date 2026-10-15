import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _ink = Color(0xFF18352B);
const _earFill = Color(0xFFE8F1E8);
const _background = Color(0xFFFFFDF7);
const _muted = Color(0xFF758078);

enum EarMarkPosition {
  tip('tip', 'vârf'),
  top('top', 'marginea de sus'),
  bottom('bottom', 'marginea de jos'),
  center('center', 'mijloc');

  const EarMarkPosition(this.code, this.label);
  final String code;
  final String label;

  static EarMarkPosition? fromCode(String? code) {
    for (final value in values) {
      if (value.code == code) return value;
    }
    return null;
  }
}

enum EarMarkType {
  notchV('v', 'Crestătură în V', [EarMarkPosition.tip, EarMarkPosition.top, EarMarkPosition.bottom]),
  // Codul „u” rămâne pentru compatibilitate cu semnele deja salvate.
  notchL('u', 'Crestătură în L', [EarMarkPosition.tip, EarMarkPosition.top, EarMarkPosition.bottom]),
  split('split', 'Despicătură', [EarMarkPosition.tip]),
  sideCut('cut', 'Tăietură fină', [EarMarkPosition.top, EarMarkPosition.bottom]),
  hole('hole', 'Orificiu', [EarMarkPosition.center]);

  const EarMarkType(this.code, this.label, this.positions);
  final String code;
  final String label;
  final List<EarMarkPosition> positions;

  static EarMarkType? fromCode(String? code) {
    for (final value in values) {
      if (value.code == code) return value;
    }
    return null;
  }
}

enum HornState {
  none('none', 'Fără coarne'),
  horned('horned', 'Cu coarne'),
  marked('marked', 'Coarne marcate');

  const HornState(this.code, this.label);
  final String code;
  final String label;

  static HornState fromCode(String? code) {
    for (final value in values) {
      if (value.code == code) return value;
    }
    return HornState.none;
  }
}

@immutable
class EarMark {
  const EarMark(this.type, this.position);

  final EarMarkType type;
  final EarMarkPosition position;

  String get label => type.positions.length == 1 ? type.label : '${type.label} · ${position.label}';

  String get _code => '${type.code}:${position.code}';

  static EarMark? _parse(Object? source) {
    if (source is! String) return null;
    final parts = source.split(':');
    if (parts.length != 2) return null;
    final type = EarMarkType.fromCode(parts[0]);
    final position = EarMarkPosition.fromCode(parts[1]);
    if (type == null || position == null || !type.positions.contains(position)) return null;
    return EarMark(type, position);
  }

  @override
  bool operator ==(Object other) => other is EarMark && other.type == type && other.position == position;

  @override
  int get hashCode => Object.hash(type, position);
}

/// Semnele celor două urechi și starea coarnelor, păstrate ca text JSON în fișa animalului.
@immutable
class EarMarks {
  const EarMarks({this.left = const [], this.right = const [], this.horns = HornState.none});

  final List<EarMark> left;
  final List<EarMark> right;
  final HornState horns;

  bool get isEmpty => left.isEmpty && right.isEmpty && horns == HornState.none;

  EarMarks copyWith({List<EarMark>? left, List<EarMark>? right, HornState? horns}) =>
      EarMarks(left: left ?? this.left, right: right ?? this.right, horns: horns ?? this.horns);

  String? encode() {
    if (isEmpty) return null;
    return jsonEncode({
      'l': [for (final mark in left) mark._code],
      'r': [for (final mark in right) mark._code],
      'h': horns.code,
    });
  }

  static EarMarks decode(String? source) {
    if (source == null || source.isEmpty) return const EarMarks();
    try {
      final map = jsonDecode(source) as Map<String, dynamic>;
      List<EarMark> read(Object? list) => [
            if (list is List)
              for (final item in list)
                if (EarMark._parse(item) case final mark?) mark,
          ];
      return EarMarks(left: read(map['l']), right: read(map['r']), horns: HornState.fromCode(map['h'] as String?));
    } catch (_) {
      return const EarMarks();
    }
  }

  String get summary {
    String ear(String name, List<EarMark> marks) => '$name: ${marks.isEmpty ? 'întreagă' : marks.map((mark) => mark.label.toLowerCase()).join(', ')}';
    return [ear('Stânga', left), ear('Dreapta', right), horns.label].join('\n');
  }

  @override
  bool operator ==(Object other) => other is EarMarks && listEquals(other.left, left) && listEquals(other.right, right) && other.horns == horns;

  @override
  int get hashCode => Object.hash(Object.hashAll(left), Object.hashAll(right), horns);
}

/// Desenează urechile ca simbolul ∞, cu semnele aplicate pe fiecare buclă, și coarnele deasupra.
class EarMarksView extends StatelessWidget {
  const EarMarksView({required this.marks, this.height = 110, this.showLabels = true, super.key});

  final EarMarks marks;
  final double height;
  final bool showLabels;

  @override
  Widget build(BuildContext context) {
    final hasHorns = marks.horns != HornState.none;
    final size = Size(height * 2.2, hasHorns ? height * 1.3 : height);
    return Column(mainAxisSize: MainAxisSize.min, children: [
      CustomPaint(size: size, painter: _EarsPainter(marks)),
      if (showLabels)
        SizedBox(
          width: size.width,
          child: const Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text('Stânga', style: TextStyle(fontSize: 10, color: _muted)),
            Text('Dreapta', style: TextStyle(fontSize: 10, color: _muted)),
          ]),
        ),
    ]);
  }
}

class _EarsPainter extends CustomPainter {
  _EarsPainter(this.marks);

  final EarMarks marks;

  @override
  void paint(Canvas canvas, Size size) {
    final hasHorns = marks.horns != HornState.none;
    final top = hasHorns ? size.height * 0.3 : 0.0;
    final earSize = Size(size.width / 2, size.height - top);

    canvas.save();
    canvas.translate(0, top);
    _paintEar(canvas, earSize, marks.left);
    canvas.restore();

    // Urechea dreaptă este oglinda celei stângi; ambele se întâlnesc în centrul simbolului ∞.
    canvas.save();
    canvas.translate(size.width, top);
    canvas.scale(-1, 1);
    _paintEar(canvas, earSize, marks.right);
    canvas.restore();

    if (hasHorns) _paintHorns(canvas, size, top);
  }

  void _paintEar(Canvas canvas, Size size, List<EarMark> earMarks) {
    final w = size.width;
    final h = size.height;
    final pad = h * 0.04;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (h / 45).clamp(1.5, 3.0)
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..color = _ink;

    final base = Offset(w, h / 2);
    final tip = Offset(pad + stroke.strokeWidth, h / 2);
    final outline = Path()
      ..moveTo(base.dx, base.dy)
      ..cubicTo(w * 0.75, pad, w * 0.2, h * 0.08, tip.dx, tip.dy)
      ..cubicTo(w * 0.2, h * 0.92, w * 0.75, h - pad, base.dx, base.dy)
      ..close();
    canvas.drawPath(outline, Paint()..color = _earFill);
    canvas.drawPath(outline, stroke);

    final metric = outline.computeMetrics().first;
    final s = h * 0.3;
    for (final mark in earMarks) {
      if (mark.type == EarMarkType.hole) {
        final center = Offset(w * 0.45, h / 2);
        canvas.drawCircle(center, s * 0.4, Paint()..color = _background);
        canvas.drawCircle(center, s * 0.4, stroke);
        continue;
      }
      final Offset point;
      final Offset along;
      if (mark.position == EarMarkPosition.tip) {
        point = tip;
        along = const Offset(0, 1);
      } else {
        final tangent = metric.getTangentForOffset(metric.length * (mark.position == EarMarkPosition.top ? 0.27 : 0.73))!;
        point = tangent.position;
        along = tangent.vector;
      }
      // Normala spre interiorul urechii.
      final inward = Offset(along.dy, -along.dx);
      _paintCut(canvas, mark.type, point, along, inward, s, stroke);
    }
  }

  void _paintCut(Canvas canvas, EarMarkType type, Offset p, Offset along, Offset inward, double s, Paint stroke) {
    final cut = Path();
    switch (type) {
      case EarMarkType.notchV:
        cut
          ..moveTo(p.dx - along.dx * s * 0.5, p.dy - along.dy * s * 0.5)
          ..lineTo(p.dx + inward.dx * s, p.dy + inward.dy * s)
          ..lineTo(p.dx + along.dx * s * 0.5, p.dy + along.dy * s * 0.5);
      case EarMarkType.notchL:
        // Tăietură în unghi drept: spre interior, apoi de-a lungul urechii.
        final corner = p + inward * (s * 1.4);
        cut
          ..moveTo(p.dx, p.dy)
          ..lineTo(corner.dx, corner.dy)
          ..lineTo(corner.dx + along.dx * s * 1.1, corner.dy + along.dy * s * 1.1);
      case EarMarkType.sideCut:
        cut
          ..moveTo(p.dx - along.dx * s * 0.08, p.dy - along.dy * s * 0.08)
          ..lineTo(p.dx + inward.dx * s * 1.5, p.dy + inward.dy * s * 1.5)
          ..lineTo(p.dx + along.dx * s * 0.08, p.dy + along.dy * s * 0.08);
      case EarMarkType.split:
        cut
          ..moveTo(p.dx - along.dx * s * 0.12, p.dy - along.dy * s * 0.12)
          ..lineTo(p.dx + inward.dx * s * 2.6, p.dy + inward.dy * s * 2.6)
          ..lineTo(p.dx + along.dx * s * 0.12, p.dy + along.dy * s * 0.12);
      case EarMarkType.hole:
        return;
    }
    canvas.drawPath(cut, Paint()..color = _background);
    canvas.drawPath(cut, stroke);
  }

  void _paintHorns(Canvas canvas, Size size, double top) {
    final cx = size.width / 2;
    final y0 = top + (size.height - top) / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = _ink;
    for (final direction in const [-1.0, 1.0]) {
      final horn = Path()
        ..moveTo(cx, y0)
        ..quadraticBezierTo(cx + direction * size.width * 0.02, top * 0.35, cx + direction * size.width * 0.11, 2);
      canvas.drawPath(horn, paint);
      if (marks.horns == HornState.marked) {
        final metric = horn.computeMetrics().first;
        final tangent = metric.getTangentForOffset(metric.length * 0.6)!;
        final normal = Offset(tangent.vector.dy, -tangent.vector.dx) * 6;
        canvas.drawLine(tangent.position - normal, tangent.position + normal, paint..strokeWidth = 2);
        paint.strokeWidth = 3;
      }
    }
  }

  @override
  bool shouldRepaint(_EarsPainter oldDelegate) => oldDelegate.marks != marks;
}

/// Alegerea semnelor: urechea stângă sau dreaptă, tipul și poziția fiecărui semn, apoi coarnele.
class EarMarksEditor extends StatefulWidget {
  const EarMarksEditor({required this.value, required this.onChanged, super.key});

  final EarMarks value;
  final ValueChanged<EarMarks> onChanged;

  @override
  State<EarMarksEditor> createState() => _EarMarksEditorState();
}

class _EarMarksEditorState extends State<EarMarksEditor> {
  bool _left = true;
  EarMarkType _type = EarMarkType.notchV;
  EarMarkPosition _position = EarMarkPosition.tip;

  List<EarMark> get _current => _left ? widget.value.left : widget.value.right;

  void _setCurrent(List<EarMark> marks) => widget.onChanged(_left ? widget.value.copyWith(left: marks) : widget.value.copyWith(right: marks));

  void _selectType(EarMarkType type) => setState(() {
        _type = type;
        if (!type.positions.contains(_position)) _position = type.positions.first;
      });

  void _add() {
    final mark = EarMark(_type, _position);
    if (!_current.contains(mark)) _setCurrent([..._current, mark]);
  }

  @override
  Widget build(BuildContext context) {
    const heading = TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _ink);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Center(child: EarMarksView(marks: widget.value)),
      const SizedBox(height: 12),
      SegmentedButton<bool>(
        segments: const [ButtonSegment(value: true, label: Text('Urechea stângă')), ButtonSegment(value: false, label: Text('Urechea dreaptă'))],
        selected: {_left},
        onSelectionChanged: (selection) => setState(() => _left = selection.first),
      ),
      const SizedBox(height: 10),
      if (_current.isEmpty)
        const Text('Ureche întreagă, fără semne.', style: TextStyle(fontSize: 12, color: _muted))
      else
        Wrap(spacing: 8, runSpacing: 4, children: [
          for (final mark in _current) InputChip(label: Text(mark.label), onDeleted: () => _setCurrent([..._current]..remove(mark))),
        ]),
      const SizedBox(height: 12),
      const Text('Adaugă un semn', style: heading),
      const SizedBox(height: 6),
      Wrap(spacing: 8, runSpacing: 4, children: [
        for (final type in EarMarkType.values) ChoiceChip(label: Text(type.label), selected: _type == type, onSelected: (_) => _selectType(type)),
      ]),
      if (_type.positions.length > 1) ...[
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 4, children: [
          for (final position in _type.positions) ChoiceChip(label: Text(position.label), selected: _position == position, onSelected: (_) => setState(() => _position = position)),
        ]),
      ],
      const SizedBox(height: 8),
      OutlinedButton.icon(onPressed: _add, icon: const Icon(Icons.add, size: 18), label: Text('Adaugă pe urechea ${_left ? 'stângă' : 'dreaptă'}')),
      const SizedBox(height: 16),
      const Text('Coarne', style: heading),
      const SizedBox(height: 6),
      Wrap(spacing: 8, runSpacing: 4, children: [
        for (final state in HornState.values) ChoiceChip(label: Text(state.label), selected: widget.value.horns == state, onSelected: (_) => widget.onChanged(widget.value.copyWith(horns: state))),
      ]),
    ]);
  }
}
