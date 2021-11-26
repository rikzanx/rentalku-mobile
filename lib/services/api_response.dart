class ApiResponse<T> {
  final bool status;
  final String? message;
  final T? data;

  ApiResponse(this.status, {this.message, this.data});
}
