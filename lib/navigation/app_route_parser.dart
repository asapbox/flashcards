import 'package:flutter/material.dart';

import 'app_link.dart';

// AppRouteParser extends RouteInformationParser.
// The type AppLink holds all the route and navigation information.
class AppRouteParser extends RouteInformationParser<AppLink> {
  // The first method you need to override is parseRouteInformation().
  // The route information contains the URL string.
  @override
  Future<AppLink> parseRouteInformation(
      RouteInformation routeInformation) async {
    // Taking the route information and build an instance of AppLink from it.
    final link = AppLink.fromLocation(routeInformation.location);
    return link;
  }

  @override
  RouteInformation restoreRouteInformation(AppLink appLink) {
    // This function passes in an AppLink object.
    // The AppLink gives back the URL string
    final location = appLink.toLocation();
    // wrapping it in RouteInformation to pass it along.
    return RouteInformation(location: location);
  }
}
