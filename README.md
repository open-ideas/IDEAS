IDEAS v3.0.0
============
Modelica model environment for Integrated District Energy Assessment Simulations (IDEAS), allowing simultaneous transient simulation of thermal and electrical systems at both building and feeder level. This Modelica library was originally developed by KU Leuven and [3E](https://3e.eu) and is currently developed and maintained by the [Thermal Systems Simulation (The SySi)](http://the.sysi.be) research group of KU Leuven. It includes significant contributions by the [Building Physics and Sustainable Design Section](https://bwk.kuleuven.be/bwf) of KU Leuven, the [Building Physics Research Group](https://www.ugent.be/ea/architectuur/en/research/research-groups/building-physics) of UGent, [IBPSA project 1](https://ibpsa.github.io/project1/), [IEA EBC Annex 60](https://iea-annex60.org) and the [Electrical Energy Systems and Applications Section](https://www.esat.kuleuven.be/electa) of KU Leuven. 

## Release history
+ April 11th, 2022: IDEAS v3.0.0 has been released. This includes an update to MSL 4.0.0.
+ April 2nd, 2022: IDEAS v2.2.2 has been released. This is the final release before updating MSL 4.0.0.
+ September 20th, 2021: IDEAS v2.2.1 has been released.
+ June 9th, 2021: IDEAS v2.2 has been released.
+ February 28th, 2019: IDEAS v2.1 has been released.
+ September 28th, 2018: IDEAS v2.0 has been released.
+ May 5th, 2017: IDEAS v1.0 has been released.  
   February 16th 2018: A [paper describing IDEAS v1.0](http://www.tandfonline.com/doi/full/10.1080/19401493.2018.1428361) has been published on line.
+ September 2nd, 2015: IDEAS v0.3 has been released.

## Contributions and community
We love to hear what you are using IDEAS for. Feel free to open an issue to provide feedback or contact us through mail. If you like our library, you can support us by adding a star at the top right of our Github page.

## Tool support
Our goal is to provide support for Dymola and OpenModelica. Consequantly, any tool that supports the full Modelica specification should be able to run our models. Feel free to file a bug report in case we do not adhere to the Modelica specification.

## Release notes
[This is a link to detailed release notes.](https://github.com/open-ideas/IDEAS/blob/master/ReleaseNotes.md)

## Unit tests
The library is unit tested using BuildingsPy. Automated unit tests have been removed since the required services are no longer freely available. The master branch is still unit tested manually. See IDEAS/RunUnitTests.py to run the unit tests yourself.

## License
IDEAS is licensed by [KU Leuven](http://www.kuleuven.be) and [3E](http://www.3e.eu) under a [BSD 3 license](https://htmlpreview.github.io/?https://github.com/open-ideas/IDEAS/blob/master/IDEAS/legal.html).

<!-- ### Development and contribution

1. You may report any bugfixes or suggestions as a [github issue](https://github.com/open-ideas/IDEAS/issues).
2. Contributions in the form of [Pull Requests](https://help.github.com/articles/using-pull-requests) are always welcome. Prior to issuing a pull request, make sure :
    1. your code follows the [Style Guide and Conventions](https://github.com/open-ideas/IDEAS/wiki/Style%20Guide%20and%20GitHub%20Good%20Practice),
    2. you use this **IDEAS** GitHub repository as described in the [GitHub Good Practice Description](https://github.com/open-ideas/IDEAS/wiki/Style%20Guide%20and%20GitHub%20Good%20Practice)
    3. unittests are included for your models, and
    4. the model physics are described in the [Specifications](https://github.com/open-ideas/IDEAS/tree/master/Specifications). -->

## References
### Development of IDEAS
 - F. Jorissen, G. Reynders, R. Baetens, D. Picard, D. Saelens, and L. Helsen. (2018) [Implementation and Verification of the IDEAS Building Energy Simulation Library.](http://www.tandfonline.com/doi/full/10.1080/19401493.2018.1428361) *Journal of Building Performance Simulation*, **11** (6), 669-688, doi: 10.1080/19401493.2018.1428361.
 - R. Baetens, R. De Coninck, F. Jorissen, D. Picard, L. Helsen, D. Saelens (2015). OpenIDEAS - An Open Framework for Integrated District Energy Simulations. In Proceedings of Building Simulation 2015, Hyderabad, 347--354.
 - R. Baetens. (2015) On externalities of heat pump-based low-energy dwellings at the low-voltage distribution grid. PhD thesis, Arenberg Doctoral School, KU Leuven.
 - F. Jorissen, W. Boydens, and L. Helsen. (2017) Validated air handling unit model using indirect evaporative cooling. *Journal of Building Performance Simulation*, **11** (1), 48–64, doi: 10.1080/19401493.2016.1273391
 - R. Baetens, D. Saelens. (2016) Modelling uncertainty in district energy simulations by stochastic residential occupant behaviour. *Journal of Building Performance Simulation* **9** (4), 431–447, doi:10.1080/19401493.2015.1070203.
 - M. Wetter, M. Fuchs, P. Grozman, L. Helsen, F. Jorissen, M. Lauster, M. Dirk, C. Nytsch-geusen, D. Picard, P. Sahlin, and M. Thorade. (2015) IEA EBC Annex 60 Modelica Library - An International Collaboration to Develop a Free Open-Source Model Library for Buildings and Community Energy Systems. In Proceedings of Building Simulation 2015, Hyderabad, 395–402.
 - B. van der Heijde, M. Fuchs,  C. Ribas Tugores, G. Schweiger, K. Sartor, D. Basciotti, D. Müller,C. Nytsch-Geusen, M. Wetter, L. Helsen (2017). Dynamic equation-based thermo-hydraulic pipe model for district heating and cooling systems. *Energy Conversion and Management*, **151**, 158-169.
 - D. Picard, L. Helsen (2014). Advanced Hybrid Model for Borefield Heat Exchanger Performance Evaluation, an Implementation in Modelica. In Proceedings of the 10th International Modelica Conference. Lund, 857-866.
 - D. Picard, L. Helsen (2014). A New Hybrid Model For Borefield Heat Exchangers Performance Evaluation. 2014 ASHRAE ANNUAL CONFERENCE: Vol. 120 (2). ASHRAE: Ground Source Heat Pumps: State of the Art Design, Performance and Research. Seattle, 1-8.
 - Picard D., Jorissen F., Helsen L. (2015). Methodology for Obtaining Linear State Space Building Energy Simulation Models. 11th International Modelica Conference. International Modelica Conference. Paris, 21-23 September 2015 (pp. 51-58).
 - F. Jorissen, L. Helsen (2019). Integrated Modelica Model and Model Predictive Control of a Terraced House Using IDEAS. 13th International Modelica Conference. Regensburg, 4-6 March 2019.

### Applications of IDEAS
 - D. Picard. (2017) Modeling, optimal control and HVAC design of large buildings using ground source heat pump systems. PhD thesis, Arenberg Doctoral School, KU Leuven.
 - G. Reynders. (2015) Quantifying the impact of building design on the potential of structural storage for active demand response in residential buildings. PhD thesis, Arenberg Doctoral School, KU Leuven.
 - R. De Coninck. (2015) Grey-box based optimal control for thermal systems in buildings - Unlocking energy efficiency and flexibility. PhD thesis, Arenberg Doctoral School, KU Leuven.
 - G. Reynders, T. Nuytten, D. Saelens. (2013) Potential of structural thermal mass for demand-side management in dwellings. *Building and Environment* **64**, 187–199, doi:10.1016/j.buildenv.2013.03.010.
 - R. De Coninck, R. Baetens, D. Saelens, A. Woyte, L. Helsen (2014). Rule-based demand side management of domestic hot water production with heat pumps in zero energy neighbourhoods. *Journal of Building Performance Simulation*, **7** (4), 271-288.
 - R. Baetens, R. De Coninck, J. Van Roy, B. Verbruggen, J. Driesen, L. Helsen, D. Saelens (2012). Assessing electrical bottlenecks at feeder level for residential net zero-energy buildings by integrated system simulation. *Applied Energy*, **96**, 74-83.
 - G. Reynders, J. Diriken, D. Saelens. (2014) Quality of grey-box models and identified parameters as function of the accuracy of input and observation signals. *Energy & Buildings* **82**, 263–274, doi:10.1016/j.enbuild.2014.07.025.
 - F. Jorissen, L. Helsen,  M. Wetter (2015). Simulation Speed Analysis and Improvements of Modelica Models for Building Energy Simulation. In Proceedings of the 11th International Modelica Conference. Paris, 59-69.
 - C. Protopapadaki, G. Reynders, D. Saelens (2014). Bottom-up modeling of the Belgian residential building stock: impact of building stock descriptions. In Proceedings of the 9th International Conference on System Simulation in Buildings. Liège.
 - G. Reynders, J. Diriken, D. Saelens (2014). Bottom-up modeling of the Belgian residential building stock: impact of model complexity. In Proceedings of the 9th International Conference on System Simulation in Buildings. Liège.
 - E. Van Kenhove, A. Aertgeerts, J. Laverge, A. Janssens (2015). Energy Efficient Renovation of Heritage Residential Buildings Using Modelica Simulations. In Proceedings of Building Simulation 2015: 14th Conference of IBPSA. Hyderabad, 535–542.
 - G. Reynders, J. Diriken, D. Saelens (2015). Impact of the heat emission system on the indentification of grey-box models for residential buildings. *Energy Procedia* **78**, 3300-3305, doi: 10.1016/j.egypro.2015.11.740.
 - I. De Jaeger, G. Reynders, D. Saelens (2017). Impact of spacial accuracy on district energy simulations. *Energy Procedia* **132**, 561-566, doi: 10.1016/j.egypro.2017.09.741
 - G. Reynders, R. Andriamamonjy, R. Klein, D. Saelens (2017). Towards an IFC-Modelica Tool Facilitating Model Complexity Selection for Building Energy Simulation. In Proceedings of the 15th Conference of the IBPSA Conference. California.
 - G. Reynders, J. Diriken, D. Saelens (2017). Generic characterization method for energy flexibility: Applied to structural thermal storage in residential buildings. *Applied Energy* **198**, 192-202, doi: 10.1016/j.apenergy.2017.04.061
 - F. Jorissen. (2018) Toolchain for optimal control and design of energy systems in buildings. PhD thesis, Arenberg Doctoral School, KU Leuven.
 - Picard D., Sourbron M., Jorissen F., Vana Z., Cigler J., Ferkl L., Helsen L. (2016). Comparison of Model Predictive Control Performance Using Grey-Box and White-Box Controller Models of a Multi-zone Office Building. International High Performance Buildings Conference. West Lafayette, 11-14 July 2016 (art.nr. 203).
 - F. Jorissen, W. Boydens, L. Helsen (2019) Model implementation and verification of the envelope, HVAC and controller of an office building in Modelica. *Journal of Building Performance Simulation
 - F. Jorissen, D. Picard, K. Six, L. Helsen (2021) Detailed White-Box Non-Linear Model Predictive Control for Scalable Building HVAC Control. In Proceedings of the 14th Modelica Conference 2021. Online.
 - F. Jorissen, D. Picard, L Helsen (2021). Strengths of Non-Linear White-Box MPC for Building HVAC Control. In Proceedings of the 17th IBPSA Conference. Bruges, Belgium, 1-3 September 2021.
 - A. Erfani Beyzaee, X. Yu, T.M. Kull, P. Bacher, T. Jafarinejad, and S. Roels (2021). Analysis of the impact of predictive models on the quality of the model predictive control for an experimental building. In Proceedings of the 17th IBPSA Conference. Bruges, 1-3 September 2021.
 - G. Reynders, A. Erfani Beyzaee, D. Saelens (2021). IEA EBC Annex71: Building energy performance assessment based on in-situ measurements.
 - D. Blum, J. Arroyo, S. Huang, J. Drgona, F. Jorissen, H. Taxt Walnum, C. Yan, K. Benne, D. Vrabie, M. Wetter, L. Helsen (2021). Building Optimization Testing Framework (BOPTEST) for Simulation-Based Benchmarking of Control Strategies in Buildings. *Journal of Building Performance Simulation* **14** (5), 586–610.
 - W. Boydens, S. Feyaerts, A. Vandermeulen, L. Helsen (2021). Control strategy assessment of a small GSHP sourced DH system with end user DHW booster heat pumps. In Proceedings of the 13th IEA Heat Pump Conference. Jeju, art.nr. 301.
 - J. Jansen, F. Maertens, W. Boydens, L. Helsen (2021). Living lab 'De Schipjes': a zero-fossil-fuel energy concept in the historic city center of Bruges. In Proceedings of Building Simulation 2021: 17th Conference of IBPSA. Bruges.
 - J. Arroyo, C. Manna, F. Spiessens, L. Helsen (2021). An OpenAI-Gym environment for the Building Optimization Testing (BOPTEST) framework. In Proceedings of the 17th IBPSA Conference. Bruges, Belgium, 1-3 September 2021.
 - J. Arroyo, F. Spiessens, L. Helsen (2022). Comparison of Model Complexities in Optimal Control Tested in a Real Thermally Activated Building System. *Buildings*, **12** (5).
 - J. Arroyo, F. Spiessens, L. Helsen (2022). Comparison of Optimal Control Techniques for Building Energy Management. *Frontiers in Built Environment, section Indoor Environment. Research Topic: Artificial Intelligence Applications in Building’s Thermal Management*, **8**.
 - J. Arroyo, C. Manna, F. Spiessens, L. Helsen (2022). Reinforced Model Predictive Control (RL-MPC) for Building Energy Management. *Applied Energy*, **309**.
 - J. Jansen, L. Helsen (2022). Non-linear model predictive control of a small-scale 4th generation district heating network with on/off heat pumps. In Proceedings of the 2nd International Sustainable Energy Conference. Graz, 204-212.
 - B. Merema, D. Saelens, H. Breesch (2022). Demonstration of an MPC framework for all-air systems in non-residential buildings. *Building And Environment*, art.nr. 109053.
 - B. Merema, D. Saelens, H. Breesch (2021). Analysing modelling challenges of smart controlled ventilation systems in educational buildings. *Journal Of Building Performance Simulation* **14** (2), 116-131.
 - S. Meunier, C. Protopapadaki, R. Baetens, D. Saelens (2021). Impact of residential low-carbon technologies on low-voltage grid reinforcements. *Applied Energy* **297**, art.nr. 117057, 1-15.
 - J.E. Goncalves, H. Montazeri, T. van Hooff, D. Saelens (2021). Performance of building integrated photovoltaic facades: Impact of exterior convective heat transfer. *Applied Energy* **287**, art.nr. 116538
 - J.E. Goncalves, T. van Hooff, D. Saelens (2021). Simulating building integrated photovoltaic facades: Comparison to experimental data and evaluation of modelling complexity. *Applied Energy* **281**, art.nr. 116032.
 - J.E. Goncalves, T. van Hooff, D. Saelens (2020). Understanding the behaviour of naturally-ventilated BIPV modules: A sensitivity analysis. *Renewable Energy* **161**, 133-148
 - J.E, Goncalves, T. van Hooff, D. Saelens (2020). A physics-based high-resolution BIPV model for building performance simulations. *Solar Energy* **204**, 585-599
 - K. Spiliotis, J.E. Goncalves, D. Saelens, K. Baert, J. Driesen (2020). Electrical system architectures for building-integrated photovoltaics: A comparative analysis using a modelling framework in Modelica. *Applied Energy* **261**, art.nr. 114247. doi: 10.1016/j.apenergy.2019.114247
 - I. De Jaeger, A. Vandermeulen, B. van der Heijde, L. Helsen, D. Saelens (2020). Aggregating set-point temperature profiles for archetype-based: simulations of the space heat demand within residential districts. *Journal Of Building Performance Simulation* **13** (3).
 - C. Protopapadaki, D. Saelens (2019). Towards metamodeling the neighborhood-level grid impact of low-carbon technologies. *Energy and Buildings* **194**, 273-288.
 - V. Reinbold, C. Protopapadaki, J.P. Tavella, D. Saelens (2019). Assessing scalability of a low-voltage distribution grid co-simulation through functional mock-up interface. *Journal of Building Performance Simulation* **12** (5), 637-649.
 - R.A. L. Andriamamonjy, D. Saelens, R. Klein (2018). An auto-deployed model-based fault detection and diagnosis approach for Air Handling Units using BIM and Modelica. *Automation in Construction* **96**, 508-526.
 - R.A. L. Andriamamonjy, D. Saelens, R. Klein (2018). An automated IFC-based workﬂow for building energy performance simulation with Modelica. *Automation in Construction* **91**, 166-181. doi: 10.1016/j.autcon.2018.03.019
 - I. De Jaeger, G. Reynders, Y. Ma, D. Saelens (2018). Impact of building geometry description within district energy simulations. *Energy* **158**, 1060-1069
 - C. Protopapadaki, D. Saelens (2017). Heat pump and PV impact on residential low-voltage distribution grids as a function of building and district properties. *Applied Energy* **192**, 268-281.
 - B.J. Merema, D. Saelens, H. Breesch (2021). Co-Simulation approach to evaluate MPC strategies for all-air systems: case study.  In Proceedings of the 17th IBPSA Conference. Bruges, Belgium, 1-3 September 2021
 - B. Merema, Q. Carton, D. Saelens, H. Breesch (2021). Implementation of MPC for an all-air system in an educational building. In: J. Kurnitski, M. Thalfeldt (Eds.), COLD CLIMATE HVAC & ENERGY 2021: vol. 246, art.nr. 11007. Presented at the 10th International SCANVAC Cold Climate Conference, Tallinn, Estonia, 18-21 April 2021.
 - F. Gonzalez, S. Meunier, C. Protopapadaki, Y. Perez, D. Saelens, M. Petit (2021). Impact of distributed energy resources and electric vehicle smart charging on low voltage grid stability. In CIRED 2021.
 - R. Claeys, C. Protopapadaki, D. Saelens, J. Desmet (2020). A Data-Driven Approach to Assessing and Improving Stochastic Residential Load Modeling for District-Level Simulations and PV Integration. In 2020 International Conference on Probabilistic Methods Applied to Power Systems (PMAPS) (pp. 1-6). IEEE.
 - D. Saelens, I. De Jaeger, F. Bünning, M. Mans, A. Vandermeulen, B. van der Heijde, E. Garreau, A. Maccarini, Ø. Rønneseth, I. Sartori, L. Helsen (2019). Towards a DESTEST: a District Energy Simulation Test Developed in IBPSA Project 1. Presented at the Building Simulation Conference 2019, Rome, 2-4 Sep 2019
 - T. Jafarinejad, I. De Jaeger, A. Erfani, D. Saelens (2021). Evaluating data-driven building stock heat demand forecasting models for energy optimization. art.nr. 30569. In Proceedings of the 17th IBPSA Conference. Bruges, Belgium, 1-3 September 2021 
 - A. Erfani, X. Yu, T.M. Kull, P. Bacher, T. Jafarinejad, S. Roels, D. Saelens (2021). Analysis of the impact of predictive models on the quality of the model predictive control for an experimental building. art.nr. 30566. In Proceedings of the 17th IBPSA Conference. Bruges, Belgium, 1-3 September 2021 
 - M. Delwati, D. Saelens, P. Geyer (2019). Multi-Scale Simulation of a Thermochemical District Network. art.nr. 210652, In Proceedings of the 17th IBPSA Conference. Bruges, Belgium, 1-3 September 2021
 - C. Protopapadaki, D. Saelens (2018). Sensitivity of low-voltage grid impact indicators to weather conditions in residential district energy modeling. In 2018 Building Performance Modeling Conference and SimBuild co-organized by ASHRAE and IBPSA-USA
 - B.J. Merema, H. Breesch, D. Saelens (2019). Comparison of model identification techniques for MPC in all-air HVAC systems in an educational building. In: Clima 2019 congress, Bucharest.
 - B.J. Merema, H. Breesch, D. Saelens (2018). Validation of a BES model of an all-air HVAC educational building. In Proceedings of the Tenth International Conference on System Simulation in Buildings - SSB 2018, art.nr. 38, Liège, Belgium, 10-12 Dec 2018
 - B.J. Merema, H. Breesch (sup.), D. Saelens (sup.) (2021). An MPC framework for all-air systems in non-residential buildings. PhD thesis.
 - I. De Jaeger, D. Saelens (sup.) (2021). On the Impact of Input Data Uncertainty on the Reliability of Urban Building Energy Models. PhD thesis, Arenberg Doctoral School, KU Leuven.
 - J.E. Gonçalves, D. Saelens (sup.), T.A. J. van Hooff (cosup.) (2021). Understanding the Behaviour of Building Integrated Photovoltaic Facades. Numerical and Experimental Analysis. PhD thesis, Arenberg Doctoral School, KU Leuven.
 - C. Protopapadaki, D. Saelens (sup.) (2018). A Probabilistic Framework Towards Metamodeling the Impact of Residential Heat Pumps and PV on Low-voltage Grids. PhD thesis, Arenberg Doctoral School, KU Leuven.
 - R. Andriamamonjy, R. Klein (sup.), D. Saelens (cosup.) (2018). Automated workflows for building design and operation using openBIM and Modelica. PhD thesis


### Bibtex entry for citing IDEAS
Please cite IDEAS using the information below.

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
