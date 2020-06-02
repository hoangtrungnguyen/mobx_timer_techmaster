import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc_timer/timer.dart';
import 'package:bloc_timer/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(109, 234, 255, 1),
        accentColor: Color.fromRGBO(72, 74, 126, 1),
        brightness: Brightness.dark,
      ),
      title: 'Flutter Timer',
      home: TimerInherited(
        child: TimerCounter(),
      ),
    );
  }
}

class TimerInherited extends InheritedWidget {
  final TimerMobx timer = TimerMobx();

  TimerInherited({Key key, @required Widget child})
      : assert(child != null),
        super(key: key, child: child);

  static TimerInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TimerInherited>();
  }

  @override
  bool updateShouldNotify(TimerInherited old) {
    return true;
  }
}

class TimerCounter extends StatelessWidget {
  static const TextStyle timerTextStyle = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.bold,
  );
  AudioCache audioCache = AudioCache();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
//      appBar: AppBar(title: Text('Flutter Timer')),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: IgnorePointer(
                ignoring: [TimerState.TICKING, TimerState.PAUSE]
                    .contains(TimerInherited.of(context).timer.state),
                child: Observer(
                  builder: (BuildContext context) => SleekCircularSlider(
                    appearance: appearance05,
                    min: 0,
                    max: 1000,
                    initialValue: initialValue(context),
                    onChange: (double value) {
                      // callback providing a value while its being changed (with a pan gesture)
                      TimerInherited.of(context).timer.countDown =
                          value.toInt();
                    },
                    onChangeStart: (double startValue) {
                      // callback providing a starting value (when a pan gesture starts)
//                      TimerInherited.of(context).timer.secs = startValue.toInt();
                    },
                    onChangeEnd: (double endValue) {
                      // ucallback providing an ending value (when a pan gesture ends)
//                      TimerInherited.of(context).timer.startValue = endValue.toInt();
                    },
                    innerWidget: (double value) {
                      return Align(
                          alignment: Alignment.center,
                          child: Text(
                              buildTimerCounter(context, value) ?? "00:00"));
                    },
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.7),
            child: Observer(
              builder: (BuildContext context) {
                return Actions(
                  timer: TimerInherited.of(context).timer,
                );
              },
            ),
          ),
//          SafeArea(
//            child: RaisedButton(onPressed: () async {
//              await audioCache.play("note1.wav");
//              print("asss");
//            }),
//          )
        ],
      ),
    );
  }

  double initialValue(BuildContext context) {
    try {
      if ([TimerState.TICKING, TimerState.PAUSE, TimerState.READY]
          .contains(TimerInherited.of(context).timer.state))
        return TimerInherited.of(context).timer.countDown.toDouble();
      return 0;
    } catch (e) {
      return 0;
    }
  }

  String buildTimerCounter(BuildContext context, double value) {
    String minutesStr = ((value / 60) % 60).floor().toString().padLeft(2, '0');
    final String secondsStr = ((value) % 60).floor().toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }
}

class Actions extends StatelessWidget {
  final TimerMobx timer;

  const Actions({Key key, this.timer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: actionBuilder(context)),
    );
  }

  List<Widget> actionBuilder(BuildContext context) {
    if (TimerInherited.of(context).timer.state == TimerState.READY) {
      return [
        FloatingActionButton(
            child: Icon(Icons.play_arrow), onPressed: () => timer.start()),
      ];
    }

    if (TimerInherited.of(context).timer.state == TimerState.TICKING) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () => timer.pause(),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timer.reset(),
        ),
      ];
    }
    if (TimerInherited.of(context).timer.state == TimerState.PAUSE) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timer.resume(),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timer.reset(),
        ),
      ];
    }
    if (TimerInherited.of(context).timer.state == TimerState.COMPLETE) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timer.reset(),
        ),
      ];
    }

    return [];
  }
}

final CircularSliderAppearance appearance05 = CircularSliderAppearance(
    customWidths: customWidth05,
    customColors: customColors05,
    infoProperties: info05,
    animationEnabled: false,
    startAngle: 270,
    angleRange: 360,
    size: 350.0);

final info05 = InfoProperties(
    topLabelStyle: TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
    topLabelText: 'Elapsed',
    bottomLabelStyle: TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
    bottomLabelText: 'time',
    mainLabelStyle: TextStyle(
        color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.w600),
    modifier: (double value) {
      final time = printDuration(Duration(seconds: value.toInt()));
      return '$time';
    });

/// Example 05
final customWidth05 =
    CustomSliderWidths(trackWidth: 4, progressBarWidth: 20, shadowWidth: 40);
final customColors05 = CustomSliderColors(
    dotColor: HexColor('#FFB1B2'),
    trackColor: HexColor('#E9585A'),
    progressBarColors: [HexColor('#FB9967'), HexColor('#E9585A')],
    shadowColor: HexColor('#FFB1B2'),
    shadowMaxOpacity: 0.05);

String printDuration(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}
