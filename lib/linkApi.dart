class AppiLink {
  // Use 10.0.2.2 for Android emulator to connect to localhost
  static const String server = "http://10.0.2.2/ramzi";
  // Or use your actual IP address for real device
  // static const String server = "http://192.168.1.100/ramzi";

  static const String test = "$server/test.php";


  //======================== image ========================

  static const String imageStatic = "http://10.0.2.2/ramzi/upload";
  static const String imageCategories = "$imageStatic/categories";
  static const String imageItems = "$imageStatic/items";

  //========================== auth ==================================
  static const String signUp = "$server/auth/signUp.php";
  static const String verify_code = "$server/auth/verify_code.php";
  static const String login = "$server/auth/login.php";
  static const String check_email = "$server/forget_password/check_email.php";
  static const String verify_code_forget = "$server/forget_password/verify_code.php";
  static const String reset_password = "$server/forget_password/reset_password.php";


  //================= home page ===========================
  static const String homePage = "$server/home.php";

  //===================items========================
  static const String items = "$server/items/items.php";
  static const String search = "$server/items/search.php";



  // ==================favorite====




  static const String add_favorite = "$server/favorite/add_favorite.php";
  static const String remove_favorite = "$server/favorite/remove_favorite.php";
  static const String myfavorite = "$server/favorite/view.php";
  static const String deleteFavoriteItems = "$server/favorite/deleteFavoriteItems.php";

  //===================cart========================
  static const String cartAdd = "$server/cart/add_cart.php";
  static const String cartRemove = "$server/cart/remove_cart.php";
  static const String cartView = "$server/cart/view.php";
  static const String cartCount = "$server/cart/get_countItem.php";
  static const String updateCountItems = "$server/cart/get_countItem.php";

// =====================sddress===========
  static const String addressAdd = "$server/address/add.php";
  static const String addressEdit = "$server/address/edit.php";
  static const String addressView = "$server/address/view.php";
  static const String addressDelete = "$server/address/delete.php";


  static const String coupon = "$server/coupon/checkcoupon.php";


  static const String checkout = "$server/orders/checkout.php";







}



