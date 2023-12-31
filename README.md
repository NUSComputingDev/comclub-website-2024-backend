# Comclub Website 2024 Backend

Welcome to the backend repository of the ComClub website. This README provides an overview of the architecture, technologies used, and instructions for setting up and running the backend locally.

## Architecture

This backend is designed to support the operations of the ComClub website. It handles data processing, API requests, and interacts with the database to provide a smooth experience for users of the website.

## Technologies Used

- **PostgreSQL (pg):** A powerful, open-source object-relational database system that uses and extends the SQL language combined with many features that safely store and scale the most complicated data workloads.

- **Express Promise Router:** A lightweight wrapper for Express 4's Router that allows middleware to return promises. This router is used for handling asynchronous operations in a more readable and efficient manner.

- **AWS RDS for PostgreSQL:** A managed relational database service by Amazon Web Services (AWS) that facilitates the setup, operation, and scaling of a relational database in the cloud. It provides cost-efficient and resizable capacity while automating time-consuming administration tasks such as hardware provisioning, database setup, patching, and backups.

## Getting Started

### Prerequisites

Ensure you have Node.js and npm installed on your machine. You can download and install them from [Node.js official website](https://nodejs.org/).

### Installation

1. **Clone the repository:**

```bash
git clone https://github.com/NUSComputingDev/comclub-website-2024-backend.git
cd comclub-website-2024-backend
```

2. **Install Dependencies:**

```
npm install
```
This command will install all the necessary dependencies for running the backend.


3. **Setting up the Environment:**

Before starting the server, ensure you have the necessary environment variables set up, including your PostgreSQL variables in the `.env`.

4. **Running the Server:**

```
npm run start
```
This command starts the backend server. By default, it will be running on http://localhost:8000.

## Contributing
Contributions to improve the backend are always welcome. If you have suggestions or improvements, please open an issue or create a pull request.

Thank you for contributing to the ComClub website's backend development!
