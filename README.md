# Ongii Project

Ongii는 가족 단위 일정/피드/채팅/프로필 기능을 제공하는 Flutter 앱입니다.  
이 문서는 저장소를 새 PC에 클론한 뒤 바로 개발을 시작할 수 있도록 환경 구성과 실행 절차를 정리합니다.

## 프로젝트 소개

- 가족 일정 관리(Calendar)
- 가족 소식 피드(Feed)
- 가족 채팅(Chat)
- 프로필/가족 관리(My)

## 사용 기술

- Flutter (Material 3)
- Dart
- Android Gradle Plugin `8.11.1`
- Kotlin Android Plugin `2.2.20`
- Java/JDK 17 (프로젝트 설정 기준)

## Git Clone 방법

```bash
git clone <YOUR_REPOSITORY_URL>
cd ongii_project
```

## 빠른 실행 방법

```bash
flutter pub get
flutter run
```

Android 에뮬레이터/디바이스가 연결되어 있지 않다면 먼저 `flutter devices`로 대상 기기를 확인하세요.

## Flutter / Java 버전 기준

- Dart SDK 제약: `^3.11.0` (`pubspec.yaml`)
- 권장 Flutter: Dart 3.11.x를 포함하는 Stable 버전
- JDK: `17` (Android 설정에서 `sourceCompatibility`/`targetCompatibility`가 17)

## Android Studio / SDK 설정

1. Android Studio 설치
2. SDK Manager에서 아래 항목 설치
- Android SDK Platform (최신 안정 버전 1개 이상)
- Android SDK Command-line Tools (latest)
- Android SDK Build-Tools
3. ANDROID_HOME(또는 ANDROID_SDK_ROOT) 환경 변수 확인
4. Android Studio에서 Flutter/Dart 플러그인 설치

## Visual Studio 설치 항목 (Windows 개발 시)

Windows 데스크톱 빌드가 필요하면 Visual Studio Installer에서 아래 워크로드를 설치하세요.

- `Desktop development with C++`
- Windows 10/11 SDK
- MSVC v143 이상 툴체인
- CMake tools for Windows

## Antigravity 사용 시 주의점

Antigravity(네트워크 가속/보안/우회 계열 도구)를 사용하는 환경에서는 Flutter/Gradle 다운로드 및 디바이스 연결이 간헐적으로 실패할 수 있습니다.

- `flutter pub get` 또는 Gradle 의존성 다운로드 실패 시 Antigravity를 잠시 비활성화 후 재시도
- 사내망/프록시 환경이면 Android Studio Proxy, `JAVA_TOOL_OPTIONS`, `HTTP(S)_PROXY` 설정을 동일하게 맞추기
- USB 디버깅 기기 인식이 불안정하면 Antigravity 실시간 트래픽 필터링 제외 규칙 적용

## flutter doctor -v 기준 정상 상태 예시

아래는 예시이며, 실제 버전 숫자는 로컬 설치 상태에 따라 달라도 됩니다.

```text
[√] Flutter (Channel stable, 3.35.x, on Microsoft Windows [Version ...], locale ko-KR)
[√] Windows Version (Windows 10/11 ...)
[√] Android toolchain - develop for Android devices (Android SDK version ...)
[√] Chrome - develop for the web
[√] Visual Studio - develop Windows apps (Visual Studio 2022 ...)
[√] Android Studio (version ...)
[√] VS Code (version ...)
[√] Connected device (at least 1 available)
[√] Network resources
• No issues found!
```

## 개발환경 문서 링크

통합 문서 폴더: `markdown_01`

- [앱 빌드 프로세스(한글)](./markdown_01/APP_BUILD_PROCESS_KR.md)
- [제품 개요](./markdown_01/ONGII_PRODUCT_OVERVIEW.md)
- [정보 구조](./markdown_01/ONGII_INFORMATION_ARCHITECTURE.md)
- [Flutter 구조](./markdown_01/ONGII_FLUTTER_STRUCTURE.md)
- [데이터 모델](./markdown_01/ONGII_DATA_MODEL.md)
- [UX 가이드라인](./markdown_01/ONGII_UX_GUIDELINES.md)
- [개발 로드맵](./markdown_01/ONGII_DEVELOPMENT_ROADMAP.md)

## 참고

- 현재 저장소는 Android 설정 기준 JDK 17을 요구합니다.
- 새 PC에서 첫 실행 시 `flutter doctor -v` 결과가 모두 체크(`√`)인지 먼저 확인하고 진행하세요.
