within IDEAS.Experimental.Electric.Data.Interfaces;
record TransformerImp "Transformer type"
extends Modelica.Icons.MaterialProperty;

// Electric parameters ---------------------------------------------------------

  parameter Modelica.Units.SI.ApparentPower Sn
    "Apparent power of the transformer";
  parameter Modelica.Units.SI.ActivePower P0
    "No-load losses, as defined in original transformer model (no update yet on values in data)";
  parameter Modelica.Units.SI.ComplexImpedance Zd
    "Direct impedance of the equivalent transformer scheme";
  parameter Modelica.Units.SI.ComplexImpedance Zi=Zd
    "Inverse impedance of the equivalent transformer scheme";
  parameter Modelica.Units.SI.ComplexImpedance Z0=Zd
    "Zero-sequence impedance of the equivalent transformer scheme";

// Thermal parameters based on IEEE C57.91 -------------------------------------

  parameter Modelica.Units.SI.Temperature TRef=293.15
    "Reference ambient temperature for THs and TTo";
  parameter Modelica.Units.SI.Temperature THs=348.15
    "Reference hot spot temperature of IEEE C57.91 at ambient TRef";
  parameter Modelica.Units.SI.Temperature TTo=328.15
    "Reference top oil temperature of IEEE C57.91 at ambient TRef";
  parameter Modelica.Units.SI.Time tauHs=300 "Hot spot time constant";
  parameter Modelica.Units.SI.Time tauTo=12600 "Top oil time constant";

end TransformerImp;
