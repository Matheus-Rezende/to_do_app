import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/core/result/result.dart';

void main() {
  group('Should test OK result', () {
    test('Should test a OK result', () {
      final result = Result.ok('OK');
      expect(result.asOk.value, 'OK');
    });

    test('Should test a ERROR result', () {
      final result = Result.error(Exception('Um erro ocorreu...'));

      expect(result.asError.exception, isA<Exception>());
    });

    test('Should test a OK result with extension', () {
      final result = 'Ok'.ok();

      expect(result.asOk.value, 'Ok');
    });

    test('Should test a ERROR result with extension', () {
      final result = Exception('Error').error();

      expect(result.asError.exception, isA<Exception>());
    });
  });
}
