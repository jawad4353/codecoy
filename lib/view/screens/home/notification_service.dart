import 'package:awesome_notifications/awesome_notifications.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_constants.dart';

class NotificationService {
  static int _notificationId = 0;

  static void initialize() {
    AwesomeNotifications().initialize(
      AppConstants.channelIcon,
      [
        NotificationChannel(
          channelKey: AppConstants.foregroundChannelKey,
          defaultRingtoneType: DefaultRingtoneType.Notification,
          enableVibration: true,
          importance: NotificationImportance.High,
          channelDescription:
          AppConstants.foregroundChannelDescription,
          //defaultColor: AppColors.primary,
         // ledColor: AppColors.primary,
          channelName:AppConstants.foregroundChannelKey,
        ),
      ],
    );
  }


  static void showNotification() async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    _notificationId++;
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: _notificationId,
          channelKey: AppConstants.foregroundChannelKey,
          title:  AppConstants.foregroundNotification+_notificationId.toString(),
          body: AppConstants.foregroundNotificationBody,
        ));
    listenNotificationActions();
  }


  static listenNotificationActions(){
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    );
  }
}






class NotificationController {

  @pragma("vm:entry-point")
  static Future <void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    print(receivedNotification.title);
  }

  @pragma("vm:entry-point")
  static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    print(receivedNotification.actionType);
  }

  @pragma("vm:entry-point")
  static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    print(receivedAction.title);
  }

  @pragma("vm:entry-point")
  static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    print(receivedAction.title);
  }

}