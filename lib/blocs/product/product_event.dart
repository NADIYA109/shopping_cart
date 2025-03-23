abstract class ProductEvent {}

class FetchProducts extends ProductEvent {
  final int limit;
  final int skip;

  FetchProducts({this.limit = 10, this.skip = 0});
}
