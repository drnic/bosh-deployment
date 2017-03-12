#!/bin/bash

var_keys_to_prune=$(cat vars.yml creds.yml | spruce json | jq -r "keys[]" | uniq | sort)
# echo $var_keys_to_prune
for var in $var_keys_to_prune; do
  prune_flags="$prune_flags --prune $var"
done

echo merging bosh.yml bosh-lite.yml
bosh2 interpolate bosh.yml -o bosh-lite.yml --vars-store creds.yml --vars-file vars.yml > tmp/minus-o.yml &&
  spruce merge $prune_flags spruce/bosh.yml spruce/bosh-lite.yml creds.yml vars.yml > tmp/spruce.yml &&
  spruce diff tmp/spruce.yml tmp/minus-o.yml

echo merging bosh.yml vsphere/cpi.yml
bosh2 interpolate bosh.yml -o vsphere/cpi.yml --vars-store creds.yml --vars-file vars.yml > tmp/minus-o.yml &&
  spruce merge $prune_flags spruce/bosh.yml spruce/vsphere/cpi.yml creds.yml vars.yml > tmp/spruce.yml &&
  spruce diff tmp/spruce.yml tmp/minus-o.yml
