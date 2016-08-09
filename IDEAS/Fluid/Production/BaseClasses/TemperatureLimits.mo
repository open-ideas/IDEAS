within IDEAS.Fluid.Production.BaseClasses;
type TemperatureLimits = enumeration(
    Ignore "Ignore the temperature limit",
    Warning "Throw a warning",
    Error "Throw an error",
    Disable "Disable the heat pump for a fixed amount of time")
  "Type for choosing what happens if a heat pump evaporator/condensor temperature limit is exceeded";
