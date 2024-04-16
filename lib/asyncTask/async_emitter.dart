import 'dart:isolate';

class AsyncEmitter<T> {

  final SendPort _sendPort;

  AsyncEmitter(this._sendPort);

  void emit(T data) {
    _sendPort.send(AsyncData<T>(state: AsyncData.stateSendData, data: data));
  }

  void close() {
    _sendPort.send(AsyncData<T>(state: AsyncData.stateClose));
  }
}

class AsyncData<T> {
  static const stateSendData = 0;
  static const stateClose = 1;

  int state;
  T? data;

  AsyncData({ required this.state, this.data });
}