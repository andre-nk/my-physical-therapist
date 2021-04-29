part of "provider.dart";

final StopWatchTimer _stopWatchTimer = StopWatchTimer(
  mode: StopWatchMode.countUp,
  // onChange: (value) => print('onChange $value'),
  // onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
  // onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
);

final exerciseControlProvider = Provider<ExerciseControl>((ref){
  return ExerciseControl();
});

class ExerciseControl{
  Future<void> startTimer() async {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  Future<void> pauseTimer() async {
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }
} 