// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:currency_converter_flutterr/main.dart';
import 'package:currency_converter_flutterr/src/feature/converter/bloc/currency_bloc.dart';
import 'package:currency_converter_flutterr/src/feature/converter/widget/app_textformfield.dart';
import 'package:currency_converter_flutterr/src/feature/converter/widget/converter_form_row.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyBloc extends Mock implements CurrencyBloc {}

void main() {
  testWidgets('Verify that the two text form fields are present',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(const MyApp());

    // Act
    final converterFormRowFinder = find.byType(ConverterFormRow);

    // Assert
    expect(converterFormRowFinder, findsNWidgets(2));
  });

  testWidgets('Verify that the two text fields are present',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(const MyApp());
    // Act
    final parentFinder = find.byType(ConverterFormRow);
    // Assert
    expect(parentFinder, findsNWidgets(2));

    // Act
    final textFieldFinder = find.descendant(
        of: parentFinder, matching: find.byType(AppTextFormField));

    // Assert
    expect(textFieldFinder, findsNWidgets(2));
  });
}
