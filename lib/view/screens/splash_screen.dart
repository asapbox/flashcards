import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flashcards/model/model.dart';

class SplashScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: Paths.splashScreenPath,
      key: ValueKey(Paths.splashScreenPath),
      child: SplashScreen(),
    );
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  //The first time the framework builds a widget, it calls didChangeDependencies() after initState().
  void didChangeDependencies() {
    super.didChangeDependencies();
    // switches isInitialized to true
    context.read<NavigationManager>().initializingApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(
              height: 20.0,
            ),
            Text('Initializing...')
          ],
        ),
      ),
    );
  }
}
