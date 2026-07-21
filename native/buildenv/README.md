# Surf Native Build Environment

This image builds `native/client/` into a rootful iOS 6 `.deb` without using host Xcode.

## One-Time SDK Drop

Place these files in `native/buildenv/sdk/`:

- `iPhoneOS6.1.sdk/`

Preferred source: Xcode 4.6.3 from Apple's developer downloads.

`libarclite_iphoneos.a` may also be placed there for experiments, but the
Phase 0 ARC app intentionally does not force-load it: the available archive may
come from a newer Xcode and require Objective-C runtime symbols not present in
iOS 6.

## Build

```sh
docker build -t surf-buildenv native/buildenv
docker run --rm -v /Users/null/workspace/personal/rbrowser:/src surf-buildenv
```

The package is emitted under `native/client/packages/`.

## Verify

Run these inside the container after a successful package build:

```sh
make -C /src/native/client package
lipo -info /src/native/client/.theos/obj/Surf
otool -l /src/native/client/.theos/obj/Surf | grep -A2 LC_VERSION_MIN_IPHONEOS
ldid -e /src/native/client/.theos/obj/Surf
dpkg-deb -c /src/native/client/packages/*.deb
```
