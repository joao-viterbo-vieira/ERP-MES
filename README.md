# ERP-MES

ERP-MES is an integrated system designed to streamline enterprise resource planning (ERP) and manufacturing execution system (MES) processes. Developed in Pascal, this project addresses modern manufacturing needs by integrating production planning, inventory management, quality control, and real-time monitoring.

> This work received a score of 20/20 in the Industrial Informatics course during the last semester of the Bachelor of Industrial Engineering and Management program.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [System Requirements](#system-requirements)
- [Getting Started](#getting-started)

## Overview

ERP-MES integrates core ERP and MES functionalities into one comprehensive system that helps organizations optimize production workflows, reduce downtime, and ensure quality control. This repository contains the source code, configuration files, and documentation necessary to build and deploy the system.

## Features

- **Production Planning:** Advanced scheduling and resource allocation for optimized production workflows.
- **Inventory Management:** Real-time tracking of raw materials, in-process items, and finished goods.
- **Quality Control:** Tools for defect tracking, process standardization, and compliance reporting.
- **Real-Time Monitoring:** Dashboards for monitoring production status, machine performance, and operator activity.
- **Integration:** Interfaces with CodeSys and FactoryIO for simulation and control, along with PostgreSQL for robust data management.
- **Customizable Modules:** A modular design that allows for extensions and adaptations to specific industry needs.

## System Requirements

- **Operating System:** Compatible with Windows, Linux, and macOS.
- **Compiler:** Free Pascal Compiler (FPC) or a compatible Pascal compiler.
- **Pre-requisites:**
  - **CodeSys:** Required for executing and simulating control logic.
  - **FactoryIO:** Required for plant and machinery simulation.
  - **PostgreSQL:** Ensure you have access to a PostgreSQL database for data management.
- **Hardware:** Standard development and testing requirements (e.g., 4GB RAM, dual-core processor).
- **Additional Tools:** Lazarus IDE (optional for a graphical interface).

## Getting Started

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/joao-viterbo-vieira/ERP-MES.git
   cd ERP-MES
