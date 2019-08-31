import 'package:json_annotation/json_annotation.dart';

part 'tff_city.g.dart';

@JsonSerializable(createToJson: false)
class TffCity {
  TffCity(this.status, this.name, this.fullName, this.handle, this.locale,
      this.distance, this.howFound);

  final String status;

  /// The short name of the city / entity
  final String name;

  /// The long name of the city / entity
  @JsonKey(name: 'full_name')
  final String fullName;

  /// The handle of the city / entity.
  /// Can be optionally used in [getFare] and as a mandatory parameter
  /// in [getTaxiCompanies].
  final String handle;

  /// The locale of the city / entity, for example en_US
  final String locale;

  /// The distance from the given location to the city/entity in meters
  final double distance;

  /// The method the API was able to find the city / entity with.
  /// Can be geocode, nearest or empty.
  @JsonKey(name: 'how_found')
  final String howFound;

  factory TffCity.fromJson(Map<String, dynamic> json) =>
      _$TffCityFromJson(json);
}
