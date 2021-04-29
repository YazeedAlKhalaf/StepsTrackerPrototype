// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "validators": {
    "first": "الإسم الأول",
    "last": "الإسم الأخير",
    "less_characters": "{field} يجب أن يكون أقل من {characters} حرفًا.",
    "more_characters": "{field} يجب أن يكون أكثر من {characters} حرف.",
    "cant_empty": "لا يمكن أن يكون {field} فارغًا.",
    "must_be": "{field} يجب أن يتكون من {characters} حرفًا.",
    "not_correct": "{field} غير صحيح.",
    "phone_number": "رقم الجوال",
    "verification_code": "كود التأكيد"
  },
  "error_service": {
    "unknown": "هناك خطأ ما! الرجاء معاودة المحاولة في وقت لاحق.",
    "invalid_verification_id": "معرف التحقق غير صالح.",
    "invalid_verification_code": "رمز التحقق غير صالح.",
    "user_disabled": "حسابك مغلق."
  },
  "views": {
    "account": {
      "welcome": "مرحبًا {name}،",
      "sign_out": "تسجيل خروج",
      "edit_profile": "تعديل الملف الشخصي",
      "transaction_history": "سجل المعاملات",
      "settings": "الإعدادات"
    },
    "edit_profile": {
      "edit_profile": "تعديل الملف الشخصي",
      "change_profile_image": "تغيير الصورة",
      "first_name": "الإسم الأول",
      "last_name": "الإسم الأخير",
      "update_profile": "تحديث الحساب"
    },
    "history": {
      "history": "السجل",
      "no_history": "عفوا! يبدو أن سجلك فارغ! 😢",
      "reward_null_title": "{sign} {amount} نقاط صحة",
      "reward_nonull_title": "{sign} {amount} نقاط صحة لـ{rewardName} من {rewardVendor}",
      "coupon_code": "رمز القسيمة",
      "your_coupon_code_is": "رمز قسيمتك: {couponCode}",
      "ok": "حسنا"
    },
    "home": {
      "hello": "أهلا {name}،",
      "not_supported": "جهازك لا\nيدعم تتبع الخطوات! 😢",
      "unknown_error": "هناك خطأ ما!",
      "to_reach_your_goal": "لتصل لهدفك!",
      "total_steps": "مجموع الخطوات",
      "total_distance": "المسافة الكلية",
      "km_kilotmeter": "كم",
      "see_leaderboard": "اطلع على لوحة المتصدرين"
    },
    "leaderboard": {
      "leaderboard": "لوحة المتصدرين",
      "unknown_error": "هناك خطأ ما!",
      "top_50": "أفضل 50",
      "you": "أنت"
    },
    "main": {
      "home": "الرئيسة",
      "leaderboard": "المتصدرين",
      "rewards": "الجوائز",
      "account": "الحساب"
    },
    "rewards": {
      "rewards": "الجوائز",
      "health_points": "نقاط صحة",
      "not_enough_health_points": "ليس لديك نقاط صحة كافية!",
      "are_you_sure": "هل أنت واثق؟",
      "are_you_sure_spend": "هل أنت متأكد من أنك تريد إنفاق {rewardPrice} نقاط صحة على {rewardName}؟",
      "cancel": "إلغاء",
      "yes_sure": "نعم، بالتأكيد!",
      "congrats": "مبروك 🎉",
      "congrats_coupon_code": "مبروك! هذا هو رمز القسيمة الخاص بك: {rewardCouponCode}.",
      "sold_out": "تم البيع",
      "view_coupon_code": "إظهار رمز القسيمة"
    },
    "settings": {
      "settings": "الإعدادات",
      "appearance": "المظهر",
      "light": "فاتح",
      "dark": "غامق",
      "system": "النظام"
    },
    "register": {
      "check_info_provided_above": "تحقق من المعلومات التي قدمتها أعلاه!",
      "register": "إنشاء حساب",
      "first_name": "الإسم الأول",
      "last_name": "الإسم الأخير",
      "phone_number": "رقم الجوال",
      "already_have_account": "هل لديك حساب؟ تسجيل الدخول!"
    },
    "login": {
      "check_info_provided_above": "تحقق من المعلومات التي قدمتها أعلاه!",
      "login": "تسجيل دخول",
      "phone_number": "رقم الجوال",
      "have_no_account": "ليس لديك حساب؟ أنشئ حسابا!"
    }
  },
  "widgets": {
    "verification_ui": {
      "verify_phone_number": "تحقق من رقم الجوال",
      "be_patient_sms_code_sent": "يرجى التحلي بالصبر أثناء إرسال رمز التحقق عبر الرسائل القصيرة.",
      "verification_code": "رمز التحقق",
      "verify": "تحقق"
    }
  }
};
static const Map<String,dynamic> en = {
  "validators": {
    "first": "First Name",
    "last": "Last Name",
    "less_characters": "{field} must be less than {characters} characters.",
    "more_characters": "{field} must be more than {characters} characters.",
    "cant_empty": "{field} can't be empty.",
    "must_be": "{field} must be {characters} characters.",
    "not_correct": "{field} is not correct.",
    "phone_number": "Phone Number",
    "verification_code": "Verification Code"
  },
  "error_service": {
    "unknown": "Something went wrong! Please try again later.",
    "invalid_verification_id": "Invalid verification ID.",
    "invalid_verification_code": "Invalid verification code.",
    "user_disabled": "Your account is disabled."
  },
  "views": {
    "account": {
      "welcome": "Welcome {name},",
      "sign_out": "Sign Out",
      "edit_profile": "Edit Profile",
      "transaction_history": "Transaction History",
      "settings": "Settings"
    },
    "edit_profile": {
      "edit_profile": "Edit Profile",
      "change_profile_image": "Change profile image",
      "first_name": "First Name",
      "last_name": "Last Name",
      "update_profile": "Update Profile"
    },
    "history": {
      "history": "History",
      "no_history": "Oops! Seems you have no history! 😢",
      "reward_null_title": "{sign}{amount} health points",
      "reward_nonull_title": "{sign}{amount} health points for {rewardName} from {rewardVendor}",
      "coupon_code": "Coupon Code",
      "your_coupon_code_is": "Your coupon code is: {couponCode}",
      "ok": "Ok"
    },
    "home": {
      "hello": "Hello {name},",
      "not_supported": "Your device doesn't\nsupport steps tracking! 😢",
      "unknown_error": "Something went wrong!",
      "to_reach_your_goal": "to reach your goal!",
      "total_steps": "total steps",
      "total_distance": "total distance",
      "km_kilotmeter": "KM",
      "see_leaderboard": "See leaderboard"
    },
    "leaderboard": {
      "leaderboard": "Leaderboard",
      "unknown_error": "Something went wrong!",
      "top_50": "Top 50",
      "you": "You"
    },
    "main": {
      "home": "Home",
      "leaderboard": "Leaderboard",
      "rewards": "Rewards",
      "account": "Account"
    },
    "rewards": {
      "rewards": "Rewards",
      "health_points": "Health Points",
      "not_enough_health_points": "You don't have enough health points!",
      "are_you_sure": "Are you sure?",
      "are_you_sure_spend": "Are you sure you want to spend {rewardPrice} health points on {rewardName}?",
      "cancel": "Cancel",
      "yes_sure": "Yes, Sure!",
      "congrats": "Congrats 🎉",
      "congrats_coupon_code": "Congrats! Here is your coupon code: {rewardCouponCode}.",
      "sold_out": "Sold Out",
      "view_coupon_code": "View Coupon Code"
    },
    "settings": {
      "settings": "Settings",
      "appearance": "Appearance",
      "light": "Light",
      "dark": "Dark",
      "system": "System"
    },
    "register": {
      "check_info_provided_above": "Check the info you provided above!",
      "register": "Register",
      "first_name": "First Name",
      "last_name": "Last Name",
      "phone_number": "Phone Number",
      "already_have_account": "Already have an account? Login!"
    },
    "login": {
      "check_info_provided_above": "Check the info you provided above!",
      "login": "Login",
      "phone_number": "Phone Number",
      "have_no_account": "Have no account? Register!"
    }
  },
  "widgets": {
    "verification_ui": {
      "verify_phone_number": "Verify Phone Number",
      "be_patient_sms_code_sent": "Kindly be patient while the Verification Code is sent via SMS.",
      "verification_code": "Verification Code",
      "verify": "Verify"
    }
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
