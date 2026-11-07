import 'contracts.dart';



class Logic implements Contracts {
  @override
  double baseLength(double length) {
    return length;
  }

  @override
  double baseWidth(double width, double thickness) {
    return width - (2 * thickness);
  }

  @override
  double faceWidth(double width, double thickness) {
    return width-(2*thickness);
  }

  @override
  double faceLength(double length, double rimLength) {
    return length+rimLength;
  }

  @override
  double column(double height) {
    return height-1;
  }
}
