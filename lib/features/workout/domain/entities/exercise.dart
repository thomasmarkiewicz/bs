import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Exercise extends Equatable {
  final String id;
  final String name;

  @override
  List<Object> get props => [id, name];

  Exercise({
    @required this.id,
    @required this.name,
  });
}
