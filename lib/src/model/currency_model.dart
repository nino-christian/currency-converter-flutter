import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currency_model.g.dart';

@JsonSerializable()
class CurrencyModel extends Equatable {
  const CurrencyModel({
    required this.name,
    required this.rate,
  });

  final String name;
  final double rate;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyModelToJson(this);

  @override
  List<Object?> get props => <Object?>[name, rate];
}
