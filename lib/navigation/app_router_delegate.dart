import 'package:flashcards/view_model/flashcard_manager.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/model/model.dart';
import 'package:flashcards/view/screens/screens.dart';
import 'package:provider/provider.dart';

import 'app_link.dart';

class AppRouterDelegate extends RouterDelegate<AppLink>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  NavigationManager navigationManager = NavigationManager();

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    // Navigator defines a stack of MaterialPages in a declarative way.
    // It also handles any onPopPage events
    return Navigator(
      key: navigatorKey,

      // When the user taps the Back button or a system back button event,
      // it fires a helper method, onPopPage. And when it’s called a page pops
      // from the stack
      onPopPage: (
          // This is the current Route, which contains information like RouteSettings to
          // retrieve the route’s name and arguments.
          Route<dynamic> route,
          // result is the value that returns when the route completes.
          result) {
        // Checks if the current route’s pop succeeded.
        if (!route.didPop(result)) {
          // If it failed, return false.
          return false;
        }
        // If the route pop succeeds, this checks the different routes and
        // triggers the appropriate state changes.
        if (route.settings.name == Paths.homeScreenPath) {
          context.read<NavigationManager>().setHomeScreen(false);
        }
        if (route.settings.name == Paths.flashcardsListScreenPath) {
          context.read<NavigationManager>().setFlashcardListScreen(false);
        }
        if (route.settings.name == Paths.editorScreenPath) {
          context.read<NavigationManager>().setEditorScreen(false);
        }
        if (route.settings.name == Paths.detailsScreenPath) {
          context.read<NavigationManager>().setDetailsScreen(false);
        }
        return true;
      },
      pages: [
        if (!context.watch<NavigationManager>().isInitialized) ...[
          SplashScreen.page(),
        ] else ...[
          HomeScreen.page(),
          if (context.watch<NavigationManager>().isFlashcardListScreen)
            FlashcardsListScreen.page(),
          if (context.watch<NavigationManager>().isEditorScreen)
            EditorScreen.page(),
          if (context.watch<NavigationManager>().isDetailsScreen)
            DetailsScreen.page(),
        ]
      ],
    );
  }

  @override
  //checking the app state and returning the right app link configuration
  AppLink get currentConfiguration => getCurrentPath();

  // This is a helper function that converts the app state to an AppLink object.
  AppLink getCurrentPath() {
    if (navigationManager.isFlashcardListScreen) {
      return AppLink(location: AppLink.flashcardsListScreenPath);
    } else if (navigationManager.isEditorScreen) {
      return AppLink(location: AppLink.editorScreenPath);
    } else if (navigationManager.isDetailsScreen) {
      return AppLink(location: AppLink.detailsScreenPath);
    } else {
      return AppLink(location: AppLink.homeScreenPath);
    }
  }

  @override
  Future<void> setNewRoutePath(AppLink newLink) async {
    switch (newLink.location) {
      // 3
      //   case AppLink.profileScreenPath:
      //     profileManager.tapOnProfile(true);
      //     break;
      // 4
      //   case AppLink.detailsScreenPath:
      //     final itemId = newLink.itemId;
      //     // 5
      //     if (itemId != null) {
      //       groceryManager.setSelectedGroceryItem(itemId);
      //     } else {
      //       // 6
      //       groceryManager.createNewItem();
      //     }
      //     // 7
      //     profileManager.tapOnProfile(false);
      //     break;
      // 8

      case AppLink.homeScreenPath:
        navigationManager.setHomeScreen(true);
        navigationManager.setFlashcardListScreen(false);
        //   appStateManager.goToTab(newLink.currentTab ?? 0);
        //   profileManager.tapOnProfile(false);
        //   groceryManager.groceryItemTapped(-1);
        break;

      // need to fix
      case AppLink.detailsScreenPath:
        navigationManager.setDetailsScreen(true);
        navigationManager.setHomeScreen(false);
        break;

      default:
        break;
    }
  }
}
