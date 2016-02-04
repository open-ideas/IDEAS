within IDEAS.Electrical.Data.TransformerImp;
record Transfo_400kVA =
                IDEAS.Electrical.Data.Interfaces.TransformerImp (
    Sn=400e3,
    P0=515,
    Zd=0.00740 + 0.0291*Modelica.ComplexMath.j) "400 kVA transformer";
