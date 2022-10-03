import 'package:taxifarefinder/taxifarefinder.dart';
import 'package:test/test.dart';

import 'config.dart';

void main() {
  final taxiFareFinder = TaxiFareFinder(tffApiKey);

  group('Test nearest city:', () {
    test('Missing lat, lng throws exception', () {
      expect(
        () async => taxiFareFinder.getNearestCity(null, null),
        throwsException,
      );
    });

    test('Valid lat, lng returns a valid response and City class', () async {
      final response =
          await taxiFareFinder.getNearestCity(42.356261, -71.065334);

      expect(response, isA<TffCity>());
    });

    test(
        'Valid lat, lng returns a valid response and the right handle in the City class',
        () async {
      final response =
          await taxiFareFinder.getNearestCity(42.356261, -71.065334);

      expect(response.handle, equals('Boston'));
    });

    test(
        'Location without an entity/city nearby returns a custom NO_MATCHING_ENTITY exception',
        () async {
      try {
        await taxiFareFinder.getNearestCity(13.75398, 100.50144);
      } on TffException catch (e) {
        expect(e.code, 'NO_MATCHING_ENTITY');
      }
    });
  });

  group('Test taxi fare:', () {
    test(
        'Missing originLat, originLng, destinationLat, destinationLng throws exception',
        () {
      expect(
        () async => taxiFareFinder.getFare(null, null, null, null),
        throwsException,
      );
    });

    test('Valid parameters return a valid response and Fare class', () async {
      final response = await taxiFareFinder.getFare(
        42.368025,
        -71.022155,
        42.362571,
        -71.055543,
      );

      expect(response, isA<TffFare>());
    });

    test('The right rate_area is returned', () async {
      final response = await taxiFareFinder.getFare(
        42.368025,
        -71.022155,
        42.362571,
        -71.055543,
      );

      expect(response.rateArea, 'Boston, MA');
    });

    test('A valid total amount without tip is calculated', () async {
      final response = await taxiFareFinder.getFare(
        51.227151,
        6.777033,
        51.296082,
        6.863858,
        city: 'Dusseldorf-Germany',
      );

      expect(response.totalFare, greaterThan(response.totalFareWithoutTip));
    });

    test('A valid currency Symbol is returned', () async {
      final response = await taxiFareFinder.getFare(
        51.227151,
        6.777033,
        51.296082,
        6.863858,
        city: 'Dusseldorf-Germany',
      );

      expect(response.currencySymbol, equals('EUR'));
    });

    test('An unknown entity / city returns a custom UNKNOWN_ENTITY exception',
        () async {
      try {
        await taxiFareFinder.getFare(
          42.368025,
          -71.022155,
          42.362571,
          -71.055543,
          city: 'Dummy Entity',
        );
      } on TffException catch (e) {
        expect(e.code, 'UNKNOWN_ENTITY');
      }
    });

    test(
        'Valid parameters return a valid response and factor in light or heavy traffic',
        () async {
      final responseLightTraffic = await taxiFareFinder.getFare(
        42.368025,
        -71.022155,
        42.362571,
        -71.055543,
        traffic: TffTraffic.light,
      );

      final responseHeavyTraffic = await taxiFareFinder.getFare(
        42.368025,
        -71.022155,
        42.362571,
        -71.055543,
        traffic: TffTraffic.heavy,
      );

      expect(
        responseLightTraffic.totalFare,
        lessThanOrEqualTo(responseHeavyTraffic.totalFare),
      );
    });
  });

  group('Test taxi companies:', () {
    test('Missing entity throws exception', () {
      expect(
        () async => taxiFareFinder.getTaxiCompanies(null),
        throwsException,
      );
    });

    test('Valid entity returns a valid response and List<TaxiCompany>',
        () async {
      final response = await taxiFareFinder.getTaxiCompanies('Boston');

      expect(response, const TypeMatcher<List<TffTaxiCompany>>());
    });

    test('Non-empty businesses are returned', () async {
      final response = await taxiFareFinder.getTaxiCompanies('Boston');

      expect(response.length, greaterThan(0));
    });

    test(
        'Location without an entity/city nearby returns a custom UNKNOWN_ENTITY exception',
        () async {
      try {
        await taxiFareFinder.getTaxiCompanies('DummyEntity');
      } on TffException catch (e) {
        expect(e.code, 'UNKNOWN_ENTITY');
      }
    });
  });
}
