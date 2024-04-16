import '../async_emitter.dart';

///隔离数据
class IsolateData<T> {
  AsyncEmitter<T> emitter;

  IsolateData(this.emitter);
}

class SingleIsolateData<T, P> extends IsolateData<T> {
  P param;

  SingleIsolateData(super.emitter, this.param);
}

class PairIsolateData<T, P1, P2> extends IsolateData<T> {
  P1 param1;
  P2 param2;

  PairIsolateData(super.emitter, this.param1, this.param2);
}

class TripleIsolateData<T, P1, P2, P3> extends IsolateData<T> {
  P1 param1;
  P2 param2;
  P3 param3;

  TripleIsolateData(super.emitter, this.param1, this.param2, this.param3);
}

class QuadrupleIsolateData<T, P1, P2, P3, P4> extends IsolateData<T> {
  P1 param1;
  P2 param2;
  P3 param3;
  P4 param4;

  QuadrupleIsolateData(super.emitter, this.param1, this.param2, this.param3, this.param4);
}