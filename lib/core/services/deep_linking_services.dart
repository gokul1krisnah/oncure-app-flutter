import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../routes/app_router.dart';
import '../routes/app_router.gr.dart';

@lazySingleton
class DeepLinkService {
  final AppRouter _router;
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  DeepLinkService(this._router);

  /// Initialize deep link listeners
  Future<void> init() async {
    // Handle initial link when app is launched from closed state
    await _handleInitialLink();

    // Handle links when app is already running
    _handleIncomingLinks();
  }

  /// Handle the initial link that launched the app
  Future<void> _handleInitialLink() async {
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        Logger().i('App launched with deep link: $initialUri');
        await _handleDeepLink(initialUri);
      }
    } catch (e) {
      Logger().e('Error getting initial link: $e');
    }
  }

  /// Listen for incoming links while app is running
  void _handleIncomingLinks() {
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (Uri uri) async {
        Logger().i('Received deep link while app running: $uri');
        await _handleDeepLink(uri);
      },
      onError: (Object err) {
        Logger().e('Error listening to deep links: $err');
      },
    );
  }

  /// Process and route deep links
  Future<void> _handleDeepLink(Uri uri) async {
    Logger().i('Processing deep link: $uri');
    Logger().i('Scheme: ${uri.scheme}');
    Logger().i('Host: ${uri.host}');
    Logger().i('Path: ${uri.path}');
    Logger().i('Query params: ${uri.queryParameters}');

    try {
      // Route based on path
      await _routeDeepLink(uri);
    } catch (e) {
      Logger().e('Error handling deep link: $e');
      // Navigate to error page or show dialog
      await _router.navigatePath('/error');
    }
  }

  /// Route to appropriate screen based on URI
  Future<void> _routeDeepLink(Uri uri) async {
    final path = uri.path;
    // final queryParams = uri.queryParameters;

    // Example: /store-details/store123
    if (path.startsWith('/product/')) {
      final productId = path.split('/').last;
      if (productId.isNotEmpty) {
        // await _router.push(ProductRoute(id: productId));
        return;
      }
    }

    // Example: /product/prod456?ref=email
    // if (path.startsWith('/product/')) {
    //   final productId = path.split('/').last;
    //   final referrer = queryParams['ref'];
    //   if (productId.isNotEmpty) {
    //     await _router.push(
    //       ProductRoute(
    //         id: productId,
    //         referrer: referrer,
    //       ),
    //     );
    //     return;
    //   }
    // }

    // Example: /profile/user789
    // if (path.startsWith('/profile/')) {
    //   final userId = path.split('/').last;
    //   if (userId.isNotEmpty) {
    //     await _router.push(ProfileRoute(userId: userId));
    //     return;
    //   }
    // }

    // Default: navigate to path directly
    await _router.replaceAll([const HomeRoute()]);
  }

  /// Dispose resources
  void dispose() {
    _linkSubscription?.cancel();
  }
}
