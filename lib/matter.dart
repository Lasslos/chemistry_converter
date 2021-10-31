const MatterElementConverter avogadrosNumber =
    MatterElementConverter(AmountOfSubstance, NumberOfAtoms);

class Matter {
  Matter._(this.moles, this.numberOfAtoms, this.grams, this.liters,
      this.molarMass, this.molarVolume, this.density);

  final AmountOfSubstance moles;
  final NumberOfAtoms numberOfAtoms;
  final Mass grams;
  final Volume liters;

  final MatterElementConverter molarMass;
  final MatterElementConverter molarVolume;
  final MatterElementConverter density;
  List<MatterElement> get elements =>
      List.unmodifiable([moles, numberOfAtoms, grams, liters]);
  List<MatterElementConverter> get converters =>
      List.unmodifiable([avogadrosNumber, molarMass, molarVolume, density]);
}

abstract class MatterElement {
  const MatterElement(this.value);
  abstract final String unit;
  abstract final bool isMetric;

  final double? value;
}

class AmountOfSubstance extends MatterElement {
  const AmountOfSubstance([final double? value]) : super(value);

  @override
  final bool isMetric = true;
  @override
  final String unit = 'moles';
}

class NumberOfAtoms extends MatterElement {
  const NumberOfAtoms([final double? value]) : super(value);

  @override
  final bool isMetric = false;
  @override
  final String unit = 'atoms/molecules/fu';
}

class Mass extends MatterElement {
  const Mass([final double? value]) : super(value);

  @override
  final bool isMetric = true;
  @override
  final String unit = 'gram';
}

class Volume extends MatterElement {
  const Volume([final double? value]) : super(value);

  @override
  final bool isMetric = true;
  @override
  final String unit = 'liter';
}

class MatterElementConverter {
  const MatterElementConverter(this.from, this.to, [final this.value]);

  final Type from;
  final Type to;
  final double? value;
}
