# Alternate templates

This folder includes 1:1 alternate templates that are implemented for `spruce merge` rather than `bosh interpolate`

This comparison assumes you have deployed a bosh and have a `creds.yml` with credentials; and `vars.yml` with the required variables in it.

To compare the `bosh.yml` and `bosh-lite.yml` for `bosh2 interpolate` and `spruce merge`:

```
./spruce/compare.sh
```

The output will look like:

```
both files are semantically equivalent; no differences found!
```
