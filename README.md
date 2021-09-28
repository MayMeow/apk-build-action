# APK build action

Use this to build debug apk.

```yaml
- name: APK Build action
  uses: MayMeow/apk-build/action@v1
  with:
    android-compile-sdk: "30"
    android-build-tools: "30.0.2"
    android-sdk-tools: "6514223"
```