. $(dirname $0)/common.sh

# default to localhost rpc
RPC_URL=${ETH_RPC_URL:-http://localhost:8545}

# Mainnet loot address
# Default to it if nothing is provided
# Deploy.
LoadedAddress=$(deploy Loaded);
log "Loaded deployed at:" $LoadedAddress
export LOADED=$LoadedADdress
# Log addresses to file
cat > "$OUT_DIR"/addresses.json <<EOF
{
    "DEPLOYER": "$(seth --to-checksum-address "$FROM")",
    "LOADED": "$LoadedAddress",
}
EOF
