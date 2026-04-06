abstract class EndPoints {
  /// PUBLIC
  static const String init = 'init'; // GET
  static const String countries = 'countries'; //GET

  /// AUTH
  static const String saveFcmToken = 'fcm-token'; // POST
  static const String sendOtp = '/customer/send-otp'; // POST
  static const String verifyOtp = '/customer/verify-otp'; // POST
  static const String register = '/customer/register'; //POST

  /// PROFILE
  static const String editProfile = 'customer/edit-profile';
  static const String changePhoneSendOtp = 'customer/change-phone/send-otp';
  static const String changePhoneVerifyOtp = 'customer/change-phone/verify-otp';
  static const String deleteAccount = 'customer/delete-account';
  static const String logout = 'logout';

  /// HOME
  static const String home = 'home'; // GET
  static const String bannerAnalysis = '/banner-view'; // POST
  static const String categoryAnalysis = '/category-view'; // POST

  /// STORES
  static const String allStores = 'stores'; // GET
  static const String store = 'store'; // GET
  static const String offerView = '/offer-view'; // GET
  static const String categories = 'store/categories'; // GET
  static const String reviews = 'reviews/{id}'; // GET
  static const String offers = 'store/offers/{id}'; // GET
  static const String addReview = 'reviews'; // POST

  /// FAVOURITES
  static const String favourites = 'favorites'; // GET
  static const String addRemoveFavourites = 'favorite'; // POST

  /// STORE LISTING
  static const String enquiries = 'enquiries'; // POST
  static const String storeListingCategories = 'enquiries/categories'; // GET

  /// NOTIFICATIONS
  static const String notification = 'notifications'; //GET
}
