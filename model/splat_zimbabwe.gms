* SPLAT-MESSAGE Style Energy System Model for Zimbabwe (Simplified)

* ------------------
* SET DEFINITIONS
* ------------------
SETS
  t       Time periods /2020*2050 by 5/,
  vint(t) Vintage years /2020*2050 by 5/,  
  tech    Technologies /coal, hydro, solar, wind/;

ALIAS (t,tp);

* ------------------
* PARAMETERS
* ------------------
PARAMETERS
  demand(t)               Electricity demand in TWh
  inv_cost(tech)          Investment cost per GW (million USD)
  fix_cost(tech)          Fixed O&M cost per GW (million USD)
  var_cost(tech)          Variable cost per MWh (USD)
  life(tech)              Lifetime of each technology (years)
  eff(tech)               Efficiency of each technology
  emission_factor(tech)   CO2 emissions per MWh (tCO2)
  emissions_cap(t)        Annual CO2 emission cap (MtCO2);

TABLE demand(t)
        demand
2020    10
2025    12
2030    14
2035    17
2040    19
2045    21
2050    23;

TABLE inv_cost(tech)
         inv_cost
coal     3000
hydro    2500
solar    1500
wind     1800;

TABLE fix_cost(tech)
         fix_cost
coal     100
hydro    80
solar    30
wind     40;

TABLE var_cost(tech)
         var_cost
coal     60
hydro    10
solar     5
wind      7;

TABLE emission_factor(tech)
         emission_factor
coal     0.9
hydro    0.0
solar    0.0
wind     0.0;

TABLE emissions_cap(t)
        emissions_cap
2020    8
2025    7
2030    6
2035    5
2040    4
2045    3
2050    2;

TABLE life(tech)
        life
coal     30
hydro    40
solar    25
wind     25;

TABLE eff(tech)
        eff
coal     0.38
hydro    1.00
solar    1.00
wind     1.00;

* ------------------
* VARIABLES
* ------------------
VARIABLES
  ACT(tech,t)       Electricity generation (TWh)
  CAP(tech,vint)    Installed capacity by vintage (GW)
  INV(tech,t)       New capacity investment (GW)
  EMISSIONS(t)      Annual emissions (MtCO2)
  TOTAL_COST        Total system cost (million USD);

POSITIVE VARIABLES ACT, CAP, INV, EMISSIONS;

* ------------------
* EQUATIONS
* ------------------
EQUATIONS
  objective_function
  demand_constraint(t)
  emissions_accounting(t)
  capacity_balance(tech,t)
  vintage_tracking(tech,vint);

* Objective: minimize total system cost
objective_function.. TOTAL_COST =E=
  SUM((tech,t), INV(tech,t) * inv_cost(tech))
+ SUM((tech,t), ACT(tech,t) * var_cost(tech))
+ SUM((tech,vint)$(ord(vint)<=ord(t)), CAP(tech,vint) * fix_cost(tech));

* Demand satisfaction

demand_constraint(t).. SUM(tech, ACT(tech,t)) =G= demand(t);

* Emissions accounting
emissions_accounting(t).. EMISSIONS(t) =E= SUM(tech, ACT(tech,t) * emission_factor(tech));

* Annual emissions cap
EMISSIONS(t) =L= emissions_cap(t);

* Generation cannot exceed available capacity
capacity_balance(tech,t)..
  ACT(tech,t) =L=
  SUM(vint$(ord(vint) <= ord(t) AND ord(vint) + floor(life(tech)/5) - 1 >= ord(t)), CAP(tech,vint)) * 8760 * eff(tech) / 1000;

* Capacity vintaging: new investments become vintage
vintage_tracking(tech,t).. CAP(tech,t) =E= INV(tech,t);

* ------------------
* MODEL DEFINITION
* ------------------
MODEL splat_message_model /all/;
SOLVE splat_message_model USING LP MINIMIZING TOTAL_COST;

DISPLAY ACT.l, CAP.l, INV.l, TOTAL_COST.l, EMISSIONS.l;
