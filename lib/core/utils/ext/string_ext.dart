extension StringExt on String {
  bool includes(String substring, {bool? ignoreCase}) =>
    switch (ignoreCase) {
      true => toLowerCase().contains(substring.toLowerCase()),
      false || null => contains(substring)
    };
}
