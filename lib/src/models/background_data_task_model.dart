part of background_service;

class BackgrundDataTask {
  // Function that will be performed
  Future<bool> Function()? callback;

  // Number of milliseconds when this task will fire.
  int? millisecondsDelay;

  // Unique taskId. This taskId will be provided to the BackgroundFetch callback function for use with [BackgroundFetch.finish]
  String? taskId;

  // IIf true, the function will only be executed in parallel, after finishing the tasks with task == null || task == false
  bool? awaited;

  // If true, the function will only be executed one after the other, after finishing the tasks with task == null || task == false
  bool? awaitedInLIne;

  BackgrundDataTask({
    this.callback,
    this.millisecondsDelay,
    this.taskId,
    this.awaited,
    this.awaitedInLIne,
  });

  BackgrundDataTask copyWith({
    Future<bool> Function()? callback,
    int? millisecondsDelay,
    String? taskId,
    bool? awaited,
    bool? awaitedInLIne,
  }) {
    return BackgrundDataTask(
      callback: callback ?? this.callback,
      millisecondsDelay: millisecondsDelay ?? this.millisecondsDelay,
      taskId: taskId ?? this.taskId,
      awaited: awaited ?? this.awaited,
      awaitedInLIne: awaitedInLIne ?? this.awaitedInLIne,
    );
  }

  @override
  String toString() =>
      'BackgrundDataTask(callback: $callback, millisecondsDelay: $millisecondsDelay, taskId: $taskId, awaited: $awaited, awaitedInLIne: $awaitedInLIne)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BackgrundDataTask &&
        other.callback == callback &&
        other.millisecondsDelay == millisecondsDelay &&
        other.awaited == awaited &&
        other.awaitedInLIne == awaitedInLIne &&
        other.taskId == taskId;
  }

  @override
  int get hashCode =>
      callback.hashCode ^
      millisecondsDelay.hashCode ^
      taskId.hashCode ^
      awaitedInLIne.hashCode ^
      awaited.hashCode;
}
