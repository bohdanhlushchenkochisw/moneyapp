extension StringExt on String {
  String removeLast() {
    if (isEmpty) return '';
    return substring(0, length - 1);
  }
}
