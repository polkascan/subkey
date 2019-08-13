# Polkasource Subkey
Polkasource Dockerfile for Subkey
Subkey is a commandline utility included with Substrate that generates or restores Substrate keys. 

## Building Substrate Subkey
Clone repository
```bash
git clone https://github.com/polkasource/subkey.git
```

Change directory
```bash
cd subkey
```

Check available releases
```bash
git tag
```

Checkout a particular release (v2.0.0)
```bash
git checkout v2.0.0
```

Build Subkey (v2.0.0)
```bash
docker build -t 'polkasource/subkey:v2.0.0' .
```

## Running Subkey
Run Substrate Subkey Help (v2.0.0)
```bash
docker run -it --rm 'polkasource/subkey:v2.0.0'
```

Generate a sr25519 key (v2.0.0)
```bash
docker run -it --rm 'polkasource/subkey:v2.0.0' generate
```

Generate a ed25519 key (v2.0.0)
```bash
docker run -it --rm 'polkasource/subkey:v2.0.0' -e generate
```
