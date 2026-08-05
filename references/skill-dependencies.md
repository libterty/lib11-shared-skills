# Skill 之間的相互依賴

大部分 skill 是獨立的，可以單獨呼叫。以下是有明確依賴/串接關係的部分。

## 沿用另一個 skill 的輸出當輸入

| 這個 skill | 依賴/沿用 | 關係說明 |
|---|---|---|
| `project-recovery-plan` | `delivery-health-review` | Required Input 建議直接沿用 `delivery-health-review` 的事實表格，不用重新推導一次 |
| `strategy-execution-review` | `strategy-execution-mbto-check` | Required Input 建議直接沿用 `strategy-execution-mbto-check` 產出的 Pilot 骨架裡「最重要的假設」清單，當作每週回顧的原始假設 |

## 產出「提案」，交給另一份活文件長期維護

| 這個 skill | 產出流向 | 關係說明 |
|---|---|---|
| `role-clarity-decision-rights` | `docs/raci/<檔名>.md` | 這個 skill 只產出待確認的 DRI/Approver/Consulted/Informed **提案**，人確認後才手動填進 `docs/raci/<檔名>.md` 當長期維護版本 |
| `architecture-decision-record` | `docs/adr/<流水號>-<簡述>.md` | 這個 skill 產出的 ADR 內容直接存進一個新的 ADR 檔案（一個決策一個檔案，範本見 `docs/adr.template.md`）；沒有另外的「維護建議」skill，因為 ADR 本來就是一次性產出，之後偶爾手動更新狀態即可 |

## 輸出的 action item 可以匯入 Action Register 持續追蹤

以下 skill 的 Output Contract 都有一條「延伸追蹤（選填）」，指向 `action-register-maintainer` + `docs/ar/<檔名>.md`：

`notes-to-action-digest`、`daily-priority-briefing`、`weekly-wrapup-focus`、`one-on-one-prep-briefing`、`team-standup-digest`、`retro-synthesis`、`postmortem-facilitator`、`delivery-health-review`、`project-recovery-plan`、`customer-escalation-management`、`managed-service-operations-review`、`cloud-cost-reliability-review`、`commitment-risk-review`、`cross-team-dependency-log`、`meeting-notes-to-structured-doc`、`strategy-execution-review`

用法：先跑上面某個 skill 產出 action item，把結果連同目前的 `docs/ar/<檔名>.md` 一起餵給 `action-register-maintainer`，它會建議新增/更新哪些列——**只建議，不會自己改檔案**，你確認後自己手動套用。通用範例（把 `[XXX]` 換成清單裡任一個 skill）：

```text
1) 「請照 [XXX]/SKILL.md 的定義，幫我處理：……」
   → 輸出裡的「延伸追蹤」欄位會提示可以匯入 Action Register

2) 「請照 action-register-maintainer/SKILL.md 的定義，讀取以下目前的 Action Register，
   跟步驟 1 的輸出比對，建議新增/更新哪些列：
   [貼上 docs/ar/<檔名>.md 目前內容] + [步驟 1 的完整輸出]」
   → 得到建議異動清單，確認後自己手動套用到 docs/ar/<檔名>.md
```

具體例子（`cloud-cost-reliability-review` → `action-register-maintainer`）：

```text
1) 「請照 cloud-cost-reliability-review/SKILL.md 的定義，幫我檢視這季的雲端成本與可靠性。
   帳單匯出如下：……，SLO 儀表板資料如下：……」
   → 得到快贏機會與優先改善項目清單（各附負責人/檢視日期）

2) 「請照 action-register-maintainer/SKILL.md 的定義，讀取以下目前的 Action Register，
   跟步驟 1 的快贏機會/優先改善項目比對，建議新增/更新哪些列：
   [貼上 docs/ar/<檔名>.md 目前內容] + [步驟 1 的清單]」
   → 得到建議異動清單，確認後自己手動套用
```

## 輸出牽涉到責任歸屬時，指向 role-clarity-decision-rights

以下 skill 的輸出如果碰到「負責人反覆不清楚」的情況，會建議先用 `role-clarity-decision-rights` 產出提案，確認後維護在 `docs/raci/<檔名>.md`：

`delivery-health-review`、`customer-escalation-management`、`commitment-risk-review`、`architecture-decision-record`、`cross-team-dependency-log`

範例（`architecture-decision-record` → `role-clarity-decision-rights`）：

```text
1) 「請照 architecture-decision-record/SKILL.md 的定義，幫我記錄 [某個技術決策]：……」
   → 產出 ADR，但「決策負責人」這欄如果反覆填不出一個明確的人/角色

2) 「請照 role-clarity-decision-rights/SKILL.md 的定義，
   幫我針對『[這個決策類型] 的負責人反覆不清楚』這個具體事件，
   設計一份決策權責提案：……」
   → 得到待確認的 DRI/Approver/Consulted/Informed 提案

3) 跟相關人員確認過後，手動把定案結果填進 docs/raci/<檔名>.md 長期維護，
   之後同類型決策直接查表，不用每次都重跑 skill
```

## 明確互斥/分工的 skill（避免搞混用哪個）

| 情境 | 用這個 | 不要用這個 |
|---|---|---|
| 想要一份可長期參考的知識文件本體 | `meeting-notes-to-structured-doc` | `notes-to-action-digest`（這個是拆待辦，不是寫文件） |
| 想要拆解決策/待辦/待釐清清單 | `notes-to-action-digest` | `meeting-notes-to-structured-doc`（待辦事項不寫進文件本體，只會簡短提示並建議改用前者） |
| 1-1 準備時遇到敏感績效/回饋內容 | `feedback-growth-plan` | `one-on-one-prep-briefing`（這個 skill 明確排除產出新的績效判斷，遇到敏感情境會提示改用前者） |
| 從零開始釐清角色重疊 | `role-clarity-decision-rights`（產出待確認提案） | 直接手改 `docs/raci/<檔名>.md`（那是給已經定案的版本維護用的） |

## 刻意不接進 Action Register 的 skill

`feedback-growth-plan` 的輸出屬於敏感人事內容（觀察到的行為、成長領域、對話草案），刻意沒有加上「延伸追蹤」指向共用的 `docs/ar/<檔名>.md`，避免跟其他事務性 action item 混在同一份可能被更多人看到的追蹤表裡。
