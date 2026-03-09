# Ongii 데이터 모델

## 1. User

- id
- name
- avatarUrl

---

## 2. Event (달력 일정)

- id
- title
- startAt
- endAt
- description
- createdAt

---

## 3. Post (기록)

- id
- type (photo | text | notice)
- authorId
- content
- createdAt
- pinned (bool)

---

## 4. Media

- id
- postId
- url
- takenAt
- tags (array)

---

## 5. Comment

- id
- targetType (event | post)
- targetId
- authorId
- text
- createdAt

---

## 6. ChatMessage

- id
- authorId
- text
- mediaUrl
- createdAt