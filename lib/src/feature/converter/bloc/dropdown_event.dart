part of 'dropdown_bloc.dart';

@immutable
abstract class DropdownEvent {}

class ChangeDropdownValueEvent extends DropdownEvent {
  final CurrencyModel newValue;
  final Function(CurrencyModel) onChange;
  final int dropDownIndex;

  ChangeDropdownValueEvent({
    required this.newValue,
    required this.onChange,
    required this.dropDownIndex,
  });
}
