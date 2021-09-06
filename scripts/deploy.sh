. ./scripts/common.sh

# default to localhost rpc
RPC_URL=${ETH_RPC_URL:-http://localhost:8545}

# Mainnet loot address
# Default to it if nothing is provided
LOOT="${LOOT:-$MAINNET_LOOT}"

# Deploy.
LootLooseAddr=$(deploy LootLoose 'LootLoose(address)' $LOOT)
log "LootLoose deployed at:" $LootLooseAddr

# Log addresses to file
cat > "$OUT_DIR"/addresses.json <<EOF
{
    "DEPLOYER": "$(seth --to-checksum-address "$FROM")",
    "LOOTLOOSE": "$LootLooseAddr",
}
EOF
