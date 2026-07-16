#!/bin/bash
# Démarrer matchbox v4.0.12 configuré pour le test 2-to-1 CDA→FHIR

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_DIR="$SCRIPT_DIR/input/matchbox-config"
MATCHBOX_IMAGE="europe-west6-docker.pkg.dev/ahdis-ch/ahdis/matchbox:v4.0.12"

echo -e "${GREEN}=== Démarrage de matchbox pour test-2-to-1 ===${NC}"

if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}Docker n'est pas en cours d'exécution.${NC}"
    exit 1
fi

if docker ps -a | grep -q "matchbox"; then
    echo -e "${YELLOW}Un conteneur matchbox existe déjà.${NC}"
    read -p "Voulez-vous le remplacer ? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        docker rm -f matchbox
    else
        docker start matchbox 2>/dev/null || true
        echo -e "${GREEN}Matchbox démarré.${NC}"
        echo "API FHIR : http://localhost:8080/matchbox/fhir"
        exit 0
    fi
fi

echo "Démarrage de matchbox ${MATCHBOX_IMAGE}..."
docker run -d --name matchbox \
    -p 8080:8080 \
    -v "$CONFIG_DIR:/config" \
    "$MATCHBOX_IMAGE"

echo -e "${GREEN}Matchbox démarré !${NC}"
echo ""
echo "API FHIR : http://localhost:8080/matchbox/fhir"
echo ""
echo -e "${YELLOW}Attendez ~30 secondes que matchbox charge le package CDA avant de lancer les tests.${NC}"
echo ""
echo "Logs : docker logs --follow matchbox"
echo "Stop : docker stop matchbox"
