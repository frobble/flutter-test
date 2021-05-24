String convertToTimeString(double d) {
  var time = d.floor();
  var mins = (d - d.floor()) * 100 * 6 / 10;
  return "$time:${mins.floor()}";
}
