
# Bambooboard

Bambooboard is a Conduit-based web server platform designed for organizations to manage their operations efficiently. This guide will walk you through setting up and testing the application.

## Prerequisites

- Dart SDK
- Conduit CLI
- Docker (for the PostgreSQL database)

## Installation

### Step 1: Install Conduit CLI

To install the Conduit CLI, run the following command:

```bash
dart pub global activate conduit
```

### Step 2: Clone the Repository

Clone the Bambooboard repository to your local machine:

```bash
git clone https://github.com/yourusername/bambooboard.git
cd bambooboard
```

### Step 3: Configure the Database

Ensure you have Docker installed and running. Then, start the PostgreSQL database using Docker Compose:

```bash
docker compose up -d
```

### Step 4: Run the Server

Navigate to the project directory and start the Conduit server:

```bash
conduit serve
```

## Testing

To test the application, follow these steps:

### Step 1: Register a User

Run the following `curl` command to register a new user:

```bash
curl -X POST http://localhost:8888/register -H 'Content-Type: application/json' -d '{"username":"Julian", "password":"secret"}'
```

### Step 2: Add a Client

Add a client to the server to allow API access:

```bash
conduit auth add-client --id com.bambooboard.client
```

### Step 3: Get an Authorization Token

You can get the authorization token by running the following `curl` command or using a Dart script (`generate-token.dart`):

#### Using `curl`:

```bash
curl -X POST http://localhost:8888/auth/token -H 'Authorization: Basic Y29tLmhlcm9lcy50dXRvcmlhbDo=' -H 'Content-Type: application/x-www-form-urlencoded' -d 'username=Julian&password=secret&grant_type=password'
```

This will return a Bearer token which you will use to make protected requests.

### Step 4: Make Protected Requests

Use the Bearer token obtained in the previous step to make authenticated requests. For example, to get all users:

```bash
curl -X GET http://localhost:8888/users -H 'Authorization: Bearer (Bearer Token here)'
```

Replace `(Bearer Token here)` with the actual token value.

## Notes

I would have implemented more features and functionality, but due to the limited time (one hour) and the need to familiarize myself with the Conduit framework, this is the extent of the current implementation. I'm still learning and exploring the capabilities of this framework.

## Conclusion

This README provides a basic guide to set up, run, and test the Bambooboard application. Future enhancements will include more comprehensive features and a detailed user interface for better organization management. 

A client for the API will follow up in the next hour, written in Flutter.