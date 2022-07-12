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

# Android 步骤

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
echo "ANDROID_NDK=~/Library/Android/sdk/ndk/22.1.7171670" >> ~/.gradle/gradle.properties
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

# IOS 步骤

1. IOS setup

iOS requires some additional Rust targets for cross-compilation:

```bash
# 64 bit targets (real device & simulator):
rustup target add aarch64-apple-ios x86_64-apple-ios
# New simulator target for Xcode 12 and later
rustup target add aarch64-apple-ios-sim
# 32 bit targets (you probably don't need these):
rustup target add armv7-apple-ios i386-apple-ios
```

2. 注意 `Cargo.toml` 中

```toml
[lib]
crate-type = ["lib", "cdylib", "staticlib"]
```

where

- `lib` is required for non-library targets, such as tests and benchmarks
- `staticlib` is required for iOS
- `cdylib` for all other platforms

3. Running the codegen

```bash
flutter_rust_bridge_codegen \
    -r $crate/src/api.rs \
    -d lib/bridge_generated.dart \
    -c ios/Runner/bridge_generated.h \
    -c macos/Runner/bridge_generated.h   # if building for MacOS
```

4. Linking the project

在 Xcode 中打开 `ios/Runner.xcodeproj`。在模版代码中 Runner 子目录中有 `native`

![ios_proj_tree](http://cjycode.com/flutter_rust_bridge/integrate/ios_proj_tree.png)

注意在 Runner 根目录下有一个 `$crate/$crate.xcodeproj` 这里可以把他删除。如果 `Runner` 子目录下没有 `native` ，可以在 `Rust` `crate` 的 `native` 目录下手动生成。

```bash
cargo xcode
```

点击最上方的 `Runner`，然后点击右侧的 **Build Phases** tab. 首先添加 **Dependencies**, 注意 **$crate-staticlib** for iOS,  **$crate-cdylib** for MacOS.

![ios_dep_phase](http://cjycode.com/flutter_rust_bridge/integrate/ios_dep_phase.png)

然后添加 **Link Binary With Libraries**,  **lib$crate_static.a** for iOS,  **$crate.dylib** for MacOS.

![ios_link_phase](http://cjycode.com/flutter_rust_bridge/integrate/ios_link_phase.png)

5. 到这里就可以了，注意点击`ios/Runner.xcworkspace` 打开 Xcode 进行运行

> **Note**: 如果碰到了 [Module 'path_provider' not found](https://stackoverflow.com/questions/64258476/module-path-provider-not-found) 问题，可以把 ios 目录下文件 Podfile 中
>
> `# platform :ios, '9.0'` 修改为 `platform :ios, '11.0'`
