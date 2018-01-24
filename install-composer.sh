#!/usr/bin/env bash

COMPOSER_VERSION=latest
export FABRIC_VERSION=hlfv1

export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"

# Install Composer modules
npm ls -g composer-cli@${COMPOSER_VERSION} >/dev/null 2>&1 || npm install -g composer-cli@${COMPOSER_VERSION}
npm ls -g composer-rest-server@${COMPOSER_VERSION} >/dev/null 2>&1 || npm install -g composer-rest-server@${COMPOSER_VERSION}
npm ls -g generator-hyperledger-composer@${COMPOSER_VERSION} >/dev/null 2>&1 || npm install -g generator-hyperledger-composer@${COMPOSER_VERSION}
npm ls -g composer-playground@${COMPOSER_VERSION} >/dev/null 2>&1 || npm install -g composer-playground@${COMPOSER_VERSION}

npm ls -g node-red-contrib-composer@0.0.10 >/dev/null 2>&1 || npm install -g node-red-contrib-composer@0.0.10

# Install and start Fabric dev env for Composer
FABRIC_DIR="$HOME/${FABRIC_VERSION}-tools"
if [ ! -d ${FABRIC_DIR} ]; then
  mkdir -p ${FABRIC_DIR}
  cd ${FABRIC_DIR}

  curl -O https://raw.githubusercontent.com/hyperledger/composer-tools/master/packages/fabric-dev-servers/fabric-dev-servers.tar.gz
  tar -xvzf fabric-dev-servers.tar.gz

  ./downloadFabric.sh
  sg docker ./startFabric.sh
  ./createPeerAdminCard.sh
fi
