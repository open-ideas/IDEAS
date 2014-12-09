within IDEAS.Fluid.Production.Data.PerformanceMaps;
record Boiler3D "A 3D performance map for a Boiler"

  extends IDEAS.Fluid.Production.BaseClasses.PartialData(
     use_3DHeatSource = true,
     QNomRef=10100,
     etaRef=0.922,
     modulationMin=10,
     modulationStart=20,
     TMax=273.15+80,
     TMin=273.15+20,
     numberOfModulations=6,
     performanceMap=
     { IDEAS.Utilities.Tables.Plane(height=0, curve=
       [0, 100, 400, 700, 1000, 1300; 20.0, 0, 0, 0, 0,
          0; 30.0, 0, 0, 0, 0, 0; 40.0, 0, 0,
          0, 0, 0; 50.0, 0, 0, 0, 0, 0;
          60.0, 0, 0, 0, 0, 0; 70.0, 0, 0,
          0, 0, 0; 80.0, 0, 0, 0, 0, 0]),
       IDEAS.Utilities.Tables.Plane(height=20, curve=
       [0, 100, 400, 700, 1000, 1300; 20.0, 0.9969, 0.9987, 0.999, 0.999,
          0.999; 30.0, 0.9671, 0.9859, 0.99, 0.9921, 0.9934; 40.0, 0.9293, 0.9498,
          0.9549, 0.9575, 0.9592; 50.0, 0.8831, 0.9003, 0.9056, 0.9083, 0.9101;
          60.0, 0.8562, 0.857, 0.8575, 0.8576, 0.8577; 70.0, 0.8398, 0.8479,
          0.8481, 0.8482, 0.8483; 80.0, 0.8374, 0.8384, 0.8386, 0.8387, 0.8388]),
       IDEAS.Utilities.Tables.Plane(height=40, curve=
       [0, 100, 400, 700, 1000, 1300; 20.0, 0.9624, 0.9947, 0.9985, 0.9989,
          0.999; 30.0, 0.9333, 0.9661, 0.9756, 0.9803, 0.9833; 40.0, 0.901,
          0.9306, 0.94, 0.9451, 0.9485; 50.0, 0.8699, 0.8871, 0.8946, 0.8989,
          0.9018; 60.0, 0.8626, 0.8647, 0.8651, 0.8653, 0.8655; 70.0, 0.8553,
          0.8573, 0.8577, 0.8579, 0.8581; 80.0, 0.8479, 0.8499, 0.8503, 0.8505,
          0.8506]),
       IDEAS.Utilities.Tables.Plane(height=60, curve=
       [0, 100, 400, 700, 1000, 1300; 20.0, 0.9349, 0.9759, 0.9879, 0.9941,
          0.998; 30.0, 0.9096, 0.9471, 0.9595, 0.9664, 0.9709; 40.0, 0.8831,
          0.9136, 0.9247, 0.9313, 0.9357; 50.0, 0.8701, 0.8759, 0.8838, 0.8887,
          0.8921; 60.0, 0.8634, 0.8666, 0.8672, 0.8675, 0.8677; 70.0, 0.8498,
          0.8599, 0.8605, 0.8608, 0.861; 80.0, 0.8488, 0.8532, 0.8538, 0.8541,
          0.8543]),
       IDEAS.Utilities.Tables.Plane(height=80, curve=
       [0, 100, 400, 700, 1000, 1300; 20.0, 0.9015, 0.9441, 0.9599, 0.9691,
          0.9753; 30.0, 0.8824, 0.9184, 0.9324, 0.941, 0.9471; 40.0, 0.8736,
          0.8909, 0.902, 0.9092, 0.9143; 50.0, 0.8676, 0.8731, 0.8741, 0.8746,
          0.8774; 60.0, 0.8, 0.867, 0.8681, 0.8686, 0.8689; 70.0, 0.8, 0.8609,
          0.8619, 0.8625, 0.8628; 80.0, 0.8, 0.8547, 0.8558, 0.8563, 0.8566]),
       IDEAS.Utilities.Tables.Plane(height=100, curve=
       [0, 100, 400, 700, 1000, 1300; 20.0, 0.9015, 0.9441, 0.9599, 0.9691,
          0.9753; 30.0, 0.8824, 0.9184, 0.9324, 0.941, 0.9471; 40.0, 0.8736,
          0.8909, 0.902, 0.9092, 0.9143; 50.0, 0.8676, 0.8731, 0.8741, 0.8746,
          0.8774; 60.0, 0.8, 0.867, 0.8681, 0.8686, 0.8689; 70.0, 0.8, 0.8609,
          0.8619, 0.8625, 0.8628; 80.0, 0.8, 0.8547, 0.8558, 0.8563, 0.8566])});
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Documentation(info="<html>
<p><b>Description</b> </p>
<p>Performance map for a condensing boiler from Remeha.</p>
<p>The&nbsp;nominal&nbsp;power&nbsp;of&nbsp;the&nbsp;original&nbsp;boiler&nbsp;is&nbsp;10.1&nbsp;kW&nbsp;at &nbsp;50/30 degC&nbsp;water&nbsp;temperatures.&nbsp;&nbsp;&nbsp;The&nbsp;efficiency&nbsp;in&nbsp;this&nbsp;point&nbsp;is&nbsp;92.2&percnt;&nbsp;on&nbsp;higher&nbsp;heating&nbsp;value.&nbsp;</p>
</html>", revisions="<html>
<p><ul>
<li>2014 May, Damien Picard: change Modelica.Math.Interpolate to IDEAS.Utilities.Math.Functions.cubicHermiteLinearExtrapolation in order to remove non-differentiable equations </li>
<li>2014 May, Damien Picard: correct bug introduced during conversion to Annex on the QAsked </li>
<li>2013 May, Roel De Coninck: documentation</li>
<li>2011 August, Roel De Coninck: first version</li>
</ul></p>
</html>"));
end Boiler3D;
