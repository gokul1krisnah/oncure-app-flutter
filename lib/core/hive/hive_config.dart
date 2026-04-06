import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'hive_adapter.dart';

// The key used to store the Hive encryption key in secure storage.
const String _hiveEncryptionKeyName = 'hive-encryption-key';

/// A utility class for configuring the Hive local database.
///
/// This class handles the initialization of Hive and the management of its
/// encryption key.
abstract class HiveConfig {
  /// Initializes the Hive database.
  ///
  /// This must be called before any Hive boxes can be opened.
  static Future<void> init() async {
    // Initialize Hive with a specific directory in the app's documents directory.
    await Hive.initFlutter();
    // Register all necessary type adapters.
    HiveAdapter.register();
  }

  /// Retrieves or generates the encryption key for Hive boxes.
  ///
  /// This method securely stores the encryption key on the device using
  /// `flutter_secure_storage`. If a key already exists, it retrieves and uses it.
  /// If not, it generates a new one, saves it, and then returns it.
  static Future<HiveAesCipher> getEncryptionKey() async {
    // Use encrypted shared preferences on Android for added security.
    const androidOptions = AndroidOptions(encryptedSharedPreferences: true);
    const secureStorage = FlutterSecureStorage(aOptions: androidOptions);

    try {
      // Attempt to read the existing key from secure storage.
      final keyString = await secureStorage.read(key: _hiveEncryptionKeyName);

      if (keyString != null) {
        // If the key exists, decode it and return the cipher.
        final key = base64Url.decode(keyString);
        return HiveAesCipher(key);
      }
    } catch (e, s) {
      // If reading or decoding the key fails, log the error and proceed to
      // generate a new key. This can happen if the stored key is corrupted.
      dev.log('Failed to get or decode encryption key', name: 'HiveConfig Error', error: e, stackTrace: s);
    }

    // If no key exists or reading it failed, generate a new secure key.
    final newKey = Hive.generateSecureKey();
    // Encode the key in a URL-safe format.
    final encodedKey = base64UrlEncode(newKey);

    // Write the new key to secure storage for future use.
    await secureStorage.write(key: _hiveEncryptionKeyName, value: encodedKey);

    // Return the new key as a HiveAesCipher.
    return HiveAesCipher(newKey);
  }
}
