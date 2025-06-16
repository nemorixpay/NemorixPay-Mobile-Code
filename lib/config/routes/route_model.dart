import 'package:flutter/material.dart';

/// @file        route_model.dart
/// @brief       Model class for route configuration in NemorixPay.
/// @details     This class defines the structure for route configuration,
///             including the route name, screen widget, and display icon.
/// @author      Miguel Fagundez
/// @date        2025-04-28
/// @version     1.0
/// @copyright   Apache 2.0 License
class RouteModel {
  /// The unique identifier for the route
  final String route;

  /// The display name of the route
  final String name;

  /// The screen widget associated with this route
  final Widget screen;

  /// The icon to display for this route in navigation elements
  final IconData icon;

  /// Creates a new route model with the specified properties
  ///
  /// @param route The unique identifier for the route
  /// @param name The display name of the route
  /// @param screen The screen widget to display
  /// @param icon The icon to use in navigation elements
  RouteModel({
    required this.route,
    required this.name,
    required this.screen,
    required this.icon,
  });
}
