class Api {
  static const kApiBaseUrl = 'https://dev.infosparkles.com/pos/api';

  //Token APIs
  static const kTokenUrl = 'https://dev.infosparkles.com/pos/token.php';

  // auth APIs
  static const kLoginUrl = '$kApiBaseUrl/staff_login';
  static const kGetUserProfileData = '$kApiBaseUrl/get_staff_profile';
  static const kGetUpdateProfileData = '$kApiBaseUrl/update_profile';
  static const kChangePasswordUrl = '$kApiBaseUrl/change_password';

  // Check/Order APIs
  static const kAddNewCheck = '$kApiBaseUrl/check/add';
  static const kGetCheckList = '$kApiBaseUrl/get_checks';
  static const kGetCheckDetalList = '$kApiBaseUrl/order_detail';
  static const kGetCheckDetail = '$kApiBaseUrl/get_check';
  static const kUpdateCheck = '$kApiBaseUrl/update_check';
  static const kFilterByNameUrl = '$kApiBaseUrl/get_items_by_menuid';
  static const kmakePayment = '$kApiBaseUrl/pay_with_stripe';

  // Cart APIs
  static const kAddToCartUrl = '$kApiBaseUrl/add_to_cart';
  static const kDeleteFromCartUrl = '$kApiBaseUrl/delete_cart_item';
  static const kUpdateToCartUrl = '$kApiBaseUrl/cart_update';

}
