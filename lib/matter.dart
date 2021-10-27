import 'package:graph_collection/graph.dart';
import 'package:periodic_table/periodic_table.dart';

const double avogadrosNumber = 6.0221415e23;

class Matter {
  final List<ChemicalElement>? formula;
  final Graph graph;

  Matter._(this.formula, this.graph);
}
class MatterBuilder {
  MatterBuilder(List<ChemicalElement>? formula, )
}