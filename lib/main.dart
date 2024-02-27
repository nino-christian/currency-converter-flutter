import 'package:currency_converter_flutterr/src/constants/app_colors.dart';
import 'package:currency_converter_flutterr/src/feature/converter/api/repository/api_repository.dart';
import 'package:currency_converter_flutterr/src/feature/converter/api/service/api_service.dart';
import 'package:currency_converter_flutterr/src/feature/converter/bloc/currency_bloc.dart';
import 'package:currency_converter_flutterr/src/feature/converter/bloc/dropdown_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'src/feature/converter/screen/converter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider(create: (_) => APIRepository(client: http.Client())),
        Provider(
            create: (context) => APIService(
                  apiRepository: context.read<APIRepository>(),
                ))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                CurrencyBloc(apiService: context.read<APIService>()),
          ),
          BlocProvider(
            create: (context) => DropdownBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.royalBlue),
            useMaterial3: true,
          ),
          home: const ConverterScreen(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}
