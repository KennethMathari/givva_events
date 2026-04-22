import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givva_events/injection.dart';
import 'package:givva_events/logic/bloc/fundraiser_bloc.dart';
import 'package:givva_events/presentation/screens/events_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  setupLocator();

  runApp(const MyApp());
}

/// The root widget of the Givva Events application.
class MyApp extends StatelessWidget {
  /// Creates a [MyApp].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Use locator to get a fresh instance of the Bloc
      create: (context) => locator<FundraiserBloc>(),
      child: MaterialApp(
        title: 'Givva Events',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        home: const EventsScreen(),
      ),
    );
  }
}
