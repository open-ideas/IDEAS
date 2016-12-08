within IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer;
model ZoneLwDistributionViewFactor
  "Internal longwave radiative heat exchange using view factors"

  parameter Integer nSurf(min=1) "number of surfaces in contact with the zone";
  parameter Modelica.SIunits.Angle incCeiling=IDEAS.Types.Tilt.Ceiling;
  parameter Modelica.SIunits.Angle incFloor=IDEAS.Types.Tilt.Floor;
  parameter Modelica.SIunits.Angle incWall=IDEAS.Types.Tilt.Wall;
  parameter Modelica.SIunits.Angle aziSouth=IDEAS.Types.Azimuth.S;
  parameter Modelica.SIunits.Length hZone "Distance between floor and ceiling";

  Modelica.Blocks.Interfaces.RealInput[nSurf] inc "Surface inclination angles"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,40})));
  Modelica.Blocks.Interfaces.RealInput[nSurf] azi "Surface azimuth angles"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-40})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nSurf] port_a
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.Blocks.Interfaces.RealInput[nSurf] A "surface areas" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={40,100})));
  Modelica.Blocks.Interfaces.RealInput[nSurf] epsLw
    "longwave surface emissivities" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealOutput[nSurf] floorArea
    "Amount of floor area for each surface" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-104})));

protected
  final parameter Integer numAzi=4;
  parameter Real[nSurf,nSurf] vieFac(each fixed=false)
    "Emissivity weighted viewfactor from surface to surface"
    annotation (Dialog(tab="Advanced"));
  parameter Real[2 + numAzi] Atot(each fixed=false)
    "Total surface area per orientation";
  parameter Real[2 + numAzi] AtotInv(each fixed=false) "Inverse of Atot";
  parameter Real[2 + numAzi,2 + numAzi] vieFacTot(each fixed=false)
    "Emissivity weighted viewfactor from total of surfaces to each other"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Integer indexSurf[nSurf](fixed=false);
  parameter Modelica.SIunits.Area[nSurf] Afloor(each fixed=false);
  parameter Real rhoLw[nSurf](each fixed=false)
    "Longwave reflectivity of each surface";

  parameter Modelica.SIunits.Area[nSurf] APar(each fixed=false);
  parameter Modelica.SIunits.Angle[nSurf] incPar(each fixed=false);
  parameter Modelica.SIunits.Angle[nSurf] aziPar(each fixed=false);

  Modelica.SIunits.Irradiance[nSurf] J "Radiosity of each surface";
  Modelica.SIunits.Irradiance[nSurf] G "Irradiance of each surface";
  Real[nSurf] T4(unit="K4")
    "Dummy variable for facilitating linear algebraic loop";

initial equation
  rhoLw = ones(nSurf) - epsLw;
  APar = A;
  incPar = inc;
  aziPar = azi;
  AtotInv = Atot .^ (-1);

  for i in 1:nSurf loop
    //set floor area
    if IDEAS.Utilities.Math.Functions.isAngle(incPar[i], incFloor) then
      Afloor[i] = APar[i];
    else
      Afloor[i] = 0;
    end if;
  end for;

  Atot[1] = sum({(if IDEAS.Utilities.Math.Functions.isAngle(incPar[i],
    incCeiling) then APar[i] else 0) for i in 1:nSurf});
  Atot[2] = sum({(if IDEAS.Utilities.Math.Functions.isAngle(incPar[i], incFloor)
     then APar[i] else 0) for i in 1:nSurf});
  for j in 0:3 loop
    Atot[j + 3] = sum({(if (IDEAS.Utilities.Math.Functions.isAngle(incPar[i],
      incWall) or IDEAS.Utilities.Math.Functions.isAngle(incPar[i], incWall +
      Modelica.Constants.pi)) and IDEAS.Utilities.Math.Functions.isAngle(aziPar[
      i], aziSouth + j*Modelica.Constants.pi*2/numAzi) then APar[i] else 0)
      for i in 1:nSurf});
  end for;

  //view factor from ceiling/floor to floor/ceiling
  vieFacTot[1, 1] = 0;
  vieFacTot[2, 2] = 0;
  vieFacTot[1, 2] =
    IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.viewFactorRectRectPar(
    A=(Atot[1] + Atot[2])/2,
    d=hZone,
    l=(Atot[3] + Atot[5])/hZone/2);
  vieFacTot[2, 1] = vieFacTot[1, 2]*Atot[1]/Atot[2];

   assert(Atot[1] > 0, "Zone contains no ceiling surfaces. This needs to be fixed or explicit view factor calculation should be disabled.");
   assert(Atot[2] > 0, "Zone contains no floor surfaces. This needs to be fixed or explicit view factor calculation should be disabled.");
   for i in 3:6 loop
     assert(Atot[i] > 0, "Zone does not contain a surface for one of the walls");
   end for;

  for i in 3:numAzi + 2 loop
    vieFacTot[1, i] =
      IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.viewFactorRectRectPerp(
      lCommon=(Atot[i]/hZone),
      W1=hZone,
      W2=Atot[1]/(Atot[i]/hZone));
    vieFacTot[i, 1] = vieFacTot[1, i]*Atot[1]/Atot[i];
    vieFacTot[2, i] =
      IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.viewFactorRectRectPerp(
      lCommon=(Atot[i]/hZone),
      W1=hZone,
      W2=Atot[2]/(Atot[i]/hZone));
    vieFacTot[i, 2] = vieFacTot[2, i]*Atot[2]/Atot[i];
    // walls to walls
    for j in i:numAzi + 2 loop
      if i == j then
        //a wall does not irradiate itself
        vieFacTot[i, i] = 0;
      elseif Atot[i] == 0 or Atot[j] == 0 then
        vieFacTot[i, j] = 0;
        vieFacTot[j, i] = 0;
      elseif abs(i - j) == 1 or abs(i - j) == 3 then
        //surfaces are perpendicular
        vieFacTot[i, j] =
          IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.viewFactorRectRectPerp(
          lCommon=hZone,
          W1=Atot[j]/hZone,
          W2=Atot[i]/hZone);
        vieFacTot[j, i] = vieFacTot[i, j]*Atot[i]/Atot[j];
      elseif abs(i - j) == 2 then
        //surfaces are parallel
        vieFacTot[i, j] =
          IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.viewFactorRectRectPar(
          A=(Atot[i] + Atot[j])/2,
          d=Atot[integer((i + j)/2)]/hZone,
          l=hZone);
        vieFacTot[j, i] = vieFacTot[i, j]*Atot[i]/Atot[j];
      else
        //fixme warning
      end if;
    end for;

  end for;

  //compute index for each surface
  for i in 1:nSurf loop
    //determine orientation of first plane
    if IDEAS.Utilities.Math.Functions.isAngle(incPar[i], incCeiling) then
      indexSurf[i] = 1;
    elseif IDEAS.Utilities.Math.Functions.isAngle(incPar[i], incFloor) then
      indexSurf[i] = 2;
    elseif IDEAS.Utilities.Math.Functions.isAngle(incPar[i], incWall) then
      indexSurf[i] = sum({(if (IDEAS.Utilities.Math.Functions.isAngle(aziPar[i],
        aziSouth + k*Modelica.Constants.pi*2/numAzi)) then 2 + k + 1 else 0)
        for k in 0:numAzi - 1});
    else
      indexSurf[i] = 0;
      assert(false, "Chosen wall inclination angle not supported in view factor computation!");
    end if;
  end for;

  //view factors for real surfaces are computed from the total surface areas
  for i in 1:nSurf loop
    for j in 1:nSurf loop
      vieFac[i, j] = vieFacTot[indexSurf[i], indexSurf[j]]*APar[j]/Atot[
        indexSurf[j]];
    end for;
  end for;

equation
  T4 = port_a.T .^ 4;

  J = Modelica.Constants.sigma*T4 + rhoLw.*G;
  G = vieFac*J;
  port_a.Q_flow = APar .* (J - G);
  floorArea = Afloor;

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics),
    Icon(graphics={
        Rectangle(
          extent={{-90,80},{90,-80}},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Backward,
          lineColor={0,0,0}),
        Rectangle(
          extent={{68,60},{-68,-60}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(points={{-40,10},{40,10}}, color={191,0,0}),
        Line(points={{-40,10},{-30,16}}, color={191,0,0}),
        Line(points={{-40,10},{-30,4}}, color={191,0,0}),
        Line(points={{-40,-10},{40,-10}}, color={191,0,0}),
        Line(points={{30,-16},{40,-10}}, color={191,0,0}),
        Line(points={{30,-4},{40,-10}}, color={191,0,0}),
        Line(points={{-40,-30},{40,-30}}, color={191,0,0}),
        Line(points={{-40,-30},{-30,-24}}, color={191,0,0}),
        Line(points={{-40,-30},{-30,-36}}, color={191,0,0}),
        Line(points={{-40,30},{40,30}}, color={191,0,0}),
        Line(points={{30,24},{40,30}}, color={191,0,0}),
        Line(points={{30,36},{40,30}}, color={191,0,0}),
        Line(
          points={{-68,60},{68,60}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{68,60},{68,-60},{-68,-60},{-68,60}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>The exchange of longwave radiation in a zone has been previously described in the building component models and further considering the heat balance of the interior surface. Here, an expression based on <i>radiant interchange configuration factors</i> or <i>view factors</i> is avoided based on a delta-star transformation and by definition of a <i>radiant star temperature</i> <img src=\"modelica://IDEAS/Images/equations/equation-rE4hQkmG.png\"/>. Literature <a href=\"IDEAS.Buildings.UsersGuide.References\">[Liesen 1997]</a> shows that the overall model is not significantly sensitive to this assumption. This <img src=\"modelica://IDEAS/Images/equations/equation-rE4hQkmG.png\"/> can be derived from the law of energy conservation in the radiant star node as <img src=\"modelica://IDEAS/Images/equations/equation-iH8dRZqh.png\"/> must equal zero. Long wave radiation from internal sources are dealt with by including them in the heat balance of the radiant star node resulting in a diffuse distribution of the radiative source.</p>
</html>", revisions="<html>
<ul>
<li>
December 8, 2016, by Filip Jorissen:<br/>
Fixed bug in computation of vieFac and changed implementation
of computation such that radiosity and irradiance are computed.
</li>
</ul>
</html>"));
end ZoneLwDistributionViewFactor;
