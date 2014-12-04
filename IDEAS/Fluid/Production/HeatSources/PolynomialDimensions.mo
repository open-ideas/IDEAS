within IDEAS.Fluid.Production.HeatSources;
function PolynomialDimensions "Function to calculate the output of a polynomial based on the number of
  inputs and the degree"

  //Dimensions of the power matrix nxk
  input Integer n;
  input Integer k;

  //Constants
  input Real beta[n];

  //Powers
  input Integer powers[n,k];

  //Inputs
  input Real[k-1] X;

  //Output
  output Real result;

  //Variables
protected
  Real variables[k];
  Real term;

algorithm
   variables[1] :=1;
   for i in 2:k loop
     variables[i] := X[i-1];
   end for;

  result := 0;

  for i in 1:n loop
    term := beta[i];
    for j in 1:k loop
      if variables[j]<=0 and powers[i,j] <=0 then
        term := term;
      else
        term := term * variables[j]^powers[i,j];
      end if;
    end for;
    result := result + term;
  end for;

end PolynomialDimensions;
