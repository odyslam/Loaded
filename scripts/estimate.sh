. $(dirname $0)/common.sh

if [[ -z $contract ]];then
  echo '"$contract" env variable is not set. Set it to the name of the contract you want to estimate gas cost for.'
  exit 1
fi
estimate_gas $contract

