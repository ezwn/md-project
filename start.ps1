# Script de démarrage Node-RED pour Windows (PowerShell)
# Ce script charge les variables d'environnement depuis .env et démarre Node-RED

# Définir le répertoire de travail au répertoire du script
Set-Location $PSScriptRoot

# Fonction pour charger les variables d'environnement depuis .env
function Load-EnvFile {
    param (
        [string]$EnvFilePath = ".env"
    )
    
    if (Test-Path $EnvFilePath) {
        Write-Host "Chargement des variables d'environnement depuis $EnvFilePath..." -ForegroundColor Green
        
        Get-Content $EnvFilePath | ForEach-Object {
            $line = $_.Trim()
            
            # Ignorer les lignes vides et les commentaires
            if ($line -and -not $line.StartsWith("#")) {
                # Séparer la clé et la valeur
                $parts = $line -split '=', 2
                if ($parts.Length -eq 2) {
                    $key = $parts[0].Trim()
                    $value = $parts[1].Trim()
                    
                    # Définir la variable d'environnement
                    [Environment]::SetEnvironmentVariable($key, $value, [EnvironmentVariableTarget]::Process)
                    Write-Host "  $key défini" -ForegroundColor Gray
                }
            }
        }
    } else {
        Write-Host "ATTENTION: Fichier .env non trouvé!" -ForegroundColor Yellow
        Write-Host "Veuillez copier .env.example vers .env et configurer vos variables." -ForegroundColor Yellow
        Read-Host "Appuyez sur Entrée pour quitter"
        exit 1
    }
}

# Charger le fichier .env
Load-EnvFile

# Définir le chemin vers Node-RED
# Par défaut, Node-RED est installé globalement via npm dans %APPDATA%\npm
$nodeRedPath = Join-Path $env:APPDATA "npm\node-red.cmd"

# Vérifier si Node-RED existe à cet emplacement
if (-not (Test-Path $nodeRedPath)) {
    Write-Host "ERREUR: Node-RED non trouvé à $nodeRedPath" -ForegroundColor Red
    Write-Host ""
    Write-Host "Veuillez installer Node-RED avec: npm install -g --unsafe-perm node-red" -ForegroundColor Yellow
    Write-Host "Ou définir la variable `$nodeRedPath dans ce script." -ForegroundColor Yellow
    Read-Host "Appuyez sur Entrée pour quitter"
    exit 1
}

Write-Host "Démarrage de Node-RED..." -ForegroundColor Cyan
Write-Host "Chemin Node-RED: $nodeRedPath" -ForegroundColor Gray
Write-Host "Répertoire utilisateur: flows" -ForegroundColor Gray
Write-Host "Port: 1882" -ForegroundColor Gray
Write-Host ""

# Démarrer Node-RED avec les paramètres appropriés
& $nodeRedPath -p 1882 -u flows

# Si Node-RED se termine, afficher un message
Write-Host ""
Write-Host "Node-RED s'est arrêté." -ForegroundColor Yellow
Read-Host "Appuyez sur Entrée pour quitter"
