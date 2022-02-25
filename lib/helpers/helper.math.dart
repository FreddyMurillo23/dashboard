/// This file will contain some standardization methods
/// such as minmax or sigmoid in order to use them to
/// generate colors, adjust sizes on charts, etc.
/// 

/// Retuns a value between 0 and 1. Here [x] corresponds to the
/// value you wanna scale according to a [min] and a [max] value
/// of an array. The value 1e-10 is used to avoid division by zero
/// in the case where min and max are the same value.
double minmax(int x, int min, int max) {
  return (x - min) / (max - min) + 0.0000000001;
}