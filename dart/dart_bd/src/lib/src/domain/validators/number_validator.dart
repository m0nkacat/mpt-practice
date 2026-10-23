bool isPositiveNumber(dynamic value) {
  if (value is int) return value > 0;
  if (value is double) return value > 0;
  return false;
}