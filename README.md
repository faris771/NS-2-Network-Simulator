# NS-2 Simulation of a Differentiated Services IP Network

## Overview
This repository contains the necessary files and scripts for simulating a Differentiated Services (DiffServ) IP network using NS-2. The assignment provides hands-on experience with service differentiation and Quality of Service (QoS) in IP networks through a series of simulations. This lab was part of my Erasmus exchange program in **University of Malaga** in the Telecommunication Managment Course.

## Objective
The objective of this lab is to enhance the understanding of the impact of service differentiation in IP networks. Using NS-2, the following scenarios are simulated:
- A **Best-Effort Network** using FIFO queues.
- A **DiffServ Network** utilizing Assured Forwarding (AF) behavior, token bucket algorithms, and Weighted Random Early Detection (WRED) for traffic management.

## Tools and Environment
This lab makes use of the following tools:
- **NS-2**: Network Simulator.
- **NAM**: Network Animator (for visualizing simulations).
- **Python 3**: For post-processing the trace files and generating performance metrics.
- **Spyder3**: Python IDE for running analysis scripts.

### Installation (Optional)
If you are working in an environment without pre-installed software, follow these steps to install the necessary tools on **Ubuntu 20.04 LTS**:
```bash
sudo apt update
sudo apt install ns2 python3 python3-numpy python3-matplotlib python3-pandas spyder3 nam
