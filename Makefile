-include .env

install: update npm solc

install: update npm solc

# dapp deps
update:; dapp update

# npm deps for linting etc.
npm:; yarn install

# install solc version
# example to install other versions: `make solc 0_8_2`
SOLC_VERSION := 0_8_6
solc:; nix-env -f https://github.com/dapphub/dapptools/archive/master.tar.gz -iA solc-static-versions.solc_${SOLC_VERSION}

# Build & test
build  :; dapp build
test   :; dapp test # --ffi # enable if you need the `ffi` cheat code on HEVM
clean  :; dapp clean
lint   :; yarn run lint
estimate: export ETH_RPC_URL = $(call network,mainnet)
estimate:; ./scripts/estimate-gas.sh ${contract}
size   :; ./scripts/contract-size.sh ${contract}

# returns the URL to deploy to a hosted Alchemy node
# requires the API_KEY env var to be set
# the first argument determines the network
define network
	https://eth-$1.alchemyapi.io/v2/${ALCHEMY_API_KEY}
endef

# Deployment helpers
deploy :; @./scripts/deploy.sh

source: source .env

# mainnet
deploy-mainnet: export ETH_RPC_URL = $(call network,mainnet)
deploy-mainnet: deploy

# rinkeby
deploy-rinkeby: export ETH_RPC_URL = $(call network,rinkeby)
deploy-rinkeby: deploy

check-api-key:
ifndef ALCHEMY_API_KEY
	$(error ALCHEMY_API_KEY is undefined)
endif
