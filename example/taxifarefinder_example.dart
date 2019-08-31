import 'package:taxifarefinder/taxifarefinder.dart';

main() async {
  var taxiFareFinder = TaxiFareFinder('<YOUR API KEY>');

  try {
    TffCity nearestCity =
        await taxiFareFinder.getNearestCity(42.356261, -71.065334);

    print(nearestCity.distance);
    print(nearestCity.fullName);
    print(nearestCity.handle);
    print(nearestCity.howFound);
    print(nearestCity.locale);
    print(nearestCity.name);

    TffFare fare = await taxiFareFinder.getFare(
        3.147948, 101.710347, 3.144169, 101.718519,
        traffic: TffTraffic.light);

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

    fare.extraCharges.forEach((extraCharge) {
      print(extraCharge.charge);
      print(extraCharge.description);
    });
    fare.flatRates.forEach((flatRate) {
      print(flatRate.charge);
      print(flatRate.description);
    });

    List<TffTaxiCompany> taxiCompanies =
        await taxiFareFinder.getTaxiCompanies('London');

    taxiCompanies.forEach((taxiCompany) {
      print(taxiCompany.name);
      print(taxiCompany.phone);
      print(taxiCompany.type);
    });
  } on TffException catch (e) {
    print('TffException: ${e.message()}');
  } catch (e) {
    print('Exception: $e');
  }
}
