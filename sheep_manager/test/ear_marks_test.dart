import 'package:flutter_test/flutter_test.dart';
import 'package:sheep_manager/ear_marks.dart';

void main() {
  test('semnele se salvează și se citesc la fel', () {
    final marks = EarMarks(
      left: [EarMark(EarMarkType.notchV, EarMarkType.notchV.positions.first)],
      horns: HornState.horned,
    );
    final decoded = EarMarks.decode(marks.encode());
    expect(decoded, marks);
    expect(decoded.isEmpty, isFalse);
  });

  test('fără semne rezultă null', () {
    expect(const EarMarks().encode(), isNull);
    expect(EarMarks.decode(null).isEmpty, isTrue);
    expect(EarMarks.decode('invalid').isEmpty, isTrue);
  });
}
