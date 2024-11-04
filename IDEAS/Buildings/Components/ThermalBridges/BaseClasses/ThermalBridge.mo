within IDEAS.Buildings.Components.ThermalBridges.BaseClasses;
record ThermalBridge "Record data for thermal bridges"

  parameter Modelica.Units.SI.ThermalConductance G "Effective thermal loss";
    
  // this parameter is set by the window model and should not be modified when extending:
  parameter Modelica.Units.SI.Length len "Perimeter of the thermal bridge";
  
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ThermalBridge;
