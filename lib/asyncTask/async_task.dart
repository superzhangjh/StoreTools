import 'dart:isolate';

import 'package:storetools/asyncTask/async_owner.dart';

import 'async_emitter.dart';
import 'data/isolate_data.dart';

///不带参数的隔离任务
Future<AsyncOwner<T>> asyncTask<T>(
    Function(IsolateData<T> isolateData) doInBackground, {
      Function(T? data)? onReceive
    }
) => _asyncTask<T, IsolateData<T>>(doInBackground, onReceive, (emitter) => IsolateData(emitter));

///带单个参数的隔离任务
Future<AsyncOwner<T>> asyncTaskWithSingle<T, P>(
    P param,
    Function(SingleIsolateData<T, P> isolateData) doInBackground, {
      Function(T? data)? onReceive
    }
) => _asyncTask<T, SingleIsolateData<T, P>>(doInBackground, onReceive, (emitter) => SingleIsolateData(emitter, param));

///带两个参数的隔离任务
Future<AsyncOwner<T>> asyncTaskWithPair<T, P1, P2>(
    P1 param1,
    P2 param2,
    Function(PairIsolateData<T, P1, P2> isolateData) doInBackground, {
      Function(T? data)? onReceive
    }
) => _asyncTask<T, PairIsolateData<T, P1, P2>>(doInBackground, onReceive, (emitter) => PairIsolateData(emitter, param1, param2));

///带三个参数的隔离任务
Future<AsyncOwner<T>> asyncTaskWithTriple<T, P1, P2, P3>(
    P1 param1,
    P2 param2,
    P3 param3,
    Function(TripleIsolateData<T, P1, P2, P3> isolateData) doInBackground, {
      Function(T? data)? onReceive
    }
) => _asyncTask<T, TripleIsolateData<T, P1, P2, P3>>(doInBackground, onReceive, (emitter) => TripleIsolateData(emitter, param1, param2, param3));

///带四个参数的隔离任务
Future<AsyncOwner<T>> asyncTaskWithQuadruple<T, P1, P2, P3, P4>(
    P1 param1,
    P2 param2,
    P3 param3,
    P4 param4,
    Function(QuadrupleIsolateData<T, P1, P2, P3, P4> isolateData) doInBackground, {
      Function(T? data)? onReceive
    }
) => _asyncTask<T, QuadrupleIsolateData<T, P1, P2, P3, P4>>(doInBackground, onReceive, (emitter) => QuadrupleIsolateData(emitter, param1, param2, param3, param4));

///执行隔离任务
///[data]传输到隔离的数据，不能直接调用隔离区外的代码，如果有初始化参数由此传入
///[doInBackground]异步任务，必须在顶层函数或者static方法
///[onReceive]接收数据
Future<AsyncOwner<T>> _asyncTask<T, I extends IsolateData<T>>(
    Function(I) doInBackground,
    Function(T? data)? onReceive,
    I Function(AsyncEmitter<T> emitter) generateIsolateData
) async {
  var receivePort = ReceivePort();
  var emitter = AsyncEmitter<T>(receivePort.sendPort);
  var asyncOwner = AsyncOwner<T>(emitter);

  //执行异步操作
  await Isolate.spawn(doInBackground, generateIsolateData(emitter));

  //监听隔离的数据
  receivePort.listen((message) {
    var data = message as AsyncData<T>;
    switch (data.state) {
      case AsyncData.stateSendData:
        if (onReceive != null) onReceive(data.data);
        break;
      case AsyncData.stateClose:
        receivePort.close();
        break;
    }
  });
  return asyncOwner;
}
