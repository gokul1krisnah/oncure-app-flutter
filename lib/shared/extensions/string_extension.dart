import 'package:intl/intl.dart';

import '../../core/networking/dio_config.dart';

extension StringExtension on String {
  String formatUrl() {
    // Early returns for edge cases
    if (isEmpty) return this;

    // Check if already a valid absolute HTTP/HTTPS URL
    if (_isValidAbsoluteUrl()) return this;

    try {
      return _buildAbsoluteUrl();
    } catch (e) {
      return this;
    }
  }

  /// Checks if the string is a valid absolute HTTP/HTTPS URL
  bool _isValidAbsoluteUrl() {
    final uri = Uri.tryParse(this);
    return uri != null && uri.hasScheme && _isHttpScheme(uri.scheme) && uri.host.isNotEmpty;
  }

  /// Checks if the scheme is HTTP or HTTPS (case-insensitive)
  bool _isHttpScheme(String scheme) {
    final lowerScheme = scheme.toLowerCase();
    return lowerScheme == 'http' || lowerScheme == 'https';
  }

  /// Builds absolute URL by combining with base storage URL
  String _buildAbsoluteUrl() {
    final baseUrl = _normalizeBaseUrl(Config.storageUrl);
    final cleanPath = _cleanRelativePath();
    final resolvedUri = Uri.parse(baseUrl).resolve(cleanPath);

    return resolvedUri.toString();
  }

  /// Normalizes base URL by removing trailing slash
  String _normalizeBaseUrl(String url) => url.endsWith('/') ? url.substring(0, url.length - 1) : url;

  /// Cleans relative path by removing leading slash
  String _cleanRelativePath() => startsWith('/') ? substring(1) : this;
}

extension TimeFormatter on String {
  String getWeekdayLabel() {
    final givenDate = DateTime.tryParse(this);
    if (givenDate == null) return '';
    final date = givenDate.toLocal();
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final sunday = now.subtract(Duration(days: now.weekday % 7));
    final saturday = sunday.add(const Duration(days: 6));
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today';
    }
    if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
      return 'Yesterday';
    }

    if (!date.isBefore(sunday) && !date.isAfter(saturday)) {
      return DateFormat('dd EEE').format(date);
    }
    return DateFormat('dd MMM yyyy').format(date);
  }

  bool isToday() {
    final dateTime = DateTime.parse(this).toLocal();
    final now = DateTime.now();

    return dateTime.day == now.day;
  }

  String toTimeAgoOrTime() {
    final dateTime = DateTime.parse(this).toLocal();
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (now.year == dateTime.year && now.month == dateTime.month && now.day == dateTime.day) {
      final hoursAgo = difference.inHours;
      if (hoursAgo >= 1) {
        return '$hoursAgo hours ago';
      } else if (difference.inMinutes >= 1) {
        return '${difference.inMinutes} minutes ago';
      } else {
        return 'Just now';
      }
    } else {
      return DateFormat('hh:mm a').format(dateTime);
    }
  }

  bool isOnSameDay(String? date) {
    final currentDay = DateTime.parse(this).toLocal();
    final prevDay = date == null ? null : DateTime.parse(date).toLocal();

    return currentDay.year == prevDay?.year && currentDay.month == prevDay?.month && currentDay.day == prevDay?.day;
  }
}
