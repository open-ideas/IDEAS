<div align="center">
<img src="IDEAS/Resources/Images/IDEAS-logo.png" height="115"> <b>v3.0.0</b>
</div>
<br>

IDEAS is a <i>Modelica</i> library for <b>I</b>ntegrated <b>D</b>istrict <b>E</b>nergy <b>A</b>ssessment <b>S</b>imulations. 
This free and open-source library enables simultaneous transient simulation of integrated thermal and electrical energy systems
including buildings at both individual (building) and collective (district) level.

The IDEAS library extends from the [Modelica IBPSA library](https://github.com/ibpsa/modelica-ibpsa) and has a particular focus
on the development of detailed building models. It is one of the four sister libraries that extend from the core Modelica IBPSA
library, alongside [AixLib](https://github.com/RWTH-EBC/AixLib), [Modelica Buildings](https://github.com/lbl-srg/modelica-buildings),
and [BuildingSystems](https://github.com/UdK-VPT/BuildingSystems).

## License
IDEAS is licensed by [KU Leuven](http://www.kuleuven.be) and [3E](http://www.3e.eu) under a 
[BSD 3 license](https://htmlpreview.github.io/?https://github.com/open-ideas/IDEAS/blob/master/IDEAS/legal.html).

## Community and contributions
We love to hear what you are using IDEAS for. You are welcome to open an issue on GitHub or contact the development team via
email to share your feedback. If you like our library, you can support IDEAS by starring it at the top right of our Github page.
Bug reports and feature suggestions can be submitted as [GitHub issues](https://github.com/open-ideas/IDEAS/issues), and
contributions in the form of [pull requests](https://github.com/open-ideas/IDEAS/pulls) are highly encouraged. Before submitting
a pull request, please consult the the IDEAS
[Style Guide and Conventions](https://github.com/open-ideas/IDEAS/wiki/Style%20Guide%20and%20GitHub%20Good%20Practice)
to ensure consistency with the project's conventions.

The IDEAS library was originally developed by KU Leuven and [3E](https://3e.eu), and is currently developed and maintained by
the [Thermal Systems Simulation (The SySi)](http://the.sysi.be) research group of KU Leuven. 
The library includes significant contributions by the [Building Physics and Sustainable Design Section](https://bwk.kuleuven.be/bwf)
of KU Leuven, the [Building Physics Research Group](https://www.ugent.be/ea/architectuur/en/research/research-groups/building-physics)
of UGent, [IBPSA project 1](https://ibpsa.github.io/project1/), [IEA EBC Annex 60](https://iea-annex60.org) and the
[Electrical Energy Systems and Applications Section](https://www.esat.kuleuven.be/electa) of KU Leuven.

## Tool support
IDEAS is fully compliant with the [Modelica Specification](https://specification.modelica.org/), and is therefore, in
principle, compatible with any simulation tool that supports this standard, such as Dymola or OpenModelica. However, as
IDEAS is primarily developed and maintained in Dymola, and the unit testing framework is exclusively implemented in Dymola,
certain compatibility issues with alternative tools may arise. Users are encouraged to report any deviations from the Modelica
specification or tool-specific issues so that these can be addressed in future updates.

## Unit testing
Unit testing is performed using Dymola in combination with BuildingsPy. Automated unit tests are executed via GitHub Actions,
utilising a self-hosted runner maintained by KU Leuven. Further information on the IDEAS unit testing framework is available
on the [IDEAS Wiki](https://github.com/open-ideas/IDEAS/wiki).

## Getting started
Two tutorials are provided at <code>IDEAS.Examples.Tutorial</code>, serving as demonstrations cases of how the IDEAS library
can be used.
1. <code>IDEAS.Examples.Tutorial.SimpleHouse</code> contains examples with step-by-step instructions for how to build a system
model for a simple house with a heating system, ventilation, and weather boundary conditions.
2. <code>IDEAS.Examples.Tutorial.DetailedHouse</code> ontains examples with step-by-step instructions for how to build a system
model for an office building (using the detailed building envelope component models within IDEAS.Buildings) with occupants, a
radiator heating system connected to a heat pump, and a ventilation system.

Furthermore, 
- <code>IDEAS.Buildings.Examples</code> and <code>IDEAS.Buildings.Components.Examples</code> contain examples focussing on the
building models, including individual features, developed in this library.
- <code>IDEAS.Examples.IBPSA</code> collects some models used in [BOPTEST](https://github.com/ibpsa/project1-boptest).
- <code>IDEAS.Examples.PPD12</code> is an example model of a terraced house, including a heating and ventilation system.
- <code>IDEAS.Examples.TwinHouses</code> is a model of the Holzkirchen twin house, used in a validation experiment.
 
See the documentation sections of the respective packages and models for more information.

## Citing IDEAS
Please cite IDEAS using the reference provided below.

```
@article{Jorissen2018ideas,  
author = {Jorissen, Filip and Reynders, Glenn and Baetens, Ruben and Picard, Damien and Saelens, Dirk and Helsen, Lieve},  
journal = {Journal of Building Performance Simulation},    
title = {{Implementation and Verification of the IDEAS Building Energy Simulation Library}},  
volume = {11},
issue = {6},  
pages = {669-688},
doi={10.1080/19401493.2018.1428361},  
year = {2018}  
}
```

## Release history
IDEAS v3.0.0 was released on May 3, 2022. This release includes an update to the Modelica Standard Library MSL 4.0.0.
Detailed release notes are available within the library under the following link:
[ReleaseNotes](https://github.com/open-ideas/IDEAS/tree/master/IDEAS/UsersGuide/ReleaseNotes).
Notes for the previous releases notes can also be found there. 

## Development and documentation of IDEAS
- K. De Jonge, F. Jorissen, L. Helsen, J. Laverge (2021).  Wind-Driven Air Flow Modelling in Modelica: Validation and Implementation in the IDEAS Library.  In Proceedings of the 17th IBPSA Conference. Bruges, Belgium, 1-3 September
- F. Jorissen, L. Helsen (2019). Integrated Modelica Model and Model Predictive Control of a Terraced House Using IDEAS. 13th International Modelica Conference. Regensburg, 4-6 March 2019.
- F. Jorissen, G. Reynders, R. Baetens, D. Picard, D. Saelens, and L. Helsen. (2018) [Implementation and Verification of the IDEAS Building Energy Simulation Library.](http://www.tandfonline.com/doi/full/10.1080/19401493.2018.1428361) *Journal of Building Performance Simulation*, **11** (6), 669-688, doi: 10.1080/19401493.2018.1428361.
- F. Jorissen, M. Wetter, L. Helsen (2018). Simplifications for hydronic system models in modelica. *Journal of Building Performance Simulation* **11** (6). 639-654
- F. Jorissen, W. Boydens, and L. Helsen. (2017) Validated air handling unit model using indirect evaporative cooling. *Journal of Building Performance Simulation*, **11** (1), 48–64, doi: 10.1080/19401493.2016.1273391
- B. van der Heijde, M. Fuchs,  C. Ribas Tugores, G. Schweiger, K. Sartor, D. Basciotti, D. Müller,C. Nytsch-Geusen, M. Wetter, L. Helsen (2017). Dynamic equation-based thermo-hydraulic pipe model for district heating and cooling systems. *Energy Conversion and Management*, **151**, 158-169.
- R. Baetens, D. Saelens. (2016) Modelling uncertainty in district energy simulations by stochastic residential occupant behaviour. *Journal of Building Performance Simulation* **9** (4), 431–447, doi:10.1080/19401493.2015.1070203.
- R. Baetens. (2015) On externalities of heat pump-based low-energy dwellings at the low-voltage distribution grid. PhD thesis, Arenberg Doctoral School, KU Leuven.
- R. Baetens, R. De Coninck, F. Jorissen, D. Picard, L. Helsen, D. Saelens (2015). OpenIDEAS - An Open Framework for Integrated District Energy Simulations. In Proceedings of Building Simulation 2015, Hyderabad, 347--354.
- D. Picard, F. Jorissen, L. Helsen (2015). Methodology for Obtaining Linear State Space Building Energy Simulation Models. 11th International Modelica Conference. International Modelica Conference. Paris, 21-23 September 2015 (pp. 51-58).
- M. Wetter, M. Fuchs, P. Grozman, L. Helsen, F. Jorissen, M. Lauster, M. Dirk, C. Nytsch-geusen, D. Picard, P. Sahlin, and M. Thorade. (2015) IEA EBC Annex 60 Modelica Library - An International Collaboration to Develop a Free Open-Source Model Library for Buildings and Community Energy Systems. In Proceedings of Building Simulation 2015, Hyderabad, 395–402.
- D. Picard, L. Helsen (2014). Advanced Hybrid Model for Borefield Heat Exchanger Performance Evaluation, an Implementation in Modelica. In Proceedings of the 10th International Modelica Conference. Lund, 857-866.
- D. Picard, L. Helsen (2014). A New Hybrid Model For Borefield Heat Exchangers Performance Evaluation. 2014 ASHRAE ANNUAL CONFERENCE: Vol. 120 (2). ASHRAE: Ground Source Heat Pumps: State of the Art Design, Performance and Research. Seattle, 1-8.

## Applications of IDEAS
IDEAS is widly used across various applications. To gain an overview of how the library has been applied, please consult the
[citations](https://www.tandfonline.com/doi/citedby/10.1080/19401493.2018.1428361) of the reference paper.


