import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel extends Equatable {
  const ResponseModel({
    required this.timestamp,
    required this.baseCurrency,
    required this.currencies,
  });

  @JsonKey(name: 'timestamp')
  final int timestamp;
  @JsonKey(name: 'base')
  final String baseCurrency;
  @JsonKey(name: 'rates')
  final Map<String, double> currencies;

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

  @override
  List<Object?> get props => <Object?>[timestamp, baseCurrency, currencies];
}
