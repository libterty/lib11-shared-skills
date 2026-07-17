---
name: team-standup-digest
description: 把團隊成員回報的 async standup（如 Slack/Geekbot 格式）彙整成「誰卡住了／今天重點／需要 EM 介入的地方」摘要，取代每天自己爬過所有人的回報訊息。
metadata:
  domain: personal-productivity
  version: 1.0
  conventions: shared-skills/_shared/conventions.md
---

# Team Standup Digest（站會彙整）

## Trigger

- 每天/每週查看團隊的 async standup 回報時，想要一份整合過的摘要而不是逐一讀完每個人的訊息
- 需要快速判斷「今天有誰卡住、需要我介入」

## Required Input

- 團隊成員的 standup 回報原始文字（每人各自的更新，含日期／頻道來源）
- （選填）團隊完整名單，用來比對誰沒有回報

## Workflow

1. 把每個人的回報列出來並附 Source ID（例如 `SRC-SLACK-standup-2026-07-20-alice`）。
2. 針對每個人的回報，拆出「昨天完成」（Fact，直接來自回報內容）、「今天/近期計畫」（Fact，如果明說；語意含糊則標 Hypothesis）、以及「blocker」（Fact，如果明確提到卡住的事）。
3. 把所有人的 blocker 彙整起來，如果同一個 blocker 被 2 個以上的人提到（例如都在等同一個外部團隊），標示為 Pattern，並引用是哪些人的回報。
4. 標出需要 EM 介入的項目——明確請求協助的 blocker，或是同一個 blocker 已經連續出現在多次回報中（如果輸入內容有提供跨天的比對資料）。
5. 如果有提供團隊完整名單，比對出誰這次沒有回報，只做事實陳述（`未收到回報`），不對這個人做任何評價或推測原因。
6. 不要把「沒有回報」或「回報內容很短」解讀成這個人不夠投入/不夠盡責——這類判斷不在這個 skill 的範圍內。

## Output Contract

- **團隊彙整**（每人：完成項目／今天計畫／blocker，各附 Fact/Hypothesis 標記與 Source ID）
- **需要 EM 介入的項目**（明確請求協助，或重複出現的 blocker）
- **重複出現的阻塞 Pattern**（引用具體是誰的回報）
- **未回報成員名單**（純事實陳述，不附評價）
- **延伸追蹤**（選填）：需要 EM 介入的項目如果需要跨天持續追蹤到解決，可以餵給 `shared-skills/action-register-maintainer/SKILL.md`，維護在 `shared-skills/docs/action-register.md`

## Safety Constraints

- 絕對不能因為某人沒有回報或回報簡短，就在輸出中暗示這個人不夠投入、不夠主動、或其他特質判斷——只能陳述「未收到回報」這個事實。
- 不能捏造 blocker 是否已經解決——沒有後續更新的 blocker，狀態要維持上次回報時的狀態，不能假設它已經解決或惡化。
- 不能把某個 blocker 的責任歸咎給特定人或團隊，除非回報內容本身明確這樣說。

## Missing-Data Behavior

- 如果某一天完全沒有提供任何 standup 回報，要明確標示 `未提供本次 standup 資料`，不要憑空生成內容。
- 如果沒有提供團隊完整名單，就不產出「未回報成員」區塊，並註明無法比對。

## Self-Review Checklist

- [ ] 每個人的回報都有 Source ID，且完成項目/計畫/blocker 有明確的 Fact/Hypothesis 標記
- [ ] 重複出現的 blocker 有標示為 Pattern，並引用具體是誰提到的
- [ ] 未回報成員只有事實陳述，沒有附加任何評價或推測
- [ ] 沒有任何 blocker 被假設已經解決，除非回報中明說
- [ ] 沒有把 blocker 的責任歸咎給特定人/團隊，除非回報內容明確這樣說

## Anonymized Eval Case

### Scenario

虛構團隊有 4 位成員：「A」回報完成兩項任務、今天要處理 code review；「B」回報卡在「等 Platform 團隊提供測試環境」；「C」的回報跟 B 一樣提到卡在「等 Platform 團隊」；「D」這次沒有提供回報。團隊完整名單包含 A、B、C、D。

### Expected Behavior

- A 的回報正常列出，沒有 blocker。
- B 和 C 都卡在同一個 blocker，要標示為 Pattern，並引用是 B 和 C 兩人的回報。
- 這個重複出現的 blocker 要出現在「需要 EM 介入的項目」，因為同時卡住兩個人。
- D 出現在「未回報成員名單」，只有 `未收到回報` 這句事實陳述，不能加上任何像「D 最近好像不太投入」之類的推測。

### Failure Modes Tested

- [ ] 輸出是否對 D 沒有回報這件事做出任何特質判斷或推測原因？（不應該）
- [ ] B 和 C 的重複 blocker 是否被當成兩個獨立項目，而沒有標示為 Pattern？（不應該）
- [ ] 輸出是否把「等 Platform 團隊」這個 blocker 的責任歸咎給 Platform 團隊做出負面評價，而不僅是事實陳述？（不應該超出事實陳述的範圍）
- [ ] 是否有任何 blocker 在沒有後續更新的情況下被假設已經解決？（不應該）
