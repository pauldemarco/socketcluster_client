import 'package:test/test.dart';
import '../lib/socketcluster_client.dart';

void main() {
  group('Parser', () {
    group('parse', () {
      group('No event', () {
        test('Receiving our first response returns ISAUTHENTICATED', () {
          ParseResult result = Parser.parse(null, 1, 0, null);
          expect(result, equals(ParseResult.ISAUTHENTICATED));
        });
        test('No event, but also not the first response', () {
          ParseResult result = Parser.parse(null, 10, 0, null);
          expect(result, equals(ParseResult.ACKRECEIVE));
        });
      });
      test('#publish event', () {
        ParseResult result = Parser.parse(null, 10, 0, '#publish');
        expect(result, equals(ParseResult.PUBLISH));
      });
      test('#removeAuthToken event', () {
        ParseResult result = Parser.parse(null, 10, 0, '#removeAuthToken');
        expect(result, equals(ParseResult.REMOVETOKEN));
      });
      test('#setAuthToken event', () {
        ParseResult result = Parser.parse(null, 10, 0, '#setAuthToken');
        expect(result, equals(ParseResult.SETTOKEN));
      });
      test('other events', () {
        ParseResult result = Parser.parse(null, 10, 0, 'someEvent');
        expect(result, equals(ParseResult.EVENT));

        result = Parser.parse(null, 10, 0, '#noblameculture');
        expect(result, equals(ParseResult.EVENT));
      });
    });
  });
}
