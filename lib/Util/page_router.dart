import 'package:flutter/material.dart';
import 'package:meeting_scheduler/Calendar/Page/calendarPage.dart';
import 'package:meeting_scheduler/Calendar/Page/createSchedule.dart';

class PageRouter {
  static const String calenderPage = '/calenderPage';
  static const String calenderSchedulePage = '/calenderSchedulePage';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case PageRouter.calenderPage:
        return CustomPageRoute(
          child: const CalenderPage(),
        );

      case PageRouter.calenderSchedulePage:
        return CustomPageRoute(
          child: const CreateSchedule(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) => const CalenderPage());
  }
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  CustomPageRoute({required this.child})
      : super(
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(animation),
        child: child,
      );
}
