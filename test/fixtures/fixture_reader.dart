import 'dart:io';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();

String fixture2(String name) {
  final file = File('fixtures/$name');
  //print(file.absolute.path);
  return file.readAsStringSync();
} 
