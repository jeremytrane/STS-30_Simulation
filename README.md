# STS-30 Simulation

This project provides a MATLAB-based simulation of NASA's STS-30 mission, which launched the Magellan spacecraft to Venus in 1989. The simulation models various aspects of the Space Shuttle Atlantis's flight dynamics and mission parameters.

## Table of Contents

- [Overview](#overview)
- [Features](#features)

## Overview

STS-30 was the 29th NASA Space Shuttle mission and the fourth flight of Atlantis. Its primary objective was to deploy the Magellan spacecraft, initiating a mission to map the surface of Venus using radar imaging. This simulation aims to replicate the key flight dynamics and mission phases of STS-30.

## 🚀 Features

This simulation models the flight dynamics of NASA's STS-30 mission, focusing on the ascent of the Space Shuttle Atlantis and deployment of the Magellan spacecraft. It includes detailed aerodynamic, propulsion, and trajectory analysis.

- **Aerodynamic Modeling** – Calculates angle of attack and drag during ascent.
- **Propulsion Simulation** – Models SRB and main engine behavior, including fuel usage and thrust.
- **Trajectory Computation** – Simulates shuttle motion under gravity and atmospheric forces.
- **Data Visualization** – Generates animations for mission visualization.

<details>
  <summary>📂 Click to expand list of MATLAB methods used</summary>

  - [`AOA.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/AOA.m): Computes angle of attack during ascent  
  - [`Adams_BM.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/Adams_BM.m): Adams-Bashforth-Moulton integration  
  - [`COG_Atlantis.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/COG_Atlantis.m): Center of gravity of Atlantis orbiter  
  - [`COG_finder_EXT.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/COG_finder_EXT.m): Center of gravity for external tank  
  - [`EXT_mass.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/EXT_mass.m): Mass calculation for the external tank  
  - [`Fuelratedecrease.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/Fuelratedecrease.m): Models rate of fuel burn  
  - [`SRB_mass.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/SRB_mass.m): Mass properties of SRBs  
  - [`Throttle.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/Throttle.m): Engine throttle simulation  
  - [`density.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/density.m): Atmospheric density model  
  - [`drag.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/drag.m): Drag force calculation  
  - [`frk.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/frk.m): Flight dynamics utility  
  - [`gravity.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/gravity.m): Gravitational force model  
  - [`movie_atlantis.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/movie_atlantis.m): Animation of ascent  
  - [`simpson_1.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/simpson_1.m): Simpson’s rule integration  
  - [`simpson_2.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/simpson_2.m): Alternate Simpson’s method  
  - [`throttle_map.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/throttle_map.m): Throttle over time  
  - [`thrust_angle.m`](https://github.com/jeremytrane/STS-30_Simulation/blob/main/thrust_angle.m): Computes thrust vector angle  

</details>


<div align="center">
  <img src="output/STS-30 Atlantis flight.gif" />
</div>
