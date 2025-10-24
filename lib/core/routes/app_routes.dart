import 'package:flutter/material.dart';



class AppRoutes {
  late GlobalKey<NavigatorState> navigationKey;

  // Singleton instance of AppRoutes
  
  static AppRoutes instance = AppRoutes();

  AppRoutes() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  
  // Method to get the current context from the navigation key
  goToScreen(Widget screen) {
    return navigationKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => screen,
        //metadata used for debugging purposes
        // This will help in identifying the screen in the navigation stack
        // and can be useful for logging or debugging.
        // It is not necessary for the functionality of the navigation.
        // It is a good practice to provide a name for the route,
        settings: RouteSettings(name: screen.toStringShort()),
      ),
    );
  }

  Future<void> goToReplacement(Widget screen) {
    return navigationKey.currentState!.pushReplacement(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  goBack() {
    return navigationKey.currentState!.pop();
  }
}