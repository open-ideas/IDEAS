within IDEAS.Fluid.Production.Interfaces;
partial model ModulationSecurity "Non physical down modulation of the power of a heat production when the fluid temperature approach its boundaries temperature 
  in order to reduce the number of events"
  parameter Boolean use_modulation_security=false
    "Set to true if power modulation should be used to avoid exceeding temperature."
                                                                                     annotation (Dialog(tab="Advanced", group="Events"));
  parameter Modelica.SIunits.TemperatureDifference deltaT_security= if use_modulation_security then 1 else 5
    "Temperature difference from the boundary at which the security hysteresis will be released";
  parameter Modelica.SIunits.Temperature T_max=373.15
    "Maximum fluid temperature";
  parameter Modelica.SIunits.Temperature T_min=273.15
    "Minimum fluid temperature";

  Modelica.Blocks.Interfaces.RealOutput modulation_security=
      IDEAS.Utilities.Math.Functions.spliceFunction(
      x=min(limLow.y, limUp.y)/max(Modelica.Constants.eps,deltaT_security) - 1,
      pos=1,
      neg=0,
      deltax=0.5) if                                                                                                     use_modulation_security
    "Modulation to avoid reaching temperature boundaries";

protected
  Modelica.Blocks.Interfaces.RealOutput modulation_security_internal;
  Modelica.SIunits.Temperature T_high
    "Temperature which might cause overhitting (e.g. for a heat pump the condensor temperature)";
  Modelica.SIunits.Temperature T_low
    "Temperature which might cause undercooling (e.g. for a heat pump the evaporator temperature)";

  Modelica.Blocks.Sources.RealExpression limLow(y=T_low - T_min)
    "Lower temperature limit"
    annotation (Placement(transformation(extent={{44,66},{64,86}})));
  Modelica.Blocks.Sources.RealExpression limUp(y=T_max - T_high)
    "Upper temperature limit"
    annotation (Placement(transformation(extent={{44,80},{64,100}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    pre_y_start=true,
    uLow=0,
    uHigh=deltaT_security)
    annotation (Placement(transformation(extent={{72,84},{84,96}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(
    pre_y_start=true,
    uLow=0,
    uHigh=deltaT_security)
    annotation (Placement(transformation(extent={{72,70},{84,82}})));
  Modelica.Blocks.Logical.And on_security
    annotation (Placement(transformation(extent={{90,80},{98,88}})));
equation
  if not use_modulation_security then
    modulation_security_internal = 1;
  end if;
  connect(modulation_security, modulation_security_internal);

  connect(hysteresis.y, on_security.u1) annotation (Line(
      points={{84.6,90},{86,90},{86,84},{89.2,84}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(limUp.y, hysteresis.u) annotation (Line(
      points={{65,90},{70.8,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(limLow.y, hysteresis1.u) annotation (Line(
      points={{65,76},{70.8,76}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hysteresis1.y, on_security.u2) annotation (Line(
      points={{84.6,76},{86,76},{86,80.8},{89.2,80.8}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end ModulationSecurity;
