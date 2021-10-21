part of background_service;

class BackgroundDataHelper {
  static Future<void> initPlatformState(
    Function callback,
  ) async {
    BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 15,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.ANY,
        forceAlarmManager: true,
      ),
      callback,
    ).then((int status) {
      debugPrint('[BackgroundDataService] configure success: $status');
    }).catchError((e) {
      debugPrint('[BackgroundDataService] configure ERROR: $e');
    });

    // int status = await BackgroundFetch.status;
    // print('[BackgroundDataService] status: $status');
  }

  static Future<bool> createsScheduleTask(
      String taskId, int? millisecondsDelay) async {
    return await BackgroundFetch.scheduleTask(TaskConfig(
      taskId: taskId,
      delay: millisecondsDelay ?? 0,
      periodic: false,
      forceAlarmManager: true,
      stopOnTerminate: true,
      enableHeadless: false,
      requiresBatteryNotLow: false,
      requiresCharging: false,
      requiresStorageNotLow: false,
      requiresDeviceIdle: false,
      requiredNetworkType: NetworkType.ANY,
    ));
  }
}
