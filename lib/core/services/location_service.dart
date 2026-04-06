/// A service that provides access to the device's location.
import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:permission_handler/permission_handler.dart';

import '../model/info/location_info/location_info_model.dart';

/// A service that provides access to the device's location.
@injectable
class LocationService {
  final Location _location = Location();

  /// Creates a new instance of the [LocationService].
  LocationService();

  /// Checks if location permission is granted.
  ///
  /// Returns `true` if location permission is granted, `false` otherwise.
  Future<bool> hasPermission() async => Permission.location.status.isGranted;

  /// Requests location permission from the user.
  ///
  /// If the permission is already granted, this method does nothing.
  /// If the permission is permanently denied, it opens the app settings.
  /// Otherwise, it requests the permission.
  Future<void> requestPermission() async {
    final status = await Permission.location.status;

    if (status.isGranted) return;
    if (status.isPermanentlyDenied) {
      // Directly guide to settings (modal won’t appear)
      await openAppSettings();
      return;
    }

    // Otherwise, request — this will trigger system modal
    await Permission.location.request();
  }

  /// Opens the app settings.
  ///
  /// Returns `true` if the settings were successfully opened, `false` otherwise.
  Future<bool> openSettings() async => openAppSettings();

  /// Gets the current location of the device.
  ///
  /// Returns a [LocationInfoHeaderDTO] if the location is available, `null` otherwise.
  Future<LocationInfoHeaderDTO?> getCurrentLocation() async {
    if (!await hasPermission()) {
      return null;
    }
    final location = await _location.getLocation();

    return location.toLocationInfo();
  }
}

/// An extension on [LocationData] to convert it to a [LocationInfoHeaderDTO].
extension LocationDataX on LocationData {
  /// Converts a [LocationData] object to a [LocationInfoHeaderDTO].
  ///
  /// Returns a [LocationInfoHeaderDTO] if the latitude and longitude are not null, `null` otherwise.
  LocationInfoHeaderDTO? toLocationInfo() =>
      latitude != null && longitude != null ? LocationInfoHeaderDTO(latitude: latitude!, longitude: longitude!) : null;
}
