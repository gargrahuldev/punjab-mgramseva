import 'package:mgramseva/icons/home_icons_icons.dart';
import 'package:mgramseva/icons/home_icons_modified_icons.dart';
import 'package:mgramseva/routers/Routers.dart';
import 'package:mgramseva/utils/Constants/I18KeyConstants.dart';
import 'package:mgramseva/utils/models.dart';

class Constants {
  static const int PAGINATION_LIMIT = 75;

  static const String LOGIN_KEY = 'login_key';
  static const String LANGUAGE_KEY = 'language_key';
  static const String STATES_KEY = 'states_key';

  static List<KeyValue> GENDER = [
    KeyValue('CORE_COMMON_GENDER_MALE', 'MALE'),
    KeyValue('CORE_COMMON_GENDER_FEMALE', 'FEMALE'),
    KeyValue('CORE_COMMON_GENDER_TRANSGENDER', 'TRANSGENDER'),
  ];

  static List<KeyValue> EXPENSESTYPE = [
    KeyValue(i18.common.YES, true),
    KeyValue(i18.common.NO, false),
  ];
  static List<KeyValue> AMOUNTTYPE = [
    KeyValue('FULL', 'Full'),
    KeyValue('PARTIAL', 'Partial'),
  ];

  static const List<HomeItem> HOME_ITEMS = [
    HomeItem("CORE_HOUSEHOLD_REGISTER", HomeIcons.hhregister, '', {}),
    HomeItem("CORE_COLLECT_PAYMENTS", HomeIcons.collectpayment,
        Routes.HOUSEHOLD, {'Mode': "collect"}),
    HomeItem("DOWNLOAD_BILLS_AND_RECEIPTS", HomeIcons.printreciept, '', {}),
    HomeItem(
        "ADD_EXPENSES_RECORD", HomeIconsModified.vector_1, Routes.EXPENSES_ADD, {}),
    HomeItem("CORE_UPDATE_EXPENSES", HomeIconsModified.vector,
        Routes.EXPENSE_SEARCH, {}),
    HomeItem(
        "CORE_GENERATE_DEMAND", HomeIcons.generaedemand, Routes.MANUAL_BILL_GENERATE, {}),
    HomeItem("CORE_CONSUMER_CREATE", HomeIcons.createconsumer,
        Routes.CONSUMER_CREATE, {}),
    HomeItem("CORE_UPDATE_CONSUMER_DETAILS", HomeIcons.updateconsumer,
        'consumer/search', {'Mode': "update"}),
    HomeItem("CORE_GPWSC_DASHBOARD", HomeIcons.dashboard, 'dashboard', {}),
  ];

  static List<KeyValue> SERVICECATEGORY = [
    KeyValue("Billing Service", "BILLING SERVICE"),
    KeyValue("Property Service", "PROPERTY SERVICE"),
    KeyValue("Rental Service", "RENTAL SERVICE"),
  ];

  static List<KeyValue> PROPERTYTYPE = [
    KeyValue("Residential", "RESIDENTIAL"),
    KeyValue("Non Residential", "NON RESIDENTIAL"),
  ];

  static List<KeyValue> PAYMENT_AMOUNT = [
    KeyValue(i18.common.FULL_AMOUNT, 'fullAmount'),
    KeyValue(i18.common.CUSTOM_AMOUNT, 'customAmount'),
  ];

  static List<KeyValue> PAYMENT_METHOD = [
    KeyValue(i18.common.ONLINE, 'ONLINE'),
    KeyValue(i18.common.CHEQUE, 'CHEQUE'),
    KeyValue(i18.common.CASH, 'CASH'),
  ];
}