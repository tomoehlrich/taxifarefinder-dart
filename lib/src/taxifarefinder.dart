import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:taxifarefinder/src/exceptions/tff_exception.dart';

import 'package:taxifarefinder/src/models/tff_city.dart';
import 'package:taxifarefinder/src/models/tff_fare.dart';
import 'package:taxifarefinder/src/models/tff_taxi_company.dart';

const _apiBaseUrl = 'api.taxifarefinder.com';

enum TffTraffic { light, medium, heavy }

/// A wrapper for the TaxiFareFinder API
///
/// ## Installing ##
///
/// Use [pub][] to install this package. Add the following to your
/// `pubspec.yaml` file.
///
///     dependencies:
///       taxifarefinder: any
///
/// Then run `pub install`.
///
/// For more information, see the [taxifarefinder package on pub.dartlang.org][pkg].
///
/// [pub]: http://pub.dartlang.org
/// [pkg]: http://pub.dartlang.org/packages/taxifarefinder
///
/// ## Usage ##
///
/// Import the library
///
///     import 'package:taxifarefinder/taxifarefinder.dart';
///
/// Create a TaxiFareFinder instance
///
///     var taxiFareFinder = TaxiFareFinder('<YOUR API KEY>');
///
/// The TaxiFareFinder API key can be requested under
/// https://www.taxifarefinder.com/contactus.php
///
class TaxiFareFinder {
  String _apiKey = '';

  TaxiFareFinder(String apiKey) {
    _apiKey = apiKey;
  }

  /// Retrieves information about the nearest supported city from the API.
  ///
  /// Throws an [Exception] if mandatory parameters are missing or the
  /// API does not return status code 200. Throws a [TffException]
  /// if the API returns an error.
  ///
  /// Expects [lat] and [lng] of the location the nearest supported city
  /// should be found at. Accepts an optional [maxDistance] to limit
  /// the the search radius.
  ///
  ///     TffCity nearestCity = await tff.getNearestCity(13.736717, 100.523186);

  Future<TffCity> getNearestCity(
    double? lat,
    double? lng, {
    int maxDistance = 80467,
  }) async {
    if (lat == null || lng == null) {
      throw Exception('Latitude and longitude are mandatory');
    }

    final queryParameters = <String, String>{
      'key': _apiKey,
      'location': '$lat,$lng',
      'max_distance': maxDistance.toString()
    };

    final uri = Uri.https(_apiBaseUrl, 'entity', queryParameters);

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load data from the TaxiFareFinder API');
    }

    final TffCity city =
        TffCity.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

    if (city.status != 'OK') {
      throw TffException(city.status);
    }

    return city;
  }

  /// Retrieves the fare information from the API.
  ///
  /// Throws an [Exception] if mandatory parameters are missing or the
  /// API does not return status code 200. Throws a [TffException]
  /// if the API returns an error.
  ///
  /// Expects [originLat] and [originLng] of the starting point and
  /// [destinationLat] and [destinationLng] as the destination's
  /// coordinates.
  /// Accepts an optional [city] (entity) to speed up the API response,
  /// a [traffic] parameter in the form light|medium|heavy and
  /// a [maxDistance] to limit the the search radius.
  Future<TffFare> getFare(
    double? originLat,
    double? originLng,
    double? destinationLat,
    double? destinationLng, {
    String? city = '',
    TffTraffic? traffic = TffTraffic.medium,
    int? maxDistance = 80467,
  }) async {
    if (originLat == null ||
        originLng == null ||
        destinationLat == null ||
        destinationLng == null) {
      throw Exception(
        'Latitude and longitude for origin and destination are mandatory',
      );
    }

    final queryParameters = <String, String>{
      'key': _apiKey,
      'origin': '$originLat,$originLng',
      'destination': '$destinationLat,$destinationLng',
      'traffic': traffic.toString().split('.').last,
      'max_distance': maxDistance.toString()
    };

    if (city != null && city.isNotEmpty) {
      queryParameters['entity_handle'] = city;
    }

    final uri = Uri.https(_apiBaseUrl, 'fare', queryParameters);

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load data from the TaxiFareFinder API');
    }

    final TffFare trip =
        TffFare.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

    if (trip.status != 'OK') {
      throw TffException(trip.status);
    }

    return trip;
  }

  /// Retrieves a list of taxi companies in the given city (entity).
  ///
  /// Throws an [Exception] if mandatory parameters are missing or the
  /// API does not return status code 200. Throws a [TffException]
  /// if the API returns an error.
  ///
  /// Expects an [city].
  Future<List<TffTaxiCompany>> getTaxiCompanies(String? city) async {
    if (city == null) {
      throw Exception('A city (entity) is mandatory');
    }

    final queryParameters = <String, String>{
      'key': _apiKey,
      'entity_handle': city
    };

    final uri = Uri.https(_apiBaseUrl, 'businesses', queryParameters);

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load data from the TaxiFareFinder API');
    }

    final TffTaxiCompanyList taxiCompanyList = TffTaxiCompanyList.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );

    if (taxiCompanyList.status != 'OK') {
      throw TffException(taxiCompanyList.status);
    }

    final List<TffTaxiCompany> taxiCompanies = taxiCompanyList.businesses ?? [];

    return taxiCompanies;
  }
}
