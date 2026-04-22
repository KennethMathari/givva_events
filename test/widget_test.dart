import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:givva_events/logic/bloc/fundraiser_bloc.dart';
import 'package:givva_events/presentation/screens/events_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockFundraiserBloc extends MockBloc<FundraiserEvent, FundraiserState>
    implements FundraiserBloc {}

void main() {
  late MockFundraiserBloc mockBloc;

  setUp(() {
    mockBloc = MockFundraiserBloc();

    // Mock initial state
    when(() => mockBloc.state).thenReturn(FundraiserState.initial());
  });

  testWidgets('EventsScreen renders title', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<FundraiserBloc>.value(
          value: mockBloc,
          child: const EventsScreen(),
        ),
      ),
    );

    expect(find.text('Fund Collection Events'), findsOneWidget);
  });
}
