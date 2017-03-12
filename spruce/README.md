# Alternate templates

This folder includes 1:1 alternate templates that are implemented for `spruce merge` rather than `bosh interpolate`

This comparison assumes you have deployed a bosh and have a `creds.yml` with credentials; and `vars.yml` with the required variables in it.

To compare the `bosh.yml` and `bosh-lite.yml` for `bosh2 interpolate` and `spruce merge`:

```
./spruce/compare.sh
```

The output will look like:

```
merging bosh.yml bosh-lite.yml
both files are semantically equivalent; no differences found!

merging bosh.yml vsphere/cpi.yml
  $.cloud_provider.properties.vcenter.datacenters[Interxion MAD2].clusters[0] changed type
    from scalar
      to map

  $.instance_groups[bosh].properties.vcenter.datacenters[Interxion MAD2].clusters[0] changed type
    from scalar
      to map
```

In our vsphere manifests we have:

```
cloud_provider:
  properties:
    vcenter:
      datacenters:
      - clusters:
        - cluster1
```

But in `bosh-deployment/vsphere/cpi.yml` it is:

```
cloud_provider:
  properties:
    vcenter:
      datacenters:
      - clusters:
        - cluster1: {}
```

## Comparisons

One silly metric of readability might be number of lines:

```
$ wc bosh-lite.yml
      87     164    2543 bosh-lite.yml
$ wc spruce/bosh-lite.yml
      57     124    1953 spruce/bosh-lite.yml
```

A better one is to compare two equivalent parts of the files.

In `bosh-lite.yml` we want to add three releases. In the `spruce/bosh-lite.yml` this is as clean as:

```yaml
releases:
  - name: bosh-warden-cpi
    version: 34
    url: ...
    sha1: 536...
  - name: garden-linux
    version: 0.342.0
    url: ...
    sha1: 607...
  - name: os-conf
    version: 11
    url: ...
    sha1: 651...
```

New items to an array are merged into the existing array.

Compared to the go-patch syntax:

```yaml
- type: replace
  path: /releases/-
  value:
    name: bosh-warden-cpi
    version: 34
    url: ...
    sha1: 536...

- type: replace
  path: /releases/-
  value:
    name: garden-linux
    version: 0.342.0
    url: ...
    sha1: 607...

- type: replace
  path: /releases/name=os-conf?
  value:
    name: os-conf
    version: 11
    url: ...
    sha1: 651...
```
