# 2. 安装 Firebase

https://firebase.google.com/docs/ios/setup

## **第 1 步**：创建 Firebase 项目

打开控制台 https://console.firebase.google.com/ 创建项目

## **第 2 步**：在 Firebase 中注册您的应用

1. 转到 [Firebase 控制台](https://console.firebase.google.com/)。

2. 在项目概览页面的中心位置，点击 **iOS+** 图标，启动设置工作流。

   如果您已向 Firebase 项目添加了应用，请点击**添加应用**以显示平台选项。

3. 在**软件包 ID** 字段中输入应用的软件包 ID。`xcode` 打开项目 `Runner.xcworkspace` 文件，点击左侧的 `Runner` 选择右侧的 `Signing & Capabilities` 复制 `Bundle Identifier`。

4. （可选）输入其他应用信息：**应用别名**和 **App Store ID**。

   应用别名和 *App Store ID* 在 Firebase 中的作用是什么？

   > - **应用别名**：方便内部使用的标识符，只有您能在 Firebase 控制台中看到
   > - **App Store ID**：Firebase Dynamic Links 使用该 ID [将用户重定向到 App Store 页面](https://firebase.google.com/docs/dynamic-links/use-cases)，Google Analytics（分析）则用它[将转化事件导入 Google Ads](https://support.google.com/google-ads/answer/6366292)。 如果您的应用还没有 App Store ID，您可以稍后在[项目设置](https://console.firebase.google.com/project/_/settings/general)中添加此 ID。

5. 点击**注册应用**。

## **第 3 步**：添加 Firebase 配置文件

1. 点击**下载 GoogleService-Info.plist**，获取 Firebase Apple 平台配置文件 (`GoogleService-Info.plist`)。

> 注意网络环境，如果下载失败，可以后续在控制台下载，通过刷新、更换 chrome 浏览器或者退出重新登录等方法下载 Firebase 配置文件

2. 将配置文件移至 Xcode 项目的根目录中。如果出现提示，请选择将配置文件添加到所有目标。

如果您的项目中有多个软件包 ID，则必须将每个软件包 ID 与 Firebase 控制台中的注册应用相关联，使每个应用都有自己的 `GoogleService-Info.plist` 文件。

`xcode` 打开项目 `Runner.xcworkspace` 文件，点击左侧的 `Runner` 右键选择 `Add Files to “Runner”...`。

## **第 4 步**：将 Firebase SDK 添加到您的应用

如果在项目中没有启用 Firebase 产品，可以略过此步骤。

使用 Swift Package Manager 安装和管理 Firebase 依赖项。

请参阅[我们的安装指南](https://firebase.google.com/docs/ios/installation-methods)，了解将 Firebase SDK 添加到 Apple 项目的不同方式，包括直接导入框架和使用 CocoaPods。

1. 在 Xcode 中打开您的应用项目，依次转到 **File > Add Packages**。

2. 出现提示时，添加 Firebase Apple 平台 SDK 代码库：

3. ```
     https://github.com/firebase/firebase-ios-sdk
   ```

4. 选择要使用的 SDK 版本。**注意**：我们建议您使用默认的（最新）SDK 版本，但您可以根据需要选择较低版本。

5. 选择要使用的 Firebase 库。

   如果您的 Firebase 项目中启用了 Google Analytics（分析），请务必添加 `FirebaseAnalytics`。对于没有 IDFA 收集功能的 Analytics，改为添加 `FirebaseAnalyticsWithoutAdId`。

完成之后，Xcode 将会自动开始在后台解析和下载您的依赖项。

## **第 5 步**：在您的应用中初始化 Firebase

在 `ios/Runner/AppDelegate.swift` 文件下，添加代码 `import FirebaseCore` 和 `FirebaseApp.configure()` 如下：

```swift
import UIKit
import Flutter
import FirebaseCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    print("dummy_value=\(dummy_method_to_enforce_bundling())");
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

如果使用了 Firebase 的相关功能，需要在这里导入，如果没有只需要导入  `import FirebaseCore` 。

到这里就可以正常使用了。
