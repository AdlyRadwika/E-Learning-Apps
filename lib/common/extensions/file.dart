import 'dart:io';

extension FileExtention on FileSystemEntity {
  String get name => path.split(Platform.pathSeparator).last;
}
