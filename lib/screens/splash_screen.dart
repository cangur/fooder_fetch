import 'package:flutter/material.dart';
import 'package:fooderfetch/models/app_state_manager.dart';
import '../models/fooder_fetch_pages.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
        name: FooderFetchPages.splashPath,
        key: ValueKey(FooderFetchPages.splashPath),
        child: const SplashScreen());
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              height: 200,
              image: AssetImage('assets/fooder_fetch_assets/splash_logo.png'),
            ),
            const Text('Initializing...')
          ],
        ),
      ),
    );
  }
}
