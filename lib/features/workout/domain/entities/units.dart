import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Units extends Equatable {
  final String weight;
  final String distance;

  @override
  List<Object> get props => [weight, distance];

  Units({
    @required this.weight,
    @required this.distance,
  });
}
