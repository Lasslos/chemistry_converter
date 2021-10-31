import 'package:graph_collection/graph.dart';
import 'package:periodic_table/periodic_table.dart';

const double avogadrosNumber = 6.0221415e23;
const Pair avogadrosNumberPair = Pair('avogadrosNumber', avogadrosNumber);

class Matter {
  factory Matter({
    final List<ChemicalElement> formula = const [],
    final double? moles,
    final double? numberOfAtoms,
    final double? volume,
    final double? mass,
    final bool isAtSTP = false,
    final double? molarMass,
    final double? density,
  }) =>
      MatterBuilder(
        formula: formula,
        moles: moles,
        numberOfAtoms: numberOfAtoms,
        volume: volume,
        mass: mass,
        isAtSTP: isAtSTP,
        molarMass: molarMass,
        density: density,
      ).build();

  Matter._(this.formula, this.moles, this.numberOfAtoms, this.volume, this.mass,
      this.molarVolume, this.molarMass, this.density) {
    graph.add(moles);
    graph.add(numberOfAtoms);
    graph.add(volume);
    graph.add(mass);
    graph.setTo(numberOfAtoms, moles, 'key', avogadrosNumberPair);
    graph.setTo(volume, moles, 'key', molarVolume);
    graph.setTo(mass, moles, 'key', molarMass);
    graph.setTo(mass, moles, 'key', density);
  }

  final List<ChemicalElement>? formula;

  final Pair moles;
  final Pair numberOfAtoms;
  final Pair volume;
  final Pair mass;

  final Pair molarVolume;
  final Pair molarMass;
  final Pair density;

  final DirectedValueGraph graph = DirectedValueGraph();
}

class MatterBuilder {
  MatterBuilder({
    final List<ChemicalElement> formula = const [],
    final double? moles,
    final double? numberOfAtoms,
    final double? volume,
    final double? mass,
    final bool isAtSTP = false,
    final double? molarMass,
    final double? density,
  })  : _formula = formula,
        _moles = _ModifiablePair('moles', moles),
        _numberOfAtoms = _ModifiablePair('numberOfAtoms', numberOfAtoms),
        _volume = _ModifiablePair('volume', volume),
        _mass = _ModifiablePair('mass', mass),
        assert(formula.isEmpty || molarMass == null,
            'Cannot give both formula and molar mass.'),
        _molarMass = _ModifiablePair(
            'molarMass',
            molarMass ??
                (formula.isEmpty
                    ? null
                    : formula.fold<double>(
                        0,
                        (final previousValue, final element) =>
                            previousValue + element.atomicMass))),
        _molarVolume = _ModifiablePair('molarVolume', isAtSTP ? 22.414 : null),
        _density = _ModifiablePair('density', density) {
    _graph.add(_moles);
    _graph.add(_numberOfAtoms);
    _graph.add(_volume);
    _graph.add(_mass);
    //The key is used for identifying different links between the same nodes.
    //We don't have such a thing. Furthermore, we need to be able to get
    //all links anywhere in the code. The key will therfore be the string 'key'.
    _graph.setTo(
        _numberOfAtoms, _moles, 'key', avogadrosNumberPair._toModifiablePair());
    _graph.setTo(_volume, _moles, 'key', _molarVolume);
    _graph.setTo(_mass, _moles, 'key', _molarMass);
    _graph.setTo(_mass, _moles, 'key', _density);
    _completeGraph();
  }

  final List<ChemicalElement> _formula;

  final _ModifiablePair _moles;
  final _ModifiablePair _numberOfAtoms;
  final _ModifiablePair _volume;
  final _ModifiablePair _mass;

  final _ModifiablePair _molarVolume;
  final _ModifiablePair _molarMass;
  final _ModifiablePair _density;

  final DirectedValueGraph _graph = DirectedValueGraph();

  void _completeGraph() => _completeGraphRecursive([]);
  void _completeGraphRecursive(final List<_ModifiablePair> completedLinks) {
    for (_ModifiablePair element in _graph.items) {
      //Getting all requiered information from graph about links
      final linkDesinations = _graph.linkFroms(element).toList(growable: false);
      final linkValues =
          _graph.valueFroms(element, 'key').toList(growable: false);
      assert(linkValues.length == linkDesinations.length,
          'Linked values does not match linked destinations.');

      //Iterating trough all links
      for (var i = 0; i < linkValues.length; i++) {
        final _ModifiablePair destination = linkDesinations[i];
        final _ModifiablePair link = linkValues[i];

        //If calculated earlier, dont to it again
        if (completedLinks.contains(link)) {
          continue;
        }
        //Counting, how many are null
        final j = (element.value != null ? 1 : 0) +
            (destination.value != null ? 1 : 0) +
            (link.value != null ? 1 : 0);
        //If not calculated earlier, but still three values exsiting,
        //means that there is a conflict
        assert(
          j != 3,
          'There was an error while tring to complete the values. All three '
          'values ${element.key}, ${destination.key}, and ${link.key} '
          'already had a value before they tried to determine each other. '
          'That means, that there is a potential conflict between these '
          'numbers. Try removing one of the conflicting information.',
        );
        //If there is less than two, we cannot use the values
        // to complete each other.
        if (j < 2) {
          continue;
        }

        double? elementValue = element.value;
        double? destinationValue = destination.value;
        double? linkValue = link.value;
        elementValue = elementValue ?? destinationValue! * linkValue!;
        destinationValue = destinationValue ?? elementValue / linkValue!;
        linkValue = linkValue ?? elementValue / destinationValue;
        element.value = elementValue;
        destination.value = destinationValue;
        link.value = destinationValue;

        completedLinks.add(link);
        return _completeGraphRecursive(completedLinks);
      }
    }
  }

  Matter build() => Matter._(
        _formula,
        _moles.toPair(),
        _numberOfAtoms.toPair(),
        _volume.toPair(),
        _mass.toPair(),
        _molarVolume.toPair(),
        _molarMass.toPair(),
        _density.toPair(),
      );
}

class _ModifiablePair {
  _ModifiablePair(this.key, this.value);
  final String key;
  double? value;
  Pair toPair() => Pair(key, value);
}

class Pair {
  const Pair(this.key, this.value);
  final String key;
  final double? value;
  _ModifiablePair _toModifiablePair() => _ModifiablePair(key, value);
}
