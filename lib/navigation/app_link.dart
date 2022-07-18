class AppLink {
  static const String splashScreenPath = '/splash';
  static const String homeScreenPath = '/home';
  static const String flashcardsListScreenPath = '/flashcards';
  static const String editorScreenPath = '/editor';
  static const String detailsScreenPath = '/details';

  // Creating constants for each of the query parameters you’ll support.
  static const String tabParam = 'tab';
  static const String idParam = 'id';

  // Storing the path of the URL using location.
  String? location;

  // Using currentTab to store the tab you want to redirect a user to.
  int? currentTab;

  // Storing the ID of the item you want to view in itemId.
  String? itemId;

  // Instantiating the app link with the location and the two query parameters.
  AppLink({
    this.location,
    this.currentTab,
    this.itemId,
  });

  // Converting a URL string to an AppLink
  static AppLink fromLocation(String? location) {
    // decoding the URL
    location = Uri.decodeFull(location ?? '');
    // generic form of any URI scheme is
    // [//[user:password@]host[:port]][/]path[?query][#fragment]
    // Parsing the URI for query parameter keys and key-value pairs.
    final uri = Uri.parse(location);
    final params = uri.queryParameters;
    // Extracting the currentTab from the URL path if it exists.
    final currentTab = int.tryParse(params[AppLink.tabParam] ?? '');
    // Extracting the itemId from the URL path if it exists.
    final itemId = params[AppLink.idParam];
    // Creating the AppLink by passing in the query parameters you extract
    // from the URL string.
    final link = AppLink(
      location: uri.path,
      currentTab: currentTab,
      itemId: itemId,
    );
    return link;
  }

  // Converting an AppLink to a URL string
  String toLocation() {
    // Creating an internal function that formats the query parameter key-value
    // pair into a string format.
    String addKeyValPair({required String key, String? value}) {
      return value == null ? '' : '$key=$value&';
    }

    switch (location) {
      case flashcardsListScreenPath:
        return flashcardsListScreenPath;
      // return the right string path: /details, and if there are any
      // parameters, append ?id=${id}.
      case detailsScreenPath:
        var loc = '$detailsScreenPath?';
        loc += addKeyValPair(
          key: idParam,
          value: itemId,
        );
        return Uri.encodeFull(loc);
      // If the path is invalid, default to the path /home.
      // If the user selected a tab, append ?tab=${tabIndex}.
      default:
        var loc = '$homeScreenPath?';
        loc += addKeyValPair(
          key: tabParam,
          value: currentTab.toString(),
        );
        return Uri.encodeFull(loc);
    }
  }
}
