To adapt in order to apply linearization
----------------------------------------

1) Use IDEAS issue79_linearizeBuilding

2) (optinal) In order to use the model both for linearization and for normal use, make all the additional inputs/outputs 
   conditional with sim.linearize.

3) make sure you use Buildings.Media.GasesConstantDensity.SimpleAir --> If there is state medium.Xi I got a big error!
4) add a weaBus WITH KEYWORD INPUT and connect it to each zone. The parameter numSolBus has to be = sim.numAzi + 1.
5) add output signal for your state space model
6) change all the windows by linearizableWindows
7) add winBus[nWin] WITH KEYWORD INPUT and connect them to each windows with parameter nLay=winName.glazing.nLay.

8) Make a new model in which you instantiate the model you want to linearize
9) add FIRSTLY input for convective heat flow, SECONDLY for radiative heat flow. For both of them, ADD START VALUE (of for example 100 W).
10) THIRDLY, add a weaBus WITH KEYWORD INPUT and connect it to each zone. The parameter numSolBus has to be = sim.numAzi + 1.
11) FINALLY add winBus[nWin] WITH KEYWORD INPUT with parameter nLay=winName.glazing.nLay. 

NOTE: it is important that the inputs are in the right order in the code, as their index for the state space depends of their order.

12) add output signal for your state space model
13) Add system and sim (make sure they are inner) and change sim.linearize to true.
14) Make sure you do not have more than 4 orientations perpendicular to each other and that sim.offsetAzi equals one of the angle.

15) Linearize the model

----------------------------------------
Debug:
1) make sure there is max 4 orientations, all perpendicular, only horizontal or vertical surfaces.
Easy way to check: simulate your model with linearise = true and check in 'solDataInBus' off all components is True.
