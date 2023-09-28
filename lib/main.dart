import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meeting_scheduler/Util/page_router.dart';
import 'package:meeting_scheduler/Util/palette.dart';
import 'package:meeting_scheduler/Util/sizing.dart';

final nav = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        Sizing().init(constraints, orientation);
        return MaterialApp(
          theme: ThemeData.light().copyWith(
            primaryColor: primaryColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          navigatorKey: nav,
          debugShowCheckedModeBanner: false,
          initialRoute: PageRouter.calenderPage,
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      });
    });
  }
}
