// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyModel _$CurrencyModelFromJson(Map<String, dynamic> json) =>
    CurrencyModel(
      name: json['name'] as String,
      rate: (json['rate'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrencyModelToJson(CurrencyModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'rate': instance.rate,
    };
