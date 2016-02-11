within IDEAS.Fluid.Production.BaseClasses;
package Types
  type Temperature = enumeration(
      C "Temperature input in C",
      K "Temperature input in K");
  type MassFlow = enumeration(
      m3ps "Massflow in m3/s",
      kgps "Massflow in kg/s",
      lph "Massflow in l/h");
  type Inputs = enumeration(
      TPrimary "Temperature on the primary side",
      TSecondary "Temperature on the secondary side",
      MassFlow "Massflow on the primary side",
      Modulation "Modulation rate");
end Types;
