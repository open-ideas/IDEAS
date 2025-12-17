within IDEAS.Experimental.Electric.BaseClasses.Types;
operator record ComplexCharacteristicImpedance = Complex(
	redeclare CharacteristicResistance re,
	redeclare CharacteristicReactance im) "Complex Characterisitc impedance";
