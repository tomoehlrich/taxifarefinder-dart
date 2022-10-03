import 'package:taxifarefinder/taxifarefinder.dart';

void main() async {
  final taxiFareFinder = TaxiFareFinder('<YOUR API KEY>');

  try {
    final TffCity nearestCity =
        await taxiFareFinder.getNearestCity(42.356261, -71.065334);

    print(nearestCity.distance);
    print(nearestCity.fullName);
    print(nearestCity.handle);
    print(nearestCity.howFound);
    print(nearestCity.locale);
    print(nearestCity.name);

    final TffFare fare = await taxiFareFinder.getFare(
      3.147948,
      101.710347,
      3.144169,
      101.718519,
      traffic: TffTraffic.light,
    );

    print(fare.currencySymbol);
    print(fare.distance);
    print(fare.duration);
    print(fare.initialFare);
    print(fare.locale);
    print(fare.meteredFare);
    print(fare.rateArea);
    print(fare.tipAmount);
    print(fare.tipPercentage);
    print(fare.totalFare);
    print(fare.totalFareWithoutTip);

    for (final extraCharge in fare.extraCharges) {
      print(extraCharge.charge);
      print(extraCharge.description);
    }

    for (final flatRate in fare.flatRates) {
      print(flatRate.charge);
      print(flatRate.description);
    }

    final List<TffTaxiCompany> taxiCompanies =
        await taxiFareFinder.getTaxiCompanies('London');

    for (final taxiCompany in taxiCompanies) {
      print(taxiCompany.name);
      print(taxiCompany.phone);
      print(taxiCompany.type);
    }
  } on TffException catch (e) {
    print('TffException: ${e.message()}');
  } catch (e) {
    print('Exception: $e');
  }
}
