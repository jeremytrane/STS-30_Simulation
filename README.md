# STS-30 Simulation

This project provides a MATLAB-based simulation of NASA's STS-30 mission, which launched the Magellan spacecraft to Venus in 1989. The simulation models various aspects of the Space Shuttle Atlantis's flight dynamics and mission parameters.

## Table of Contents

- [Overview](#overview)
- [Features](#features)

## Overview

STS-30 was the 29th NASA Space Shuttle mission and the fourth flight of Atlantis. Its primary objective was to deploy the Magellan spacecraft, initiating a mission to map the surface of Venus using radar imaging. This simulation aims to replicate the key flight dynamics and mission phases of STS-30.

## Features

- **Aerodynamic Analysis**: Calculates the shuttle's angle of attack and drag forces during ascent.
- **Propulsion Modeling**: Simulates the behavior of the Solid Rocket Boosters (SRBs) and the Shuttle's main engines, including fuel consumption and thrust variations.
- **Trajectory Simulation**: Models the shuttle's trajectory, accounting for gravitational forces and atmospheric conditions.​
- **Visualization**: Provides animations of the shuttle's ascent, offering visual insights into the mission dynamics.​

<details>
  <summary>Click to expand method list</summary>

  - `AOA.m`: Computes the angle of attack during ascent.  
  - `Adams_BM.m`: Implements the Adams-Bashforth-Moulton method.  
  - `COG_Atlantis.m`: Determines center of gravity for Atlantis.  
  - `COG_finder_EXT.m`: Calculates center of gravity for external tank.  
  - `EXT_mass.m`: Computes mass of the external tank.  
  - `Fuelratedecrease.m`: Models fuel consumption rate.  
  - `SRB_mass.m`: Calculates SRB mass properties.  
  - `Throttle.m`: Simulates throttle settings.  
  - `density.m`: Computes atmospheric density.  
  - `drag.m`: Calculates drag forces.  
  - `frk.m`: Flight dynamics calculation.  
  - `gravity.m`: Models gravitational force.  
  - `movie_atlantis.m`: Generates shuttle ascent animation.  
  - `simpson_1.m`, `simpson_2.m`: Simpson's rule integrators.  
  - `throttle_map.m`: Throttle mapping over time.  
  - `thrust_angle.m`: Calculates thrust vector angle.  

</details>

<div align="center">
  <img src="output/STS-30 Atlantis flight.gif" />
</div>
