class NetworkServiceResponse<T> {
  T? content;
  String? message;
  bool success;

  NetworkServiceResponse(
      {this.content, this.message, required this.success});
}

class MappedNetworkServiceResponse<T> {
  dynamic mappedResult;
  NetworkServiceResponse<T> networkServiceResponse;
  MappedNetworkServiceResponse(
      {this.mappedResult, required this.networkServiceResponse});
}
