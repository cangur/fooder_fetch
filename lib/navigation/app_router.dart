import 'package:flutter/material.dart';
import '../models/app_state_manager.dart';
import '../models/fooder_fetch_pages.dart';
import '../models/grocery_item.dart';
import '../models/grocery_manager.dart';
import '../models/profile_manager.dart';
import '../screens/screens.dart';
import 'app_link.dart';

class AppRouter extends RouterDelegate<AppLink>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;
  final GroceryManager groceryManager;
  final ProfileManager profileManager;

  final GroceryItem groceryItem = GroceryItem(
      id: '',
      name: 'name',
      importance: Importance.high,
      color: Colors.grey,
      quantity: 0,
      date: DateTime(0));

  AppRouter(
      {required this.appStateManager,
      required this.groceryManager,
      required this.profileManager})
      : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appStateManager.isInitialized) ...[
          SplashScreen.page(),
        ] else if (!appStateManager.isLoggedIn) ...[
          LoginScreen.page(),
        ] else if (!appStateManager.isOnboardingComplete) ...[
          OnboardingScreen.page(),
        ] else ...[
          Home.page(appStateManager.getSelectedTab),
          if (groceryManager.isCreatingNewItem)
            GroceryItemScreen.page(
                onCreate: (item) {
                  groceryManager.addItem(item);
                },
                item: groceryItem,
                onUpdate: (GroceryItem, int) {},
                index: 0),
          if (groceryManager.selectedIndex != null)
            GroceryItemScreen.page(
                item: groceryManager.selectedGroceryItem!,
                index: groceryManager.selectedIndex!,
                onUpdate: (item, index) {
                  groceryManager.updateItem(item, index);
                },
                onCreate: (GroceryItem) {}),
          if (profileManager.didSelectUser)
            ProfileScreen.page(profileManager.getUser),
          if (profileManager.didTapOnYeditepe)
            WebViewScreen.page(
              'https://www.yeditepe.edu.tr',
              'yeditepe.edu.tr',
            ),
        ]
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == FooderFetchPages.onboardingPath) {
      appStateManager.logout();
    }
    if (route.settings.name == FooderFetchPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(0);
    }

    if (route.settings.name == FooderFetchPages.profilePath) {
      profileManager.tapOnProfile(false);
    }

    if (route.settings.name == FooderFetchPages.yeditepe) {
      profileManager.tapOnYeditepe(false);
    }

    return true;
  }

  @override
  AppLink get currentConfiguration => getCurrentPath();

  AppLink getCurrentPath() {
    if (!appStateManager.isLoggedIn) {
      return AppLink(location: AppLink.kLoginPath);
    } else if (!appStateManager.isOnboardingComplete) {
      return AppLink(location: AppLink.kOnboardingPath);
    } else if (profileManager.didSelectUser) {
      return AppLink(location: AppLink.kProfilePath);
    } else if (groceryManager.isCreatingNewItem) {
      return AppLink(location: AppLink.kItemPath);
    } else if (groceryManager.selectedGroceryItem != null) {
      final id = groceryManager.selectedGroceryItem?.id;
      return AppLink(location: AppLink.kItemPath, itemId: id!);
    } else {
      return AppLink(
          location: AppLink.kHomePath,
          currentTab: appStateManager.getSelectedTab);
    }
  }

  @override
  Future<void> setNewRoutePath(AppLink newLink) async {
    switch (newLink.location) {
      case AppLink.kProfilePath:
        profileManager.tapOnProfile(true);
        break;
      case AppLink.kItemPath:
        if (newLink.itemId != null) {
          groceryManager.setSelectedGroceryItem(newLink.itemId);
        } else {
          groceryManager.createNewItem();
        }
        profileManager.tapOnProfile(false);
        break;
      case AppLink.kHomePath:
        appStateManager.goToTab(newLink.currentTab);
        profileManager.tapOnProfile(false);
        groceryManager.groceryItemTapped(0);
        break;
      default:
        break;
    }
  }
}
