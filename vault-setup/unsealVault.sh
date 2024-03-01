#!/usr/bin/env bash

echo "Unsealing Hashicorp Vault"
key=`cat ./vault.out | grep -A 1 unseal_keys_b64 | grep -v unseal_keys_b64 | cut -c 3-`
kubectl -n vault exec -it vault-0 -- /bin/sh -c "vault operator unseal $key"
