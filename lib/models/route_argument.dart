// ignore: unused_import

class RouteArgument {
  String? id;
  String? heroTag;
  String? param;
  String? image;
  String? parentId;
  bool? fromStore;
  String? fromSlide;
  // Cuisine cuisine;

  RouteArgument(
      {this.id,
      this.heroTag,
      this.param,
      this.image,
      this.parentId,
      this.fromStore, this.fromSlide,
      // this.cuisine
      });

  @override
  String toString() {
    return '{id: $id, heroTag:${heroTag.toString()}}';
  }
}
