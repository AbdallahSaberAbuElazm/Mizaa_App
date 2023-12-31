class ApiConstants {
  static const baseUrl = "http://ahmedbahgat2010-002-site2.btempurl.com/api/";
  static const storageURL = "http://ahmedbahgat2010-002-site3.btempurl.com/";
  static const String registerUrl = "${baseUrl}Auth/register";
  static const String otpLoginUrl = "${baseUrl}Auth/Login";
  static const String getUserBasicInfo = "${baseUrl}Auth/getUserData/"; // phone number
  static const String verifyOTPUrl = "${baseUrl}Auth/checkOtp/";
  static const String recoveryOtpUrl = "${baseUrl}Auth/ForgetPasswordOtp/";
  static const String recoveryUrl = "${baseUrl}Auth/forgetPassword/";
  static const String updateUserData = '${baseUrl}User/updateUserData';
  static const String resetPassword = '${baseUrl}User/resetPassword';
  static const String getDeviceToken = '${baseUrl}Auth/addDeviceToken/'; // user token
  static const String countryUrl = "${baseUrl}LookUp/GetAllCountries";
  static const String cityUrl = "${baseUrl}LookUp/GetCitiesByCountryId/";
  static const mainCategoryUrl = "${baseUrl}LookUp/GetMainCateguries";
  static const subCategoriesByCatIdUrl =
      "${baseUrl}LookUp/GetSubCateguriesByCatId/"; // 1
  static const offerDetailsByOfferKeyUrl =
      "${baseUrl}Offers/GetOfferDetails/"; // 592ab5dc-fc93-45fb-88ac-8973a9364a35/TOKEN/01501589559
  static const offersByMainCategoryIdUrl =
      "${baseUrl}Offers/GetOffersByMainCatId/"; // 1/1
  static const offersBySubCategoryIdUrl =
      "${baseUrl}Offers/GetOffersBySubCatId/"; // 1/1
  static const carouselHomePageOfferByCityUrl =
      '${baseUrl}Offers/GetHomePageOffersWithCityId/'; // 1
  static const todayOfferByCityUrl =
      '${baseUrl}Offers/GetTodayOffersWithCityId/'; // 1
  static const specialOfferByCityUrl =
      '${baseUrl}Offers/GetSpecialOffersWithCityId/'; // 1
  static const mostSalesOfferByCityUrl =
      '${baseUrl}Offers/GetMostSalesOffersWithCityId/'; // 1
  static const newOfferByCityUrl =
      '${baseUrl}Offers/GetNewOffersWithCityId/'; // 1

  static const nearestOffersUrl = '${baseUrl}/Offers/GetNearestOffers'; //post

  static const offerRateUrl =
      '${baseUrl}Rating/GetOfferRate/'; // 1
  static const addRateToOffer = '${baseUrl}Rating/AddRateToOffer';
  static const checkIfUserRateBefore = '${baseUrl}Rating/CheckIfUserRatedBefor';
  static const companiesByCityIdAndCatId = '${baseUrl}LookUp/GetAllCompaniesByCityIdAndCatId/'; //1/1
  static const getMerchantById = '${baseUrl}Sellers/GetSellersById/'; // merchant key
  static const getCompanyBranches = '${baseUrl}Sellers/GetSellerBrunches/'; // company key / city id
  static const offersForCompanyByCompanyId = '';
  static const searchOffersOrSellersInCity = '${baseUrl}Search/OffersOrSellers';
  static const searchOffersInMainCategory = '${baseUrl}Search/OffersInMainCat';
  static const searchOffersInSubCategory = '${baseUrl}OffersInSubCat';
  static const getAllCompaniesByCityIdAndCatId = '${baseUrl}GetAllCompaniesByCityIdAndCatId/';
  static const findMerchant = '${baseUrl}Search/FindSellers';
  static const addToCart = '${baseUrl}Cart/AddToCard';
  static const getCartByUserMobile = '${baseUrl}Cart/GetCartByUserMobile/'; // phone number
  static const deleteCartItem = '${baseUrl}Cart/RemoveItemFromCart/'; // itemid
  static const deleteSpecificCart = '${baseUrl}Cart/ClearCart/'; //phone number
  static const updateCartItem = '${baseUrl}Cart/UpdateItemOnCart/'; // itemid / count
  static const userWallet = '${baseUrl}User/getUserWalletData/'; // phone number
  static const validateOrderData = '${baseUrl}Order/ValidatOrderData';
  static const makeOrder = '${baseUrl}Order/MakeOrder/'; // order key
  static const getUserOrders = '${baseUrl}Order/UserOrders/'; // user application id
  static const addToFavourite = '${baseUrl}Favourite/AddToFavourite';
  static const getFavouriteByMobile = '${baseUrl}Favourite/GetFavouriteByUserMobile/'; // phone number
  static const deleteFromFavourite = '${baseUrl}Favourite/DeleteFromFavourite/'; // favourite key

}

