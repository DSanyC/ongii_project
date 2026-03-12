## Skills (English)
A skill is a set of local instructions to follow that is stored in a `SKILL.md` file. Below is the list of skills that can be used. Each entry includes a name, description, and file path so you can open the source for full instructions when using a specific skill.

### Available skills
- skill-creator: Guide for creating effective skills. This skill should be used when users want to create a new skill (or update an existing skill) that extends Codex's capabilities with specialized knowledge, workflows, or tool integrations. (file: C:/Users/cdsan/.codex/skills/.system/skill-creator/SKILL.md)
- skill-installer: Install Codex skills into $CODEX_HOME/skills from a curated list or a GitHub repo path. Use when a user asks to list installable skills, install a curated skill, or install a skill from another repo (including private repos). (file: C:/Users/cdsan/.codex/skills/.system/skill-installer/SKILL.md)
- slides: Build, edit, render, import, and export presentation decks with the preloaded @oai/artifact-tool JavaScript surface through the artifacts tool. (file: C:/Users/cdsan/.codex/skills/.system/slides/SKILL.md)
- spreadsheets: Build, edit, recalculate, import, and export spreadsheet workbooks with the preloaded @oai/artifact-tool JavaScript surface through the artifacts tool. (file: C:/Users/cdsan/.codex/skills/.system/spreadsheets/SKILL.md)

### How to use skills
- Discovery: The list above is the skills available in this session (name + description + file path). Skill bodies live on disk at the listed paths.
- Trigger rules: If the user names a skill (with `$SkillName` or plain text) OR the task clearly matches a skill's description shown above, you must use that skill for that turn. Multiple mentions mean use them all. Do not carry skills across turns unless re-mentioned.
- Missing/blocked: If a named skill isn't in the list or the path can't be read, say so briefly and continue with the best fallback.
- How to use a skill (progressive disclosure):
  1) After deciding to use a skill, open its `SKILL.md`. Read only enough to follow the workflow.
  2) When `SKILL.md` references relative paths (e.g., `scripts/foo.py`), resolve them relative to the skill directory listed above first, and only consider other paths if needed.
  3) If `SKILL.md` points to extra folders such as `references/`, load only the specific files needed for the request; don't bulk-load everything.
  4) If `scripts/` exist, prefer running or patching them instead of retyping large code blocks.
  5) If `assets/` or templates exist, reuse them instead of recreating from scratch.
- Coordination and sequencing:
  - If multiple skills apply, choose the minimal set that covers the request and state the order you'll use them.
  - Announce which skill(s) you're using and why (one short line). If you skip an obvious skill, say why.
- Context hygiene:
  - Keep context small: summarize long sections instead of pasting them; only load extra files when needed.
  - Avoid deep reference-chasing: prefer opening only files directly linked from `SKILL.md` unless you're blocked.
  - When variants exist (frameworks, providers, domains), pick only the relevant reference file(s) and note that choice.
- Safety and fallback: If a skill can't be applied cleanly (missing files, unclear instructions), state the issue, pick the next-best approach, and continue.

## Skills (한국어)
스킬은 `SKILL.md` 파일에 저장된 로컬 지침 모음입니다. 아래는 사용할 수 있는 스킬 목록이며, 각 항목에는 이름, 설명, 파일 경로가 포함되어 있어 필요한 경우 원문 지침을 열어볼 수 있습니다.

### 사용 가능한 스킬
- skill-creator: 효과적인 스킬을 만드는 가이드입니다. 사용자가 Codex 기능을 확장하는 새 스킬을 만들거나(또는 기존 스킬을 업데이트) 하려는 경우 사용합니다. (파일: C:/Users/cdsan/.codex/skills/.system/skill-creator/SKILL.md)
- skill-installer: 큐레이션 목록 또는 GitHub 저장소 경로에서 Codex 스킬을 `$CODEX_HOME/skills`에 설치합니다. 설치 가능한 스킬 목록 요청, 큐레이션 스킬 설치, 다른 저장소(비공개 포함)에서 스킬 설치 요청 시 사용합니다. (파일: C:/Users/cdsan/.codex/skills/.system/skill-installer/SKILL.md)
- slides: artifacts 도구의 사전 로드된 @oai/artifact-tool JavaScript 인터페이스를 통해 프레젠테이션 덱을 생성, 편집, 렌더링, 가져오기, 내보내기 합니다. (파일: C:/Users/cdsan/.codex/skills/.system/slides/SKILL.md)
- spreadsheets: artifacts 도구의 사전 로드된 @oai/artifact-tool JavaScript 인터페이스를 통해 스프레드시트 워크북을 생성, 편집, 재계산, 가져오기, 내보내기 합니다. (파일: C:/Users/cdsan/.codex/skills/.system/spreadsheets/SKILL.md)

### 스킬 사용 방법
- Discovery: 위 목록은 현재 세션에서 사용 가능한 스킬(이름 + 설명 + 파일 경로)입니다. 스킬 본문은 각 경로의 디스크 파일에 있습니다.
- Trigger rules: 사용자가 스킬 이름을 직접 언급하거나(`$SkillName` 또는 일반 텍스트), 작업이 위 스킬 설명과 명확히 일치하면 해당 턴에서 반드시 그 스킬을 사용합니다. 여러 개가 언급되면 모두 사용하며, 재언급되지 않으면 다음 턴으로 자동 유지하지 않습니다.
- Missing/blocked: 언급된 스킬이 목록에 없거나 경로를 읽을 수 없으면 짧게 알리고, 가능한 최선의 대체 방법으로 계속 진행합니다.
- How to use a skill (progressive disclosure):
  1) 스킬 사용을 결정하면 해당 `SKILL.md`를 열고, 워크플로우 수행에 필요한 만큼만 읽습니다.
  2) `SKILL.md`에 상대 경로(예: `scripts/foo.py`)가 나오면 먼저 해당 스킬 디렉터리를 기준으로 해석하고, 필요할 때만 다른 경로를 검토합니다.
  3) `SKILL.md`가 `references/` 같은 추가 폴더를 가리키면, 요청에 필요한 파일만 선택적으로 불러오고 전체를 한 번에 불러오지 않습니다.
  4) `scripts/`가 있으면 큰 코드 블록을 다시 작성하기보다 실행하거나 패치하는 방식을 우선합니다.
  5) `assets/` 또는 템플릿이 있으면 새로 만들지 말고 재사용합니다.
- Coordination and sequencing:
  - 여러 스킬이 해당되면 요청을 충족하는 최소 집합만 선택하고, 사용할 순서를 명시합니다.
  - 어떤 스킬을 왜 쓰는지 한 줄로 알리고, 명백한 스킬을 건너뛰면 이유를 설명합니다.
- Context hygiene:
  - 컨텍스트를 작게 유지합니다. 긴 내용은 요약하고, 추가 파일은 필요할 때만 불러옵니다.
  - 과도한 참조 추적을 피합니다. 막히지 않는 한 `SKILL.md`에서 직접 연결된 파일만 우선 확인합니다.
  - 프레임워크/프로바이더/도메인 변형이 있으면 관련 파일만 선택하고 그 선택을 명시합니다.
- Safety and fallback: 스킬을 깔끔하게 적용할 수 없으면(파일 누락, 지침 불명확 등) 문제를 알리고, 다음으로 적절한 접근을 선택해 계속 진행합니다.

## Validation Timing Protocol (English)
- Do not run validation commands by default.
- Do not run `dart format`.
- Do not run `flutter analyze`.
- Only run validation when the user explicitly requests it.

## Validation Timing Protocol (한국어)
- 기본적으로 검증 명령은 실행하지 않습니다.
- `dart format`을 실행하지 않습니다.
- `flutter analyze`를 실행하지 않습니다.
- 사용자가 명시적으로 요청한 경우에만 검증을 실행합니다.
