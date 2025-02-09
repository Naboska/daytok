import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CubitBase<State extends CubitBaseState> extends Cubit<State> {
  CubitBase(this._state) : super(_state);

  final State _state;

  Completer _initializer = Completer();

  bool _hasInitializationStarted = false;

  CubitStateStatus get status => state.status;

  @override
  State get state {
    if (!_hasInitializationStarted) _initialize();

    return super.state;
  }

  @mustCallSuper
  @visibleForTesting
  @protected
  void init() {
    _initializer.complete();
  }

  void refresh() {
    // no nothing
  }

  void reset() {
    if (isClosed) return;

    _initializer = Completer<void>();
    _hasInitializationStarted = false;
    emit(_state);
  }

  Future<CubitBase<State>> wait() async {
    await _initializer.future;

    return this;
  }

  void _initialize() {
    if (_initializer.isCompleted) return;

    _hasInitializationStarted = true;
    init();
  }
}

abstract class CubitBaseState extends Equatable {
  final CubitStateStatus status;

  const CubitBaseState({this.status = CubitStateStatus.success});

  @override
  List<Object?> get props;

  CubitBaseState copyWith();
}

enum CubitStateStatus { success, error, loading }

extension CubitStateStatusX on CubitStateStatus {
  bool get isSuccess => this == CubitStateStatus.success;
  bool get isError => this == CubitStateStatus.error;
  bool get isLoading => this == CubitStateStatus.loading;
}
