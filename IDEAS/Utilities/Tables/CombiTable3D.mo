within IDEAS.Utilities.Tables;
block CombiTable3D "Table look-up in three dimensions (matrix/file)"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer nDim1(min=1) "Number of elements in dimension 1";
  parameter Integer nDim2(min=1) "Number of elements in dimension 2";
  parameter Integer nDim3(min=1, max=7) "Number of elements in dimension 3";

  parameter Real indicesDim1[nDim1];
  parameter Real indicesDim2[nDim2];
  parameter Real indicesDim3[nDim3];

  parameter Real table1[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for first entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table2[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for second entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table3[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for third entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table4[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for fourth entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table5[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for fifth entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table6[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for sixth entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table7[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for seventh entry of dimension 3"
    annotation (Dialog(group="Table data definition"));

  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation"
    annotation (Dialog(group="Table data interpretation"));


  parameter Boolean is2Dtable = false "Ignore third dimension and use data from table1";

  Modelica.Blocks.Interfaces.RealInput u1 "Connector of Real input signal 1" annotation (Placement(
        transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput u2 "Connector of Real input signal 2" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput u3 "Connector of Real input signal 3" annotation (Placement(
        transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));

protected
  Integer i "Index for third dimension";
  Real y1;
  Real y2;
  Real frac;

  Modelica.Blocks.Types.ExternalCombiTable2D tableID1=
      Modelica.Blocks.Types.ExternalCombiTable2D(
        "NoName",
        "NoName",
        cat(1,cat(2,{{0}},{indicesDim2}),cat(2,transpose({indicesDim1}),table1)),
        smoothness) "External table object";
   Modelica.Blocks.Types.ExternalCombiTable2D tableID2=
      Modelica.Blocks.Types.ExternalCombiTable2D(
        "NoName",
        "NoName",
        cat(1,cat(2,{{0}},{indicesDim2}),cat(2,transpose({indicesDim1}),table2)),
        smoothness) "External table object";
   Modelica.Blocks.Types.ExternalCombiTable2D tableID3=
      Modelica.Blocks.Types.ExternalCombiTable2D(
        "NoName",
        "NoName",
        cat(1,cat(2,{{0}},{indicesDim2}),cat(2,transpose({indicesDim1}),table3)),
        smoothness) "External table object";
   Modelica.Blocks.Types.ExternalCombiTable2D tableID4=
      Modelica.Blocks.Types.ExternalCombiTable2D(
        "NoName",
        "NoName",
        cat(1,cat(2,{{0}},{indicesDim2}),cat(2,transpose({indicesDim1}),table4)),
        smoothness) "External table object";
   Modelica.Blocks.Types.ExternalCombiTable2D tableID5=
      Modelica.Blocks.Types.ExternalCombiTable2D(
        "NoName",
        "NoName",
        cat(1,cat(2,{{0}},{indicesDim2}),cat(2,transpose({indicesDim1}),table5)),
        smoothness) "External table object";
    Modelica.Blocks.Types.ExternalCombiTable2D tableID6=
      Modelica.Blocks.Types.ExternalCombiTable2D(
        "NoName",
        "NoName",
        cat(1,cat(2,{{0}},{indicesDim2}),cat(2,transpose({indicesDim1}),table6)),
        smoothness) "External table object";
    Modelica.Blocks.Types.ExternalCombiTable2D tableID7=
      Modelica.Blocks.Types.ExternalCombiTable2D(
        "NoName",
        "NoName",
        cat(1,cat(2,{{0}},{indicesDim2}),cat(2,transpose({indicesDim1}),table7)),
        smoothness) "External table object";

  function getTableValue "Interpolate 2-dim. table defined by matrix"
    extends Modelica.Icons.Function;
    input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
    input Real u1;
    input Real u2;
    input Real tableAvailable
      "Dummy input to ensure correct sorting of function calls";
    output Real y;
    external"C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2)
      annotation (Library={"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
    annotation (derivative(noDerivative=tableAvailable) = getDerTableValue);
  end getTableValue;

  function getTableValueNoDer
    "Interpolate 2-dim. table defined by matrix (but do not provide a derivative function)"
    extends Modelica.Icons.Function;
    input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
    input Real u1;
    input Real u2;
    input Real tableAvailable
      "Dummy input to ensure correct sorting of function calls";
    output Real y;
    external"C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2)
      annotation (Library={"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
  end getTableValueNoDer;

  function getDerTableValue
    "Derivative of interpolated 2-dim. table defined by matrix"
    extends Modelica.Icons.Function;
    input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
    input Real u1;
    input Real u2;
    input Real tableAvailable
      "Dummy input to ensure correct sorting of function calls";
    input Real der_u1;
    input Real der_u2;
    output Real der_y;
    external"C" der_y = ModelicaStandardTables_CombiTable2D_getDerValue(tableID, u1, u2, der_u1, der_u2)
      annotation (Library={"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
  end getDerTableValue;

algorithm
  i:=1;
  if is2Dtable then
    y1:=0;
    y2:=0;
    frac:=0;
      if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
        y :=getTableValueNoDer(
          tableID1,
          u1,
          u2,
          1);
      else
        y :=getTableValue(
          tableID1,
          u1,
          u2,
          1);
      end if;
  else

    for i in 1:(nDim3-1) loop
      if u3>=indicesDim3[i] and u3 <= indicesDim3[i+1] or u3<=indicesDim3[1] then
        break;
      end if;
    end for;
    if i == 1 then
      if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
        y1 :=getTableValueNoDer(
          tableID1,
          u1,
          u2,
          1);
        y2 :=getTableValueNoDer(
          tableID2,
          u1,
          u2,
          1);
      else
        y1 :=getTableValue(
          tableID1,
          u1,
          u2,
          1);
        y2 :=getTableValue(
          tableID2,
          u1,
          u2,
          1);
      end if;
    elseif i == 2 then
      if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
        y1 :=getTableValueNoDer(
          tableID2,
          u1,
          u2,
          1);
        y2 :=getTableValueNoDer(
          tableID3,
          u1,
          u2,
          1);
      else
        y1 :=getTableValue(
          tableID2,
          u1,
          u2,
          1);
        y2 :=getTableValue(
          tableID3,
          u1,
          u2,
          1);
      end if;
    elseif i == 3 then
      if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
        y1 :=getTableValueNoDer(
          tableID3,
          u1,
          u2,
          1);
        y2 :=getTableValueNoDer(
          tableID4,
          u1,
          u2,
          1);
      else
        y1 :=getTableValue(
          tableID3,
          u1,
          u2,
          1);
        y2 :=getTableValue(
          tableID4,
          u1,
          u2,
          1);
      end if;
    elseif i == 4 then
      if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
        y1 :=getTableValueNoDer(
          tableID4,
          u1,
          u2,
          1);
        y2 :=getTableValueNoDer(
          tableID5,
          u1,
          u2,
          1);
      else
        y1 :=getTableValue(
          tableID4,
          u1,
          u2,
          1);
        y2 :=getTableValue(
          tableID5,
          u1,
          u2,
          1);
      end if;
    elseif i == 5 then
      if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
        y1 :=getTableValueNoDer(
          tableID5,
          u1,
          u2,
          1);
        y2 :=getTableValueNoDer(
          tableID6,
          u1,
          u2,
          1);
      else
        y1 :=getTableValue(
          tableID5,
          u1,
          u2,
          1);
        y2 :=getTableValue(
          tableID6,
          u1,
          u2,
          1);
      end if;
    else
      if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
        y1 :=getTableValueNoDer(
          tableID6,
          u1,
          u2,
          1);
        y2 :=getTableValueNoDer(
          tableID7,
          u1,
          u2,
          1);
      else
        y1 :=getTableValue(
          tableID6,
          u1,
          u2,
          1);
        y2 :=getTableValue(
          tableID7,
          u1,
          u2,
          1);
      end if;
    end if;

    frac:=(u3-indicesDim3[i])/(indicesDim3[i+1]-indicesDim3[i]);
    y:=frac*y2 + (1 - frac)*y1;
  end if;



  annotation (
    Documentation(info="<html>
<p>
<b>Linear interpolation</b> in <b>two</b> dimensions of a <b>table</b>.
The grid points and function values are stored in a matrix \"table[i,j]\",
where:
</p>
<ul>
<li> the first column \"table[2:,1]\" contains the u[1] grid points,</li>
<li> the first row \"table[1,2:]\" contains the u[2] grid points,</li>
<li> the other rows and columns contain the data to be interpolated.</li>
</ul>
<p>
Example:
</p>
<pre>
           |       |       |       |
           |  1.0  |  2.0  |  3.0  |  // u2
       ----*-------*-------*-------*
       1.0 |  1.0  |  3.0  |  5.0  |
       ----*-------*-------*-------*
       2.0 |  2.0  |  4.0  |  6.0  |
       ----*-------*-------*-------*
     // u1
   is defined as
      table = [0.0,   1.0,   2.0,   3.0;
               1.0,   1.0,   3.0,   5.0;
               2.0,   2.0,   4.0,   6.0]
   If, e.g., the input u is [1.0;1.0], the output y is 1.0,
       e.g., the input u is [2.0;1.5], the output y is 3.0.
</pre>
<ul>
<li> The interpolation is <b>efficient</b>, because a search for a new
     interpolation starts at the interval used in the last call.</li>
<li> If the table has only <b>one element</b>, the table value is returned,
     independent of the value of the input signal.</li>
<li> If the input signal <b>u1</b> or <b>u2</b> is <b>outside</b> of the defined
     <b>interval</b>, the corresponding value is also determined by linear
     interpolation through the last or first two points of the table.</li>
<li> The grid values (first column and first row) have to be strictly
     increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li> Explicitly supplied as <b>parameter matrix</b> \"table\",
     and the other parameters have the following values:
<pre>
   tableName is \"NoName\" or has only blanks,
   fileName  is \"NoName\" or has only blanks.
</pre></li>
<li> <b>Read</b> from a <b>file</b> \"fileName\" where the matrix is stored as
      \"tableName\". Both ASCII and MAT-file format is possible.
      (The ASCII format is described below).
      The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
      The library supports at least v4, v6 and v7 whereas v7.3 is optional.
      It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
      by command
<pre>
   save tables.mat tab1 tab2 tab3
</pre>
      or Scilab by command
<pre>
   savematfile tables.mat tab1 tab2 tab3
</pre>
      when the three tables tab1, tab2, tab3 should be used from the model.<br>
      Note, a fileName can be defined as URI by using the helper function
      <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</li>
<li>  Statically stored in function \"usertab\" in file \"usertab.c\".
      The matrix is identified by \"tableName\". Parameter
      fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
      preferred as otherwise the table is reallocated and transposed.
      See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
      documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If tables are read from an ASCII-file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<pre>
-----------------------------------------------------
#1
double table2D_1(3,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0

double table2D_2(4,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0
3.0  3.0  5.0  7.0
-----------------------------------------------------
</pre>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Other characters, like trailing non comments, are not allowed in the file.
The matrix elements are interpreted in exactly the same way
as if the matrix is given as a parameter. For example, the first
column \"table2D_1[2:,1]\" contains the u[1] grid points,
and the first row \"table2D_1[1,2:]\" contains the u[2] grid points.
</p>

<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"),
    Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
    Line(points={{0.0,40.0},{0.0,-40.0}}),
    Line(points={{-60.0,40.0},{-30.0,20.0}}),
    Line(points={{-30.0,40.0},{-60.0,20.0}}),
    Rectangle(origin={2.3077,-0.0},
      fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-62.3077,0.0},{-32.3077,20.0}}),
    Rectangle(origin={2.3077,-0.0},
      fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-62.3077,-20.0},{-32.3077,0.0}}),
    Rectangle(origin={2.3077,-0.0},
      fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-62.3077,-40.0},{-32.3077,-20.0}}),
    Rectangle(fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-30.0,20.0},{0.0,40.0}}),
    Rectangle(fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{0.0,20.0},{30.0,40.0}}),
    Rectangle(origin={-2.3077,-0.0},
      fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{32.3077,20.0},{62.3077,40.0}})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-60,60},{60,-60}},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{60,0},{100,0}}, color={0,0,255}),
        Text(
          extent={{-100,100},{100,64}},
          lineColor={0,0,255},
          textString="3 dimensional linear table interpolation"),
        Line(points={{-54,40},{-54,-40},{54,-40},{54,40},{28,40},{28,-40},{-28,
              -40},{-28,40},{-54,40},{-54,20},{54,20},{54,0},{-54,0},{-54,-20},
              {54,-20},{54,-40},{-54,-40},{-54,40},{54,40},{54,-40}}, color={
              0,0,0}),
        Line(points={{0,40},{0,-40}}),
        Rectangle(
          extent={{-54,20},{-28,0}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,0},{-28,-20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,-20},{-28,-40}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-28,40},{0,20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,40},{28,20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{28,40},{54,20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-54,40},{-28,20}}),
        Line(points={{-28,40},{-54,20}}),
        Text(
          extent={{-54,-40},{-30,-56}},
          textString="u1",
          lineColor={0,0,255}),
        Text(
          extent={{28,58},{52,44}},
          textString="u2",
          lineColor={0,0,255}),
        Text(
          extent={{-2,12},{32,-22}},
          textString="y",
          lineColor={0,0,255})}));
end CombiTable3D;
