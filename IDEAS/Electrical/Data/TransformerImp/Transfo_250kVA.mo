within IDEAS.Electrical.Data.TransformerImp;
record Transfo_250kVA =
                IDEAS.Electrical.Data.Interfaces.TransformerImp (
    Sn=250e3,
    P0=365,
    Zd=0.0126 + 0.0445*Modelica.ComplexMath.j) "250 kVA transformer";
