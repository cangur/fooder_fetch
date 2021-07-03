import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'fooder_fetch_theme.dart';
import 'package:provider/provider.dart';
import 'models/app_state_manager.dart';
import 'models/grocery_manager.dart';
import 'models/profile_manager.dart';
import 'navigation/app_route_parser.dart';
import 'navigation/app_router.dart';

Future<void> main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FooderFetch());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class FooderFetch extends StatefulWidget {
  const FooderFetch({Key? key}) : super(key: key);

  @override
  _FooderFetchState createState() => _FooderFetchState();
}

class _FooderFetchState extends State<FooderFetch> {
  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  final _appStateManager = AppStateManager();
  final routeParser = AppRouteParser();
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
        appStateManager: _appStateManager,
        groceryManager: _groceryManager,
        profileManager: _profileManager);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => _groceryManager),
          ChangeNotifierProvider(
            create: (context) => _appStateManager,
          ),
          ChangeNotifierProvider(
            create: (context) => _profileManager,
          )
        ],
        child: Consumer<ProfileManager>(
          builder: (context, profileManager, child) {
            ThemeData theme;
            if (profileManager.darkMode) {
              theme = FooderFetchTheme.dark();
            } else {
              theme = FooderFetchTheme.light();
            }

            return MaterialApp.router(
              theme: theme,
              title: 'FooderFetch',
              backButtonDispatcher: RootBackButtonDispatcher(),
              routeInformationParser: routeParser,
              routerDelegate: _appRouter,
            );
          }
        )
      );
  }
}
