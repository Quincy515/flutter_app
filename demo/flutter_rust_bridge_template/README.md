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

- Web is not supported yet.

Then go ahead and run `flutter run`! When you're ready, refer to our documentation
[here](https://fzyzcjy.github.io/flutter_rust_bridge/index.html)
to learn how to write and use binding code.

# References
1. http://cjycode.com/flutter_rust_bridge/
2. https://github.com/nickming/FRTodo
3. https://app.yinxiang.com/fx/2b1e41a1-d099-4a87-8a6b-8d5794303377

# 步骤

首先从 [flutter_rust_bridge_template](https://github.com/Desdaemon/flutter_rust_bridge_template) 模板开始，注意因为模版代码可能更新不及时，需要把 `pubspec.yaml` 中的 `flutter_rust_bridge: ` 更新至最新版本，可以避免一些问题。

1. 交叉编译到 Android 需要一些额外的 Rust targets，[文档地址](http://cjycode.com/flutter_rust_bridge/template/setup_android.html)

```shell
rustup target add aarch64-linux-android armv7-linux-androideabi x86_64-linux-android i686-linux-android
```

2. Android NDK

> Android Studio > SDK Manager > SDK Tools > uncheck Hide Obsolete Packages > NDK (version 22)

这里倾向于使用 NDK version 22，因为最新的 NDK 构建 Rust 核心库可能会出现一些意外问题 [issue](https://github.com/rust-lang/rust/pull/85806)。

3. 设置 ANDROID_NDK Gradle property

ANDROID_SDK_HOME 路径通常在以下目录:

- on Windows: `%APPDATA%\Local\Android\sdk`
- on MacOS: `~/Library/Android/sdk`
- on Linux: set via the environment variable ANDROID_SDK_HOME, or `~/Android/sdk`

接下来，你需要让这个 NDK 对 Gradle 可见。通常可以在 ~/ 中添加 `gradle.properties`

```shell
echo "ANDROID_NDK=%APPDATA%/Library/Android/sdk/ndk/22.1.7171670" >> ~/.gradle/gradle.properties
```

4. cargo-ndk

```shell
cargo install cargo-ndk --version 2.6.0
```

cargo-ndk version 2.7 对 NDK Version 22 不是很兼容，所以 NDK Version 22 对应必须使用 cargo-ndk 2.6.0。

5. Installing codegen

```shell
cargo install flutter_rust_bridge_codegen just
dart pub global activate ffigen
# if building for iOS or MacOS
cargo install cargo-xcode
```

注意这里 ffigen 如果安装的是 6.0 版本，需要对应以上版本的 `flutter_rust_bridge: ^1.37.2`

6. Dart dependencies

```shell
flutter pub add flutter_rust_bridge
# if using Dart codegen
flutter pub add -d build_runner
flutter pub add -d freezed
flutter pub add freezed_annotation
```

7. Running the codegen

```shell
flutter_rust_bridge_codegen \
    -r native/src/api.rs \
    -d lib/bridge_generated.dart
```

8. 到这里应该就可以正常开发

