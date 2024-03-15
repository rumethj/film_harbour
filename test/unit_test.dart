import 'package:film_harbour/details_page/checker.dart';
import 'package:film_harbour/user_lists_page/user_list_action.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:film_harbour/details_page/person_details_page.dart';
import 'package:film_harbour/details_page/tv_details_page.dart';
import 'package:flutter/material.dart';
import 'package:film_harbour/details_page/movie_details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('DescriptionCheckUi Widget Tests', () {
    testWidgets('Renders ErrorUi for unknown type', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: DescriptionCheckUi(1, 'unknown'),
        ),
      );

      // Act
      await tester.pump();

      // Assert
      expect(find.byType(MovieDetailsPage), findsNothing);
      expect(find.byType(TvDetailsPage), findsNothing);
      expect(find.byType(PersonDetailsPage), findsNothing);
      expect(find.text('Error'), findsOneWidget);
    });
  });

  group('Shared Preferences Utils', () {
    test('Read watch list', () async {
      // Arrange
      SharedPreferences mockSharedPreferences = MockSharedPreferences();
      when(mockSharedPreferences.getStringList('watchList')).thenReturn(['123', '456', '789']); // Existing items in watch list
      SharedPreferences.setMockInitialValues({'watchList': ['123', '456', '789']});

      // Act
      List<int> watchList = await readWatchList();

      // Assert
      expect(watchList, [123, 456, 789]);
    });

    test('Read watched list', () async {
      // Arrange
      SharedPreferences mockSharedPreferences = MockSharedPreferences();
      when(mockSharedPreferences.getStringList('watchedList')).thenReturn(['987', '654', '321']); // Existing items in watched list
      SharedPreferences.setMockInitialValues({'watchedList': ['987', '654', '321']});

      // Act
      List<int> watchedList = await readWatchedList();

      // Assert
      expect(watchedList, [987, 654, 321]);
    });
  });
}

// Mock SharedPreferences class
class MockSharedPreferences extends Mock implements SharedPreferences {}
