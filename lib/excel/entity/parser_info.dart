class ParserInfo<T> {
  static const statusProgress = 0;
  static const statusComplete = 1;

  int status;
  ParserProgress? progress;
  List<T>? data;

  ParserInfo({
    required this.status,
    this.progress,
    this.data
  });

  factory ParserInfo.progress(ParserProgress? progress) => ParserInfo<T>(status: statusProgress, progress: progress);

  factory ParserInfo.complete(List<T>? data) => ParserInfo<T>(status: statusComplete, data: data);

  Map<String, dynamic> toJson() => {
    'status': status,
    'progress': progress,
    'data': data
  };

  factory ParserInfo.fromJson(Map<String, dynamic> json) => ParserInfo(
      status: json['status'],
      progress: json['progress'],
      data: json['data']
  );
}

///解析进度
class ParserProgress {
  int tableIndex;
  int rowIndex;
  int rowTotal;

  ParserProgress({
    required this.tableIndex,
    required this.rowIndex,
    required this.rowTotal
  });

  Map<String, dynamic> toJson() => {
    'tableIndex': tableIndex,
    'rowIndex': rowIndex,
    'rowTotal': rowTotal
  };

  factory ParserProgress.fromJson(Map<String, dynamic> json) => ParserProgress(
      tableIndex: json['id'],
      rowIndex: json['rowIndex'],
      rowTotal: json['rowTotal']
  );
}