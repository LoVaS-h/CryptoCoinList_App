import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coin_details.g.dart';

@JsonSerializable()

@HiveType(typeId: 1)
class CryptoCoinDetails{
  @HiveField(0)
  @JsonKey(name: 'PRICE')
  final double priceInUSD;

  @HiveField(1)
  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;

  @HiveField(2)
  @JsonKey(name: 'HIGH24HOUR')
  final double high24hours;

  @HiveField(3)
  @JsonKey(name: 'LOW24HOUR')
  final double low24hours;

  String get fullimageUrl => 'https://www.cryptocompare.com/$imageUrl';
  double get finalPriceInUSD => roundDouble(priceInUSD, 4);
  double get finalHigh24hours => roundDouble(high24hours, 4);
  double get finalLow24hours => roundDouble(low24hours, 4);

  const CryptoCoinDetails(
    {required this.priceInUSD,
    required this.imageUrl,
    required this.high24hours,
    required this.low24hours,
  });

  factory CryptoCoinDetails.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailsToJson(this);


  double roundDouble(double value, int decimalPlaces) {
    final factor = pow(10, decimalPlaces).toDouble();
    return (value * factor).roundToDouble() / factor;
  }
}