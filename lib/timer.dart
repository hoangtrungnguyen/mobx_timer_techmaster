import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:mobx/mobx.dart';
import 'dart:async' show Timer;

import 'package:rxdart/rxdart.dart';

part 'timer.g.dart';

enum TimerState { TICKING, PAUSE, READY, COMPLETE }

class TimerMobx = TimerBase with _$TimerMobx;

abstract class TimerBase with Store {
  AudioCache audioCache = AudioCache();

  StreamSubscription<int> subscription;
  @observable
  TimerState state = TimerState.READY;

  @observable
  int countDown = 20;

  TimerBase() {}

  @action
  pause() {
    state = TimerState.PAUSE;
    subscription.pause();
  }

  @action
  start() async {
    state = TimerState.TICKING;
    subscription = counter(countDown).listen((event) async {
      countDown -= event;
      if(countDown <0){
        state = TimerState.COMPLETE;
        await audioCache.play("note1.wav");
      }
    });
  }

  @action
  reset() {
    state = TimerState.READY;
    subscription.cancel();
  }

  @action
  resume() {
    state = TimerState.TICKING;
    subscription.resume();
  }

  @action
  cancel() {
    state = TimerState.READY;
    subscription.cancel();
  }

  Stream<int> counter(int startVal) async* {
    for (int i = startVal; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      yield 1;
    }
  }
}
