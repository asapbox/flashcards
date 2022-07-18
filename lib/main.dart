import 'package:flashcards/persistence/persistence_manager.dart';
import 'package:flashcards/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:flashcards/navigation/navigation.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<FlashcardManager>(
        create: (context) => FlashcardManager(),
      ),
      ChangeNotifierProvider<ProfileManager>(
        create: (context) => ProfileManager(),
      ),
      ChangeNotifierProvider<NavigationManager>(
        create: (context) => NavigationManager(),
      ),
      ChangeNotifierProvider<PersistenceManager>(
        create: (context) => PersistenceManager(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // delete
  // final ThemeData appTheme = AppTheme.dark();
  final AppRouterDelegate _appRouterDelegate = AppRouterDelegate();
  final routeParser = AppRouteParser();

  @override
  Widget build(BuildContext context) {
    // Router is a widget that extends RouterDelegate.
    // The router ensures that the messages are passed to RouterDelegate
    return MaterialApp.router(
      theme: (context.watch<ProfileManager>().isDarkMode)
          ? AppTheme.dark()
          : AppTheme.light(),
      title: 'Flashcards',
      // BackButtonDispatcher handles platform-specific system back button
      // presses. It listens to requests by the OS and notifies the router
      // delegate to pop a route.
      backButtonDispatcher: RootBackButtonDispatcher(),
      // The route information parser converts the app state to and from
      // a URL string
      routeInformationParser: routeParser,
      // routerDelegate constructs the stack of pages that represents
      // the app state.
      routerDelegate: _appRouterDelegate,
    );
  }
}
