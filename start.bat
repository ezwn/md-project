@echo off
REM Script de démarrage Node-RED pour Windows
REM Ce script charge les variables d'environnement depuis .env et démarre Node-RED

REM Définir le répertoire de travail au répertoire du script
cd /d "%~dp0"

REM Charger les variables d'environnement depuis le fichier .env
if exist .env (
    echo Chargement des variables d'environnement depuis .env...
    for /f "usebackq tokens=* delims=" %%a in (".env") do (
        REM Ignorer les lignes vides et les commentaires
        echo %%a | findstr /r "^[^#]" >nul
        if not errorlevel 1 (
            set %%a
        )
    )
) else (
    echo ATTENTION: Fichier .env non trouvé!
    echo Veuillez copier .env.example vers .env et configurer vos variables.
    pause
    exit /b 1
)

REM Définir le chemin vers Node-RED
REM Par défaut, Node-RED est installé globalement via npm dans %APPDATA%\npm
set NODE_RED_PATH=%APPDATA%\npm\node-red.cmd

REM Vérifier si Node-RED existe à cet emplacement
if not exist "%NODE_RED_PATH%" (
    echo ERREUR: Node-RED non trouvé à %NODE_RED_PATH%
    echo.
    echo Veuillez installer Node-RED avec: npm install -g --unsafe-perm node-red
    echo Ou définir la variable NODE_RED_PATH dans ce script.
    pause
    exit /b 1
)

echo Démarrage de Node-RED...
echo Chemin Node-RED: %NODE_RED_PATH%
echo Répertoire utilisateur: flows
echo Port: 1882
echo.

REM Démarrer Node-RED avec les paramètres appropriés
"%NODE_RED_PATH%" -p 1882 -u flows

REM Si Node-RED se termine, afficher un message
echo.
echo Node-RED s'est arrêté.
pause
