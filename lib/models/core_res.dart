enum ResponseStatus {
  loading,
  failed,
  completed,
  none,
  saving,
  refreshing,
  empty,
  error,
  success,
}

class GenericResponseModel<T> {
  String? token;
  String? message;
  DateTime? timestamp;
  List<String> errors;
  ResponseStatus status;
  Map<String, dynamic> errorsObject;
  int statusCode;
  T? data;

  String get errorMessage =>
      message == null
          ? errors.isEmpty
              ? "Success"
              : errors[0]
          : message!;

  GenericResponseModel({
    this.token,
    this.message,
    this.timestamp,
    this.errors = const [],
    this.status = ResponseStatus.none,
    this.data,
    this.statusCode = 0,
    this.errorsObject = const {},
  });

  factory GenericResponseModel.fromJson(
    Map<String, dynamic> data, {
    ResponseStatus status = ResponseStatus.none,
    T? defaultData,
    int code = 0,
  }) => GenericResponseModel(
    token: data['token'],
    timestamp:
        data.containsKey("timestamp")
            ? DateTime.parse(data['timestamp'].replaceAll(",", ""))
            : DateTime.now(),
    message: data['message'],
    errors:
        data['errors'] == null ||
                !data['errors'].runtimeType.toString().contains("List")
            ? []
            : List<String>.from(data['errors']),
    status: status,
    data: defaultData,
    statusCode: code,
  );
}
