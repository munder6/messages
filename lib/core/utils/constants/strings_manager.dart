


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppStrings {
  static const String appName = "Message Me";
  static const String noRouteFound = "noRouteFound";

  //landing screen
  static const String welcomeToWhatsApp = 'Welcome to WhatsApp';
  static const String readOur = 'Read our ';
  static const String privacyPolicy = 'Privacy Policy';
  static const String tapAgreeAnd = '. Tap "Agree And Continue" to accept the ';
  static const String termsOfService = 'Terms of Service';
  static const String agreeAndContinue = 'AGREE AND CONTINUE';

  //login screen
  static const String enterYourPhoneNumber = 'Enter your phone number';
  static const String whatsAppWillNeed =
      'WhatsApp will need to verify your phone number.';
  static const String whatIsMyNumber = 'What\'s my number?';
  static const String phoneNumber = 'Phone number';
  static const String carrierChargesMayApply = 'Carrier charges may apply';
  static const String next = 'NEXT';
  static const String pickCountry = 'Choose a country';

  //alert dialog
  static const String toRetrieveYourPhone =
      'To retrieve your phone number, WhatsApp needs permissions to make and manage your calls. Without this permission, WhatsApp will be unable to retrieve your phone number from the SIM.';
  static const String youEnteredThePhoneNum = 'You entered the phone number:';
  static const String isThisOk =
      'Is this OK, or would you like to edit the number?';
  static const String edit = 'EDIT';
  static const String ok = 'OK';

  //otp screen
  static const String verifyingYourNumber = 'Verifying Your Number';
  static const String waitingToDetectSms =
      'Waiting to automatically detect an sms sent to';
  static const String wrongNumber = 'Wrong number?';
  static const String enter6DigitCode = 'Enter 6-digit code';
  static const String resendSms = 'Resend SMS';

  //login profile info
  static const String profileInfo = 'Profile info';
  static const String pleaseProvideYourName =
      'Please provide your Name & Profile photo';
  static const String typeYourNameHere = 'your name ...';
  static const String profilePhoto = 'Profile photo';
  static const String camera = 'Camera';
  static const String gallery = 'Gallery';

  //login loading screen
  static const String initializing = 'Initializing...';
  static const String pleaseWaitAMoment = 'Please wait a moment';

  /////
  static const String heyThere = 'Hey there!';

// select contact
  static const String selectContact = 'Select contact';
  static const String contacts = 'contacts';
  static const String newGroup = 'New group';
  static const String newContact = 'New contact';
  static const String newCommunity = 'New Community';
  static const String contactsOnWhatsApp = 'Contacts on WhatsApp';
  static const String inviteToWhatsApp = 'Invite to WhatsApp';
  static const String inviteAFriend = 'Invite a friend';
  static const String refresh = 'Refresh';
  static const String help = 'Help';
  static const String invite = 'Invite';

  /// Main Layout screen
  static const String chats = 'CHATS';
  static const String calls = 'Calls';
  static const String status = 'Status';
  static const String newBroadcast = 'New broadcast';
  static const String linkedDevices = 'Linked devices';
  static const String starredMessage = 'Starred message';
  static const String settings = 'Settings';

  //chat
  static const String viewContact = 'View contact';
  static const String mediaLinksAndDocs = 'Media, links, and docs';
  static const String search = 'Search';
  static const String muteNotifications = 'Mute notifications';
  static const String disappearingMessages = 'Disappearing messages';
  static const String wallpaper = 'Wallpaper';
  static const String more = 'More';
  static const String report = 'Report';
  static const String block = 'Block';
  static const String clearChat = 'Clear chat';

  //status
  static const String statusPrivacy = 'Status privacy';

  //call
  static const String clearCallLog = 'Clear call log';

  //setting and profile
  static const String profile = 'Profile';
  static const String name = 'Name';
  static const String phone = 'Phone';
  static const String about = 'About';
  static const String thisIsNotYourUser =
      'This is not your username or pin. This name will be visible to your Message Me contacts.';

  //sender profile
  static const String muteNotification = 'Mute Notifications';
  static const String customNotification = 'Custom Notifications';
  static const String  mediaVisibility = 'Media visibility';
  static const String encryption = 'Encryption';
  static const String messagesAndCallsAre = 'Messages and calls are end-to-end encrypted. Tap to verify.';
  static const String disappearingMessage = 'Disappearing Messages';
  static const String off = 'Off';
  static const String call = 'Call';
  static const String video = 'Video';
}


class AppStringss {
  static bool isEnglish = true;

  static String chats = isEnglish ? "MessageMe" : "المحادثات";
  static String edit = isEnglish ? "Edit" : "تعديل";
  static String search = isEnglish ? "Search messages" : "بحث";
  static String reply = isEnglish ? "Reply" : "رد";
  static String unlike = isEnglish ? "Unlike Message" : "الفاء الاعجاب";
  static String call = isEnglish ? "Call" : "اتصال";
  static String video = isEnglish ? "Video" : "مكالمة فيديو";
  static String broadcast = isEnglish ? "Broadcast List" : "قائمة البث الصوتي";
  static String newGroup = isEnglish ? "New Group" : "إنشاء مجموعة";
  static String archived = isEnglish ? "Archived" : "الأرشيف";
  static String settings = isEnglish ? "Settings" : "الإعدادات";
  static String notifications = isEnglish ? "Notifications" : "الإشعارات";
  static String privacy = isEnglish ? "Privacy" : "الخصوصية";
  static String editProfile = isEnglish ? "Change Name, Status, Profile Picture" : "تغيير الاسم ، الحالة ، الصورة الشخصية";
  static String storeData = isEnglish ? "Storage and data" : "البيانات والتخزين";
  static String lang = isEnglish ? "App language" : "لغة التطبيق";
  static String help = isEnglish ? "Help" : "الحصول على مساعدة";
  static String logout = isEnglish ? "Logout" : "تسجيل الخروج";
  static String confirmLogout = isEnglish ? "Are you sure you want to logout?" : "هل تريد تسجيل الخروج ؟";
  static String yes = isEnglish ? "yes" : "تسجيل الخروج";
  static String no = isEnglish ? "Cancle" : "إلغاء";
  static String save = isEnglish ? "Save" : "حفظ";
  static String selectContact = isEnglish ? "Select Contact" : "اضافة مستخدم";
  static String newCont = isEnglish ? "New Contact" : "مستخدم جديد";
  static String contact = isEnglish ? "contact" : "جهة اتصال";
  static String contactOnMessageMe = isEnglish ? "Contact on Message Me" : "جهات اتصال يستخدمون التطبيق";
  static String inviteToMessageMe = isEnglish ? "Invite To Message Me" : "دعوة الاصدقاء للتطبيق";
  static String newContact = isEnglish ? "New Contact" : "إضافة جهة اتصال";
  static String phoneNumber = isEnglish ? "Phone Number" : "رقم الهاتف";
  static String status = isEnglish ? "Status" : "الحالة";
  static String copyMessage = isEnglish ? "Copy Message" : "نسخ الرسالة";
  static String editMessage = isEnglish ? "Edit Message" : "تعديل الرسالة";
  static String deleteMessage = isEnglish ? "Unsend" : "حذف الرسالة";
  static String messageCopied = isEnglish ? "Message Copied" : "تم نسخ الرسالة";
  static String deleteForMe = isEnglish ? "Unsend For Me" : "الحذف لدي";
  static String deleteForAll = isEnglish ? "Unsend For All" : "الحذف للجميع";
  static String message = isEnglish ? "Message ..." : "";
  static String today = isEnglish ? "Today" : "اليوم";
  static String delete = isEnglish ? "Unsend" : "حذف";
  static String yesterday = isEnglish ? "Yesterday" : "أمس";
  static String selectLang = isEnglish ? "Select Your Language" : "اختيار اللغة";
  static String deleteConversation = isEnglish ? "Delete Conversation" : "حذف المحادثة";
  static String doneDeleteForMe = isEnglish ? "Message Deleted For Me" : "تم حذف الرسالة لديك";
  static String doneDelete = isEnglish ? "Conversation Deleted" : "تم حذف المحادثة";
  static String doneDeleteForAll = isEnglish ? "Message Deleted For All" : "تم حذف الرسالة للجميع";
  static String doneUpdate = isEnglish ? "Message Updated" : "تم تعديل الرسالة";
  static String restartNow = isEnglish ? "Restart Now" : "إعادة التشغيل الأن";
  static String restartRequired = isEnglish ? "Restart Required" : "مطلوب اعادة التشغيل";
  static String totalDeviceStorage = isEnglish ? "Total Device Storage" : "مساحة الجهاز";
  static String youNeedToRestartApp = isEnglish ? "You need to restart the app to apply changes." : "سيتم اعادة تشغيل التطبيق لتغيير اللغة";
  static String storageAndDataInfo = isEnglish ? "Storage and Data Info" : "معلومات البيانات والتخزين";
  static String confirmDelete = isEnglish ? "Are you sure you want to delete this message?" : "هل انت متأكد من حذف الرسالة؟";
  static String confirmDeleteConversation = isEnglish ? "Are you sure you want to delete this conversation?" : "هل انت متأكد من حذف المحادثة؟";



  static Future<void> fetchIsEnglishFromFirebase() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final currentUserId = currentUser?.uid;
      final snapshot = await FirebaseFirestore.instance.collection('users').doc(currentUserId).get();
      final userData = snapshot.data();
      if (userData != null && userData['isEnglish'] != null) {
        isEnglish = userData['isEnglish'];
      }
    } catch (e) {
      print('Error fetching isEnglish from Firebase: $e');
    }
  }
}
