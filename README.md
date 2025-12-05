# MD-Project

## Install

- install node.js locally
- [install node-red locally](https://nodered.org/docs/getting-started/local)

## Configuration

1. Copy the example environment file:
   ```bash
   cp .env.example .env
   ```

2. Edit `.env` and add your GitLab credentials:
   ```bash
   GITLAB_PRIVATE_TOKEN=your_actual_gitlab_token
   GITLAB_PROJECT_ID=74387023
   ```

## Usage

Start Node-RED with:
```bash
./start.sh
```

The Node-RED editor will be available at http://localhost:1882
