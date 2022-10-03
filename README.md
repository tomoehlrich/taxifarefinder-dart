# taxifarefinder

A wrapper for the TaxiFareFinder API.

Documentation of the API can be found at
<https://www.taxifarefinder.com/api.php>.

The required TaxiFareFinder API key can be requested at
<https://www.taxifarefinder.com/contactus.php>.

## Usage


```dart
import 'package:taxifarefinder/taxifarefinder.dart';

var taxiFareFinder = TaxiFareFinder('<YOUR API KEY>');

// Find the nearest city supported by the TaxiFareFinder API
// A complete list if supported entities can be found at 
// https://www.taxifarefinder.com/api.php#entities
TffCity nearestCity = await taxiFareFinder.getNearestCity(13.736717, 100.523186);


// Get fare information like total fare, distance or tip information
TffFare fare = await taxiFareFinder.getFare(
    3.147948, 101.710347, 3.144169, 101.718519,
    traffic: TffTraffic.light);


// Retrieve a list of taxi companies in a supported city
List<TffTaxiCompany> companies = await taxiFareFinder.getTaxiCompanies('London');
```
