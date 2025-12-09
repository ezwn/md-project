# MD-Project

## Install

- install node.js locally
- [install node-red locally](https://nodered.org/docs/getting-started/local) and put it in the path

## Configuration

1. Copy the example environment file:
   ```bash
   cp .env.example .env
   ```

## Usage

### Linux/Mac
Start Node-RED with:
```bash
./start.sh
```

### Windows

**Option 1: Batch Script (CMD)**
```cmd
start.bat
```

**Option 2: PowerShell Script**
```powershell
.\start.ps1
```

> **Note**: Si vous obtenez une erreur de politique d'exécution avec PowerShell, exécutez d'abord:
> ```powershell
> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```

The Node-RED editor will be available at http://localhost:1882
