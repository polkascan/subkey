# Polkasource Substrate Subkey
Polkasource Dockerfile for Substrate Subkey
Subkey is a commandline utility included with Substrate that generates or restores Substrate keys. 

## Building Substrate Subkey
Clone repository
```bash
git clone https://github.com/polkasource/substrate-subkey.git
```

Change directory
```bash
cd substrate-subkey
```

Check available releases
```bash
git tag
```

Checkout a particular release (v2.0.0)
```bash
git checkout v2.0.0
```

Build Substrate Subkey (v2.0.0)
```bash
docker build -t 'polkasource/substrate-subkey:v2.0.0' .
```

## Running Substrate Subkey
Run Substrate Subkey Help (v2.0.0)
```bash
docker run -it --rm 'polkasource/substrate-subkey:v2.0.0'
```

Generate a sr25519 key (v2.0.0)
```bash
docker run -it --rm 'polkasource/substrate-subkey:v2.0.0' generate
```

Generate a ed25519 key (v2.0.0)
```bash
docker run -it --rm 'polkasource/substrate-subkey:v2.0.0' -e generate
```