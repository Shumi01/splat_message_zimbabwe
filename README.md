# splat_message_zimbabwe
Simplified SPLAT-MESSAGE energy model for Zimbabwe using GAMS
# SPLAT-MESSAGE Style Energy System Model: Zimbabwe Case Study

This project implements a simplified version of the SPLAT-MESSAGE energy system planning model for Zimbabwe using the GAMS optimization language. It is inspired by the regional models developed by IRENA and IIASA, focusing on capacity expansion planning under emissions and cost constraints.

---

## Objective

To identify a least-cost technology mix for Zimbabwe’s electricity system from 2020 to 2050, while meeting energy demand and adhering to CO₂ emissions caps.

---

## Structure

```
project-root/
│
├── model/
│   └── splat_zimbabwe.gms         # Main GAMS model (SPLAT-style)
│
├── data/
│   └── demand.csv                 # Electricity demand by year
│   └── tech_costs.csv            # Investment, variable, and fixed O&M costs
│   └── emissions.csv             # Emission factors and caps
│
├── scripts/
│   └── analyze_results.R         # Script to visualize results
│
└── README.md                     # Project overview
```

---

## Key Features

* **Technologies Modeled**: Coal, Hydro, Solar, Wind
* **Model Horizon**: 2020–2050 (5-year steps)
* **Capacity Vintaging**: Tracks technology lifetime & decommissioning
* **Emissions Cap**: Constrained by national CO₂ limits
* **Objective**: Minimize total system cost (investment + O\&M + fuel)

---

## Methodology

This model solves a linear program that determines:

1. Optimal generation levels for each technology per year (ACT)
2. Capacity additions by year and technology (INV)
3. Installed vintage capacity over time (CAP)
4. Resulting CO₂ emissions and system cost

Constraints ensure:

* Energy demand is met
* Emissions do not exceed caps
* Generation is limited by available capacity and technology efficiency

---

## 📈 Sample Outputs

* Electricity generation by technology and year
* Installed capacity trends
* Annual CO₂ emissions
* Total system cost breakdown

All results are exported to `.gdx` files and visualized using an R script.

---

## 🔧 Tools Used

* [GAMS](https://www.gams.com/) (General Algebraic Modeling System)
* [R](https://www.r-project.org/) for result processing and plots

---

## 🧪 To Run the Model

1. Open the `splat_zimbabwe.gms` file in GAMS IDE
2. Run the model
3. Export `.gdx` results
4. Use the R script in `scripts/analyze_results.R` to generate plots

---

## Reference

* IRENA (2015–2023): SPLAT-MESSAGE Africa Regional Energy Models
* IIASA MESSAGE Documentation: [https://message.iiasa.ac.at/](https://message.iiasa.ac.at/)

---

## Contact

For questions, open an issue or contact \ Shumirai Manzvera at xuemanzvera@gmail.com

---

## 📜 License

MIT License
