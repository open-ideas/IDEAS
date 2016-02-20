within IDEAS.Electrical.BaseClasses.Types;
record ComplexCharacteristicImpedance = Complex (redeclare
      CharacteristicResistance re,                                  redeclare
      CharacteristicReactance im) "Complex Characterisitc impedance";
