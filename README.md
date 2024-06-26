# Ethereum Lottery dApp

## Table of Contents

1. [Overview](#overview)
2. [Smart Contract](#smart-contract)
3. [Frontend Implementation](#frontend-implementation)
4. [Getting Started](#getting-started)
5. [Dependencies](#dependencies)
6. [Features](#features)
7. [Usage](#usage)
8. [Contributing](#contributing)
---

## Overview

Welcome to the Ethereum Lottery decentralized application (dApp). This dApp allows users to participate in a lottery and pick winners based on random numbers generated on the blockchain.

## Smart Contract

The `Lottery.sol` file contains the Solidity smart contract code. It includes functionalities such as starting a lottery, entering the lottery, picking a winner, and paying the winner.

## Frontend Implementation

The frontend is built using React and Web3.js. It interacts with the smart contract deployed on the Ethereum blockchain to display lottery information and allow users to participate.

## Getting Started

To run the dApp locally, follow these steps:

1. Clone this repository.
2. Install dependencies using `npm install`.
3. Start the frontend application using `npm start`.
4. Connect to an Ethereum blockchain network (e.g., Sepolia Testnet).
5. Ensure you have the required Ethereum wallet (e.g., MetaMask) installed and configured.
6. Access the dApp through your browser at `http://localhost:3000` (or the appropriate port).

## Dependencies

The dApp relies on the following dependencies:

- Web3.js
- React
- Truffle
- 
## Features

- Connect wallet using MetaMask.
- Start a new lottery.
- Enter the lottery by sending Ether.
- Pick a winner (admin only).
- Pay the winner (admin only).
- View lottery history, players, and pot.

## Usage

1. Connect your MetaMask wallet to the application.
2. Start a new lottery and wait for players to enter.
3. Players can enter the lottery by sending Ether.
4. Admin can pick a winner after the countdown ends.
5. Admin can pay the winner after picking.

## Contributing

Contributions to this project are welcome. Please fork the repository and submit a pull request with your enhancements.
