part of background_service;

class BackgroundDataService {
  static final BackgroundDataService _singleton =
      BackgroundDataService._internal();

  factory BackgroundDataService() {
    return _singleton;
  }

  BackgroundDataService._internal();

  static Map<String, Future<bool> Function()?> functions = {};

  static Future<void> init(List<BackgrundDataTask> tasks, {bool? force}) async {
    bool isIos = Theme.of(ModernFormGlobalContext.context!).platform ==
        TargetPlatform.iOS;
    bool _force = force != null && force;

    if (kIsWeb || isIos || _force) {
      final Iterable<BackgrundDataTask> futureTasks = tasks.where((e) =>
          (e.awaited == null || !e.awaited!) &&
          (e.awaitedInLIne == null || !e.awaitedInLIne!));
      final Iterable<BackgrundDataTask> awaitedTasks =
          tasks.where((e) => e.awaited == true);
      final Iterable<BackgrundDataTask> awaitedInLine =
          tasks.where((e) => e.awaitedInLIne == true);

      await Future.wait(futureTasks.map((e) => e.callback!()));
      await Future.wait(awaitedTasks.map((e) => e.callback!()));
      await Future.forEach<BackgrundDataTask>(awaitedInLine, (task) async {
        await task.callback!();
      });
    } else {
      await Future.forEach(tasks, (BackgrundDataTask element) async {
        String taskId =
            element.taskId ?? DateTime.now().millisecondsSinceEpoch.toString();

        functions[taskId] = element.callback;

        await BackgroundDataHelper.createsScheduleTask(
          taskId,
          element.millisecondsDelay,
        );
      });
      _start(calback);
    }
  }

  static calback(String taskId) async {
    debugPrint(
        "[BackgroundDataService  _start((String taskId)] Event received: $taskId");

    Future<bool> Function()? function = functions[taskId];
    debugPrint("functions.length --> ${functions.length}");
    if (function != null) {
      bool sucess = await function();
      debugPrint("BackgroundDataService.calback() sucess --> $sucess");
      if (sucess) {
        functions.remove(taskId);
      }
    }

    BackgroundFetch.finish(taskId);
    if (functions.isEmpty) {
      BackgroundFetch.stop();
    }
  }

  static Future<void> _start(Function(String taskId) callback) async {
    debugPrint("_start: functions.length --> ${functions.length}");
    await BackgroundDataHelper.initPlatformState(callback);
  }
}
