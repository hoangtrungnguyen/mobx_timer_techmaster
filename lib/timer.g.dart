// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TimerMobx on TimerBase, Store {
  final _$stateAtom = Atom(name: 'TimerBase.state');

  @override
  TimerState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(TimerState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$countDownAtom = Atom(name: 'TimerBase.countDown');

  @override
  int get countDown {
    _$countDownAtom.reportRead();
    return super.countDown;
  }

  @override
  set countDown(int value) {
    _$countDownAtom.reportWrite(value, super.countDown, () {
      super.countDown = value;
    });
  }

  final _$startAsyncAction = AsyncAction('TimerBase.start');

  @override
  Future start() {
    return _$startAsyncAction.run(() => super.start());
  }

  final _$TimerBaseActionController = ActionController(name: 'TimerBase');

  @override
  dynamic pause() {
    final _$actionInfo =
        _$TimerBaseActionController.startAction(name: 'TimerBase.pause');
    try {
      return super.pause();
    } finally {
      _$TimerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reset() {
    final _$actionInfo =
        _$TimerBaseActionController.startAction(name: 'TimerBase.reset');
    try {
      return super.reset();
    } finally {
      _$TimerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic resume() {
    final _$actionInfo =
        _$TimerBaseActionController.startAction(name: 'TimerBase.resume');
    try {
      return super.resume();
    } finally {
      _$TimerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cancel() {
    final _$actionInfo =
        _$TimerBaseActionController.startAction(name: 'TimerBase.cancel');
    try {
      return super.cancel();
    } finally {
      _$TimerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
countDown: ${countDown}
    ''';
  }
}
