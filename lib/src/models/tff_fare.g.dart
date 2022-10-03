// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tff_fare.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TffFare _$TffFareFromJson(Map<String, dynamic> json) => TffFare(
      status: json['status'] as String,
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      duration: (json['duration'] as num?)?.toDouble() ?? 0.0,
      totalFare: (json['total_fare'] as num?)?.toDouble() ?? 0.0,
      initialFare: json['initial_fare'] == null
          ? 0.0
          : TffFare._stringToDouble(json['initial_fare'] as String),
      meteredFare: (json['metered_fare'] as num?)?.toDouble() ?? 0.0,
      tipAmount: (json['tip_amount'] as num?)?.toDouble() ?? 0.0,
      tipPercentage: json['tip_percentage'] == null
          ? 0.0
          : TffFare._stringToDouble(json['tip_percentage'] as String),
      locale: json['locale'] as String? ?? 'en_US',
      currency: json['currency'] == null
          ? null
          : _TffCurrency.fromJson(json['currency'] as Map<String, dynamic>),
      rateArea: json['rate_area'] as String? ?? '',
      flatRates: (json['flat_rates'] as List<dynamic>?)
              ?.map((e) => TffFlatRate.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      extraCharges: (json['extra_charges'] as List<dynamic>?)
              ?.map((e) => TffExtraCharge.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

TffFlatRate _$TffFlatRateFromJson(Map<String, dynamic> json) => TffFlatRate(
      charge: TffFlatRate._stringToDouble(json['charge'] as String),
      description: json['description'] as String?,
    );

TffExtraCharge _$TffExtraChargeFromJson(Map<String, dynamic> json) =>
    TffExtraCharge(
      charge: TffExtraCharge._stringToDouble(json['charge'] as String),
      description: json['description'] as String?,
    );

_TffCurrency _$TffCurrencyFromJson(Map<String, dynamic> json) => _TffCurrency(
      intSymbol: json['int_symbol'] as String,
    );
