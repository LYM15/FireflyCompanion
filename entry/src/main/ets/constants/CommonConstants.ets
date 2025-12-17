// /**
//  * Common constants for all features.
//  */
// export default class CommonConstants {
//   /**
//    * The main ability tag.
//    */
//   static readonly TAG_ABILITY: string = 'EntryAbility';
//
//   /**
//    * 登录页.
//    */
//   static readonly TAG_LOGIN_PAGE: string = 'LoginPage';
//
//   /**
//    * 主页面.
//    */
//   static readonly TAG_MAIN_PAGE: string = 'MainPage';
//
//   /**
//    * 创建订单页面.
//    */
//   static readonly TAG_CREATE_ORDER_PAGE: string = 'CreateOrderPage';
//
//   /**
//    * 订单详情.
//    */
//   static readonly TAG_ORDER_DEC_PAGE: string = 'OrderDecPage';
//
//
//
//
//   /**
//    * The common utils tag.
//    */
//   static readonly TAG_COMMON_UTILS: string = 'CommonUtils';
//
//   /**
//    * The mine page list item cell tag.
//    */
//   static readonly TAG_LIST_ITEM: string = 'ListItem';
//
//   /**
//    * The mine page tag.
//    */
//   static readonly TAG_MINE_PAGE: string = 'MinePage';
//
//   /**
//    * Login text.
//    */
//   static readonly LOGIN_TEXT: string = 'login';
//
//   /**
//    * Toast duration.
//    */
//   static readonly TOAST_DURATION: number = 3000;
//
//   /**
//    * Home tab index.
//    */
//   static readonly HOME_TAB_INDEX: number = 0;
//
//
//   /**
//    * serverList tab index.
//    */
//   static readonly SERVICE_TAB_INDEX: number = 1;
//
//   /**
//    * OrderList tab index.
//    */
//   static readonly ORDER_TAB_INDEX: number = 2;
//
//
//   /**
//    * Mine tab index.
//    */
//   static readonly MINE_TAB_INDEX: number = 3;
//
//   /**
//    * Swiper cache count of the number 3.
//    */
//   static readonly SWIPER_CACHE_COUNT: number = 3;
//
//   /**
//    * Main page url.
//    */
//   static readonly MAIN_PAGE_URL: string = 'pages/MainPage';
//
//   /**
//    * Login page url.
//    */
//   static readonly LOGIN_PAGE_URL: string = 'pages/LoginPage';
//
//   /**
//    * Break point sm of the tag.
//    */
//   static readonly SM: string = 'sm';
//
//   /**
//    * Break point md of the tag.
//    */
//   static readonly MD: string = 'md';
//
//   /**
//    * Break point lg of the tag.
//    */
//   static readonly LG: string = 'lg';
//
//   /**
//    * Width condition sm filter.
//    */
//   static readonly WIDTH_CONDITION_SM: string = '(320vp<=width<520vp)';
//
//   /**
//    * Width condition md filter.
//    */
//   static readonly WIDTH_CONDITION_MD: string = '(520vp<=width<840vp)';
//
//   /**
//    * Width condition lg filter.
//    */
//   static readonly WIDTH_CONDITION_LG: string = '(840vp<=width)';
//
//   /**
//    * Login page button id.
//    */
//   static readonly LOGIN_BUTTON_ID: string = 'loginButtonId';
//
//   /**
//    * Tablet device type.
//    */
//   static readonly TABLET_DEVICE_TYPE: string = 'tablet';
//
//   /**
//    * Divider strokeWidth.
//    */
//   static readonly STROKE_WIDTH: number = 2;
//
//   /**
//    * Animation duration.
//    */
//   static readonly ANIMATION_DURATION: number = 300;
//
// }
//




/**
 * Common constants for all features.
 */
export default class CommonConstants {
  /**
   * The main ability tag.
   */
  static readonly TAG_ABILITY: string = 'EntryAbility';

  /**
   * 登录页.
   */
  static readonly TAG_LOGIN_PAGE: string = 'LoginPage';

  /**
   * 主页面.
   */
  static readonly TAG_MAIN_PAGE: string = 'MainPage';

  /**
   * 创建订单页面.
   */
  static readonly TAG_CREATE_ORDER_PAGE: string = 'CreateOrderPage';

  /**
   * 订单详情.
   */
  static readonly TAG_ORDER_DEC_PAGE: string = 'OrderDecPage';

  /**
   * The common utils tag.
   */
  static readonly TAG_COMMON_UTILS: string = 'CommonUtils';

  /**
   * The mine page list item cell tag.
   */
  static readonly TAG_LIST_ITEM: string = 'ListItem';

  /**
   * The mine page tag.
   */
  static readonly TAG_MINE_PAGE: string = 'MinePage';

  /**
   * Login text.
   */
  static readonly LOGIN_TEXT: string = 'login';

  /**
   * Toast duration.
   */
  static readonly TOAST_DURATION: number = 3000;

  /**
   * Home tab index.
   */
  static readonly HOME_TAB_INDEX: number = 0;

  /**
   * serverList tab index.
   */
  static readonly SERVICE_TAB_INDEX: number = 1;

  /**
   * OrderList tab index.
   */
  static readonly ORDER_TAB_INDEX: number = 2;

  /**
   * Mine tab index.
   */
  static readonly MINE_TAB_INDEX: number = 3;

  /**
   * Swiper cache count of the number 3.
   */
  static readonly SWIPER_CACHE_COUNT: number = 3;

  /**
   * Main page url.
   */
  static readonly MAIN_PAGE_URL: string = 'pages/MainPage';

  /**
   * Login page url.
   */
  static readonly LOGIN_PAGE_URL: string = 'pages/LoginPage';

  /**
   * Break point sm of the tag.
   */
  static readonly SM: string = 'sm';

  /**
   * Break point md of the tag.
   */
  static readonly MD: string = 'md';

  /**
   * Break point lg of the tag.
   */
  static readonly LG: string = 'lg';

  /**
   * Width condition sm filter.
   */
  static readonly WIDTH_CONDITION_SM: string = '(320vp<=width<520vp)';

  /**
   * Width condition md filter.
   */
  static readonly WIDTH_CONDITION_MD: string = '(520vp<=width<840vp)';

  /**
   * Width condition lg filter.
   */
  static readonly WIDTH_CONDITION_LG: string = '(840vp<=width)';

  /**
   * Login page button id.
   */
  static readonly LOGIN_BUTTON_ID: string = 'loginButtonId';

  /**
   * Tablet device type.
   */
  static readonly TABLET_DEVICE_TYPE: string = 'tablet';

  /**
   * Divider strokeWidth.
   */
  static readonly STROKE_WIDTH: number = 2;

  /**
   * Animation duration.
   */
  static readonly ANIMATION_DURATION: number = 300;

  // 注册页面相关常量 - 添加到现有的类中
  static readonly REGISTER_BUTTON_ID: string = 'register_button';

  // 添加注册相关常量
  static readonly MIN_ACCOUNT_LENGTH: number = 3;
  static readonly MIN_PASSWORD_LENGTH: number = 6;

  // 如果需要，可以添加注册页面URL
  static readonly REGISTER_PAGE_URL: string = 'pages/RegisterPage';
}