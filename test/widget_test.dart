import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_basics_lab/profile_card.dart';

void main() {
  testWidgets('Profile card shows', (WidgetTester tester) async {
    await tester.pumpWidget(const ProfileApp());

    expect(find.byType(ProfileCard), findsOneWidget);
    expect(find.text('BS Information Technology'), findsOneWidget);
  });
}