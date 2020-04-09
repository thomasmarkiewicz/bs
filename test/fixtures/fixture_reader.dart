import 'dart:io';

String fixture(String name) {
  try {
    return File('test/fixtures/$name').readAsStringSync();
  } catch (FileSystemException) {
    return File('fixtures/$name').readAsStringSync();
  }
}
