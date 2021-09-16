# Loaded

ERC721 Smart contract address: [0x65dfc7d6afd14b6fd8d410969e809b0db250f0f5](https://etherscan.io/address/0x65dfc7d6afd14b6fd8d410969e809b0db250f0f5).

Loaded is randomized kits for soldiers.

- Primary Weapon
- Secondary Weapon
- Equipment 1
- Equipment 2
- Equipment 3
- Perk 1
- Perk 2
- Perk 3

Every weapon have different stats, so that you can build applications on top of it. The stats are derived from the real-life weapons.

Perks are text-only and don't have a description. it's up to you to interpret them however you like.

## Building and Testing
```
git clone https://github.com/odyslam/loaded
cd loaded
make
make test
```

## Installing the toolkit

The project uses [dapptools](https://github.com/dapphub/dapptools). You will need to install them if you haven't.

There are 2 options:

- Native installation of dapptools with Nix
- Docker version of dapptools: ddapptools

### Docker

```
git clone https://github.com/OdysLam/ddapptools
cd ddapptools
# Run pwd to copy the absolute path to ddapptools
pwd
```

Now, to use ddapptools, `cd` into the `Loaded` directory and instead of `make` run `<absolute_path/ddapptools/scrtipts/ddapp.sh make`.

The helper script will make sure that the container works as a drop-in replacement to the natively installed dapptools.

### Native - Install Nix

```
# User must be in sudoers
curl -L https://nixos.org/nix/install | sh

# Run this or login again to use Nix
. "$HOME/.nix-profile/etc/profile.d/nix.sh"
```

### Native - Install Dapptools

```
curl https://dapp.tools/install | sh
```

## Security Notes

The smart contract is not audited.



