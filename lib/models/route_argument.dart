// ignore: unused_import

class RouteArgument {
  String? id;
  String? heroTag;
  String? param;
  String? image;

  // Cuisine cuisine;

  RouteArgument(
      {this.id,
      this.heroTag,
      this.param,
      this.image,

      // this.cuisine
      });

  @override
  String toString() {
    return '{id: $id, heroTag:${heroTag.toString()}}';
  }
}
