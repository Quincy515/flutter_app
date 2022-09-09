# flutter_rust_bridge_template

This repository serves as a template for Flutter projects calling into native Rust
libraries via `flutter_rust_bridge`.

## Getting Started

To begin, ensure that you have a working installation of the following items:
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Rust language](https://rustup.rs/)
- Appropriate [Rust targets](https://rust-lang.github.io/rustup/cross-compilation.html) for cross-compiling to your device
- For Android targets:
    - Install [cargo-ndk](https://github.com/bbqsrc/cargo-ndk#installing)
    - Install Android NDK 22, then put its path in one of the `gradle.properties`, e.g.:

```
echo "ANDROID_NDK=.." >> ~/.gradle/gradle.properties
```

- [Web dependencies](http://cjycode.com/flutter_rust_bridge/template/setup_web.html) for the Web

Then go ahead and run `flutter run`! When you're ready, refer to our documentation
[here](https://fzyzcjy.github.io/flutter_rust_bridge/index.html)
to learn how to write and use binding code.

## Web setup
Building on web requires nightly Rust, the wasm32-unknown-unknown target and wasm-pack, which can be installed using these commands:

```
rustup toolchain install nightly
rustup +nightly component add rust-src
rustup +nightly target add wasm32-unknown-unknown
# either of these
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
cargo install wasm-pack
```
Optionally (but highly recommended), install flutter_rust_bridge_serve to expedite the process of building the WASM binary and setting up HTTP headers:

```
# in your Flutter/Dart package
flutter pub add flutter_rust_bridge
# then run this instead of "flutter web -d chrome"
dart run flutter_rust_bridge:serve
# or install globally
dart pub global activate flutter_rust_bridge
flutter_rust_bridge_serve
```