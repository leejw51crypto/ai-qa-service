# AI Chatbot Service Documentation

![Version Badge](https://img.shields.io/badge/Version-v1.0.0-blue)
![Version Badge](https://img.shields.io/badge/Node-v18.0.0-yellow)
![Version Badge](https://img.shields.io/badge/NPM-v9.4.0-red)

## Overview

The AI Chatbot Service is a Node.js TypeScript application designed to host chatbot services utilizing the LangChain library and OpenAI integrations. This document provides detailed instructions on setting up, configuring, and running the service, including Docker containerization and security key generation.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Setting Up the Project](#setting-up-the-project)
3. [Running the Service](#running-the-service)
4. [Docker Setup](#docker-setup)
5. [Generating Security Keys](#generating-security-keys)
6. [Environment Variables](#environment-variables)
7. [Local Document Context](#local-document-context)
8. [Endpoints](#endpoints)
9. [VS Code Configuration](#vs-code-configuration)
10. [Testing](#testing)
11. [Links of Interest](#links-of-interest)

### Prerequisites

- Node.js v18.0.0 or later
- npm v9.4.0 or later
- Docker (for containerization)
- TypeScript knowledge (for development)

### Setting Up the Project

1. Clone the repository to your local machine.
2. Navigate to the project directory.
3. Install dependencies:

```bash
npm install
```

### Important Configuration for Langchain Module

When using the Langchain module in acommonJS environment, you might encounter compatibility issues related to the module system (specifically, conflicts between CommonJS and Node's native ESM support). To address this, a small modification is required in the Langchain module files.

Files to Modify:

- `node_modules/langchain/dist/document_loaders/fs/directory.d.ts`
- `node_modules/langchain/dist/document_loaders/fs/text.d.ts`

Required Change:
In both of these files, you'll find one or more lines at the beginning that looks like this:

```ts
<reference types="node" resolution-mode="require" />
```

This line is intended for TypeScript to correctly reference Node.js types. However, due to the incompatibility issues with the Node 16 version and the CommonJS module format, this reference can cause problems.

### Running the Service

1. Compile TypeScript files to JavaScript:

```bash
tsc
```

2. Run the service in development mode:

```bash
npm run dev
```

### Docker

1. Build the Docker image using the provided Dockerfile:

```bash
docker build -f .docker/build.dockerfile -t chatbot-app-service .
```

2. Run the service using Docker:

```bash
docker run -it --init chatbot-app-service
```

### Generating Security Keys

The `security` module in the application provides functions for generating secure API keys and secrets. It uses cryptographic functions for enhanced security.

1. To generate an API key:

```ts
const apiKey = security.generateApiKey();
```

2. To generate an API secret for a given key:

```ts
const apiSecret = security.generateApiSecret('your-key');
```

### Environment Variables

Set the following environment variables in a `.env` file:

- `DB_HOST`, `DB_NAME`, `DB_USERNAME`, `DB_PASSWORD` for database configuration.
- `NODE_ENV` for setting the environment (development, production, etc.).
- `OPENAI_API_KEY` for OpenAI integration.
- `CHATBOT_READ_API_KEY`, `CHATBOT_READ_API_SECRET`, `CHATBOT_WRITE_API_KEY`, `CHATBOT_WRITE_API_SECRET` for chatbot service authentication. These keys can be generated with the previous functions (e.g. apiKey, apiSecret).

### Local Document Context

To provide contextual information to the LangChain library, you can place `.txt` or `.json` files in the `src/integrations/docs` folder. The content of these files will be used to create local vectors for enhanced chatbot responses.

- Utilize the createLoader function in LangChain to load these documents:

```ts
createLoader: (): DirectoryLoader => {
  return new DirectoryLoader('./src/integrations/docs', {
    '.json': (path) => new JSONLoader(path),
    '.txt': (path) => new TextLoader(path),
  });
};
```

### Endpoints

The service exposes various endpoints for chatbot interactions:

1. Health Check:

```bash
GET /healthcheck
```

2. Generate Query:

```bash
POST /api/v1/chatbot-service/generate/query
```

- Body example for POST request:

```bash
{
  "query": "Help me to get started with the cronos chain..."
}
```

### VS Code Configuration

For auto-formatting in VS Code, add the following settings to `.vscode/settings.json`:

```bash
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "prettier.printWidth": 120
}
```

### Testing

Run the test suite with the following command:

```bash
npm run test
```

### Links of interest

- [Prettier extension](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
- [Jest extension](https://marketplace.visualstudio.com/items?itemName=Orta.vscode-jest)
