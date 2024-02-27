import 'package:bloc/bloc.dart';
import 'package:currency_converter_flutterr/src/model/currency_model.dart';
import 'package:meta/meta.dart';

part 'dropdown_event.dart';
part 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(const DropdownState()) {
    on<ChangeDropdownValueEvent>(
        (event, emit) => _onDropDownValueChange(event, emit));
  }

  void _onDropDownValueChange(
      ChangeDropdownValueEvent event, Emitter<DropdownState> emit) {
    if (event.dropDownIndex == 0) {
      emit(DropdownState(
          inputSelectedValue: event.newValue,
          outputSelectedValue: state.outputSelectedValue));
    } else if (event.dropDownIndex == 1) {
      emit(DropdownState(
          inputSelectedValue: state.inputSelectedValue,
          outputSelectedValue: event.newValue));
    }
    event.onChange(event.newValue);
  }
}
