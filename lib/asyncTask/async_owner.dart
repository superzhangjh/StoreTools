import 'async_emitter.dart';

class AsyncOwner<T> {
  final AsyncEmitter<T> _emitter;

  AsyncOwner(this._emitter);

  void close() {
    _emitter.close();
  }
}