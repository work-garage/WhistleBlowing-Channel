# WhistleBlower – Decentralized Reporting Smart Contract

> **A decentralized and transparent whistleblowing channel** built on Solidity.  
> Enables users to submit tamper-proof reports via IPFS while keeping their identities pseudo-anonymous on-chain.

---

## Overview

**WhistleBlower** is a minimal Ethereum smart contract that allows individuals to securely submit reports (stored on IPFS) that are timestamped and verifiable on-chain.  
Only the **owner (admin)** can mark reports as solved.

This ensures **trust**, **transparency**, and **immutability** — all key principles of blockchain-based governance and reporting.

---

## Features

**Anonymous reporting** via IPFS hash (no centralized storage)  
**Timestamped reports** for traceability (`createdAt`, `solvedAt`)  
**Owner-only resolution** to manage reports’ lifecycle  
**Indexed architecture** for easy off-chain indexing  
**User report tracking** via mapping (`userReports`)  

---

## Contract Structure

| Variable | Description |
|-----------|--------------|
| `owner` | Contract deployer / admin |
| `reportCount` | Total number of submitted reports |
| `reports` | Mapping of report ID → Report details |
| `userReports` | Tracks reports submitted by each address |

### Struct: `Report`
| Field | Type | Description |
|--------|------|-------------|
| `id` | `uint` | Unique report identifier |
| `ipfsHash` | `string` | IPFS CID of the stored report |
| `reporter` | `address` | Address of the whistleblower |
| `solved` | `bool` | Whether report is marked as solved |
| `createdAt` | `uint256` | Timestamp of submission |
| `solvedAt` | `uint256` | Timestamp of resolution |

