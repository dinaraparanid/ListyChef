import 'dart:io';

T platformCall<T>({
  required T android,
  required T iOS,
  required T macOS,
  required T linux,
  required T windows,
  T? web,
}) {
  if (Platform.isAndroid) return android;
  if (Platform.isIOS) return iOS;
  if (Platform.isMacOS) return macOS;
  if (Platform.isLinux) return linux;
  if (Platform.isWindows) return windows;
  return web ?? android;
}
