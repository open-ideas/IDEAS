within IDEAS.Fluid.Production.BaseClasses;
type InputType = enumeration(
    m_flowEva "Evaporator mass flow rate [kg/s]",
    m_flowCon "Condensor mass flow rate [kg/s]",
    T_inEva "Evaporator inlet temperature [K]",
    T_inCon "Condensor inlet temperature [K]",
    T_outEva "Evaporator outlet temperature [K]",
    T_outCon "Condensor outlet temperature [K]",
    Speed "Normalised compressor speed [0-1]",
    None "None") "Input type for heat pump table";
