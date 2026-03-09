# Ongii 앱 제작 방식 정리 (한글)

## 1) 기준 문서
- 기준 폴더: `markdown_v01`
- 반영 문서:
  - `ONGII_PRODUCT_OVERVIEW.md`
  - `ONGII_INFORMATION_ARCHITECTURE.md`
  - `ONGII_UX_GUIDELINES.md`
  - `ONGII_FLUTTER_STRUCTURE.md`
  - `ONGII_DATA_MODEL.md`

핵심 요구사항은 `Calendar / Feed / Chat / My` 4개 탭 중심 구조, 가족 단위 기록/소통 UX, 단순하고 큰 터치 영역 중심 UI입니다.

## 2) UI 스타일 반영
- 참조 이미지: `example_1.png`, `example_2.png`
- 반영 포인트:
  - 밝은 회색 배경 + 화이트 카드
  - 오렌지 포인트 컬러 (버튼, 선택 상태, 강조 배지)
  - 큰 둥근 모서리(카드/버튼/입력창)
  - 시각적 밀도를 낮춘 단순한 정보 배치

## 3) 코드 구조
문서의 Flutter 구조 제안에 맞춰 아래처럼 분리했습니다.

```text
lib/
  main.dart
  app.dart
  core/theme/app_theme.dart
  shared/models/models.dart
  features/
    home/home_page.dart
    calendar/calendar_page.dart
    feed/feed_page.dart
    chat/chat_page.dart
    profile/my_page.dart
```

## 4) 기능 매핑
- Home
  - `NavigationBar`로 4개 탭 이동
- Calendar
  - 월 캘린더 카드 + 오늘 일정 리스트 + 일정 추가 CTA
- Feed
  - 필터 칩(All/Photo/Text/Notice) + 카드형 게시글 + 공지 고정 UI
- Chat
  - 단일 가족 채팅방 형태 + 좌우 말풍선 + 입력 컴포저
- My
  - 프로필/가족 구성원/설정 메뉴(알림, 권한, 보안, 지원)

## 5) 데이터 모델 반영 방식
`ONGII_DATA_MODEL.md` 기반으로 아래 도메인 모델을 추가했습니다.
- `OngiiUser`
- `OngiiEvent`
- `OngiiPost`
- `OngiiChatMessage`

현재는 MVP UI 확인 목적이라 로컬 더미 데이터로 렌더링하며, 이후 Firebase/서버 연동 시 모델을 그대로 확장할 수 있게 구성했습니다.

## 6) 확장 가이드
다음 단계에서 권장되는 작업:
1. 상태관리 도입 (`Riverpod` 또는 `Bloc`)
2. Repository 계층 추가 및 API/Firebase 연결
3. 일정 CRUD/피드 작성/채팅 전송 기능 실제 구현
4. 디자인 시스템 토큰(간격/라운드/타이포) 상수화
