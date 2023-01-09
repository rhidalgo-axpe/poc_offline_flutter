enum FileType {
  pdf, image
}

extension ParseToString on FileType {
  String stringValue() {
    return toString()
        .split('.')
        .last;
  }
}