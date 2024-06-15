import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:codecoy/utilis/app_colors.dart';
import 'package:workmanager/workmanager.dart';

const String taskName = "notificationTask";

class NotificationService {
  NotificationService._privateConstructor();

  static final NotificationService _instance =
      NotificationService._privateConstructor();

  factory NotificationService() {
    return _instance;
  }

   void initialize() {
    AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: 'jawad',
          channelName: 'jawad',
          channelDescription: 'For test purpose',
          defaultColor: AppColors.primary,
          ledColor: AppColors.white,
        )
      ],
    );
  }

   static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      switch (task) {
        case taskName:
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 10,
              channelKey: 'jawad',
              title: 'Hello G',
              body: 'every 5 seconds',
            ),
          );
          break;
      }
      return Future.value(true);
    });
  }

   void schedulePeriodicNotifications() {
    Workmanager().registerPeriodicTask(
      "1",
      taskName,
      frequency: const Duration(seconds: 5),
    );
  }

    void initializeWorkManager() {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
  }
}
