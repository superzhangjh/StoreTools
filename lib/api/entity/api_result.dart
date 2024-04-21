class ApiResult<T> {
  int code = 200;
  T? data;
  String? msg;

  ApiResult({
    required this.code,
    this.data,
    this.msg
  });

  factory ApiResult.success(T? data) => ApiResult<T>(code: 200, data: data);

  factory ApiResult.error(String? msg) => ApiResult<T>(code: -1, msg: msg ?? '未知错误');

  bool isSuccess() => code == 200;
}