# Shared Skills

一組給 Claude Code（或任何能讀 markdown 並照著執行的 AI CLI，例如 Codex）使用的「管理技能」與「個人生產力技能」，用純 markdown 定義，沒有 Claude 專屬語法，附結構驗證機制。

這個 repo 可以獨立使用，也可以當作 git submodule 掛在其他專案下使用。

---

## 目錄結構

```text
shared-skills/
├── _shared/
│   └── conventions.md          # 所有 skill 都必須遵守的共用規則（唯一權威來源）
├── docs/                       # 非 skill 的參考資料/範本
│   ├── README.md
│   ├── action-register.md      # 行動追蹤表（活文件，手動維護）
│   └── raci-matrix.md          # RACI 責任分配表（活文件，手動維護）
├── validate-skills.sh          # 結構與安全啟發式驗證腳本
└── <skill-name>/SKILL.md       # 每個 skill 一個資料夾
```

`_shared/` 和 `docs/` 不是 skill，`validate-skills.sh` 掃描每個子目錄時會跳過這兩個。

---

## 這些 skill 是什麼、怎麼運作

每個 `SKILL.md` 都是給 Claude 讀的「操作手冊」，固定包含 8 個區塊：

| 區塊 | 作用 |
|---|---|
| Trigger | 什麼情境該用這個 skill |
| Required Input | 需要提供哪些資料才能執行 |
| Workflow | Claude 內部該怎麼一步步分析 |
| Output Contract | 輸出必須長什麼樣子（哪些欄位、順序） |
| Safety Constraints | 絕對不能做的事（例如捏造事實、承諾客戶、洩漏敏感資訊） |
| Missing-Data Behavior | 資料不足時該怎麼誠實表達「不知道」，而不是硬掰 |
| Self-Review Checklist | Claude 產出後自我檢查用的清單 |
| Anonymized Eval Case | 一個匿名化的測試情境，驗證這個 skill 在壓力下會不會被「說服」違反安全規則 |

所有 skill 共同遵守 `_shared/conventions.md` 訂的規則，包括：

- 每個事實陳述都要附 **Source ID**（可追溯出處，例如 ticket 編號、對話紀錄、dashboard 連結）
- 每句斷言都要標明是 **Fact（已證實）／Pattern（多筆事實歸納出的趨勢）／Hypothesis（未證實的推測）**，三者不能混為一談
- 不得捏造客戶承諾、incident root cause、人員績效判斷、交付日期或成本效益數字
- 任何要對外（客戶）或對人（1:1、績效）發送的內容，輸出的都只是**草稿**，需要人工審核簽核後才能送出
- 不會宣稱自己執行了任何破壞性操作、雲端環境變更、合約承諾、或代表公司承認責任——這些 skill 只產出分析與建議，實際行動永遠由人決定

---

## 怎麼使用

### 方式一：手動指名檔案（任何 AI CLI 都能用）

跟 Claude／Codex 說明情境，並直接指向 skill 檔案，例如：

> 「請照 `shared-skills/project-recovery-plan/SKILL.md` 的定義，幫我針對 XX 專案做一份 recovery plan。以下是目前的狀況：……」

Claude 會讀取該 `SKILL.md`，照 Required Input 檢查有沒有給夠資料，缺的部分依 Missing-Data Behavior 明講「證據不足」，然後照 Workflow 產出 Output Contract 規定的欄位。

**準備好 Required Input 欄位列的資料再開口，能省掉一輪來回。**

### 方式二：Claude Code 原生發現

Claude Code 的 Skill 工具是從 `.claude/skills/<name>/SKILL.md` 探索 skill 的，不是這裡的 `shared-skills/`。如果把這個 repo 掛成某個專案的 submodule，可以在該專案寫一支安裝腳本，把 `shared-skills/<name>/` symlink 到 `.claude/skills/<name>/`，讓 Claude Code 原生列出並主動提議使用這些 skill。

### 方式三：Codex

Codex 沒有原生 skill 探索機制，但 `SKILL.md` 只是純 markdown，一樣可以「指名檔案＋照著執行」，或去掉 YAML frontmatter 後存成 Codex 的 custom prompt（`~/.codex/prompts/*.md`），用 `/<skill-name>` 呼叫。

### 驗證

新增/修改 skill 後執行：

```bash
bash validate-skills.sh
```

會檢查 8 個必要區塊、frontmatter、Source ID／Fact／Hypothesis 標記慣例、以及操作性段落有沒有出現未經限定的絕對承諾語句。這是**結構性**檢查，抓不到語意上的漏洞。

---

## Skill 分類索引

### A. 交付與專案管理

| Skill | 什麼時候用 |
|---|---|
| `delivery-health-review` | 定期檢視單一專案或整個 portfolio 的交付健康度，需要一份有證據支撐的狀態報告 |
| `project-recovery-plan` | 專案延遲、失控、scope 跑掉、依賴卡住，或利害關係人信任下降，需要一份復原計畫 |
| `capacity-roadmap-scenarios` | 季度規劃、要人、或多個專案搶產能時，需要維持現狀/人力受限/加速衝刺三種情境對比 |

### B. Incident、可靠性與雲端營運

| Skill | 什麼時候用 |
|---|---|
| `incident-executive-update` | Incident 進行中，需要對主管/利害關係人發狀態更新，但 root cause 還沒確認 |
| `postmortem-facilitator` | Incident/失敗 release/資安 near-miss 已結束，需要無責備檢討報告 |
| `cloud-cost-reliability-review` | 定期檢視 AWS/GCP 花費、SLO、容量與 observability |
| `architecture-decision-record` | 重大技術決策需要記錄 context、選項、取捨、rollback 計畫（ADR） |

### C. 客戶、售前與跨組織交付

| Skill | 什麼時候用 |
|---|---|
| `customer-escalation-management` | 客戶不滿、SLA 風險、重大交付失敗、續約風險、或 incident 升級到客戶層級 |
| `commitment-risk-review` | Sales/PM/客戶提出新承諾，**在承諾出去之前**先做工程可行性檢查 |
| `managed-service-operations-review` | 團隊維運多客戶雲端服務（MSP 型態），定期檢視 SLA/on-call/backlog |

### D. 人才與組織能力

| Skill | 什麼時候用 |
|---|---|
| `feedback-growth-plan` | 準備例行 1:1 回饋、角色成長對話、期待校準 |
| `hiring-interview-calibration` | 設計工程職缺的面試流程、scorecard、debrief 框架 |
| `role-clarity-decision-rights` | 角色重疊、責任不清，需要設計 DRI/Approver/Consulted/Informed 提案 |

### E. 個人生產力與工作流自動化

| Skill | 什麼時候用 |
|---|---|
| `daily-priority-briefing` | 每天上班前，把行事曆＋信件/ticket＋昨天沒做完的事整理成優先序清單 |
| `weekly-wrapup-focus` | 每週五收尾本週完成事項＋建議下週 focus |
| `notes-to-action-digest` | Email/會議/Slack 內容拆成決策事項/待辦/待釐清問題/純資訊 |
| `one-on-one-prep-briefing` | 1-1 會前根據歷史記錄/上次 action items 做 briefing |
| `team-standup-digest` | Async 站會回報彙整成「誰卡住/需要介入」摘要 |
| `retro-synthesis` | Retro 白板零散 note 歸納成主題＋排序過的 action item |
| `cross-team-dependency-log` | 跨團隊依賴/RAID 追蹤 |
| `meeting-agenda-draft` | 依會議目的/參與者/時長草擬議程 |
| `engineering-metrics-review` | 貼上原始指標數字，產出趨勢分析與瓶頸識別 |
| `meeting-notes-to-structured-doc` | 零散會議記錄整合成結構化知識文件草稿 |
| `hiring-pipeline-status` | 候選人各階段狀態彙整成 pipeline 總覽 |
| `meeting-participation-balance-review` | 貼上 talk-time/參與度分析數據，檢視自己有沒有講太多 |
| `cross-meeting-topic-tracker` | 用跨會議關鍵字搜尋找到同一主題在多場會議的討論，整理成時間軸演變摘要 |
| `action-register-maintainer` | 開完會，建議 `docs/action-register.md` 該新增/更新哪些列（只建議，不自己動手改檔案） |

---

## Skill 之間的相互依賴

大部分 skill 是獨立的，可以單獨呼叫。以下是有明確依賴/串接關係的部分：

### 沿用另一個 skill 的輸出當輸入

| 這個 skill | 依賴/沿用 | 關係說明 |
|---|---|---|
| `project-recovery-plan` | `delivery-health-review` | Required Input 建議直接沿用 `delivery-health-review` 的事實表格，不用重新推導一次 |

### 產出「提案」，交給另一份活文件長期維護

| 這個 skill | 產出流向 | 關係說明 |
|---|---|---|
| `role-clarity-decision-rights` | `docs/raci-matrix.md` | 這個 skill 只產出待確認的 DRI/Approver/Consulted/Informed **提案**，人確認後才手動填進 `docs/raci-matrix.md` 當長期維護版本 |

### 輸出的 action item 可以匯入 Action Register 持續追蹤

以下 skill 的 Output Contract 都有一條「延伸追蹤（選填）」，指向 `action-register-maintainer` + `docs/action-register.md`：

`notes-to-action-digest`、`daily-priority-briefing`、`weekly-wrapup-focus`、`one-on-one-prep-briefing`、`team-standup-digest`、`retro-synthesis`、`postmortem-facilitator`、`delivery-health-review`、`project-recovery-plan`、`customer-escalation-management`、`managed-service-operations-review`、`cloud-cost-reliability-review`、`commitment-risk-review`、`cross-team-dependency-log`、`meeting-notes-to-structured-doc`

用法：先跑上面某個 skill 產出 action item，把結果連同目前的 `docs/action-register.md` 一起餵給 `action-register-maintainer`，它會建議新增/更新哪些列——**只建議，不會自己改檔案**，你確認後自己手動套用。

### 輸出牽涉到責任歸屬時，指向 role-clarity-decision-rights

以下 skill 的輸出如果碰到「負責人反覆不清楚」的情況，會建議先用 `role-clarity-decision-rights` 產出提案，確認後維護在 `docs/raci-matrix.md`：

`delivery-health-review`、`customer-escalation-management`、`commitment-risk-review`、`architecture-decision-record`、`cross-team-dependency-log`

### 明確互斥/分工的 skill（避免搞混用哪個）

| 情境 | 用這個 | 不要用這個 |
|---|---|---|
| 想要一份可長期參考的知識文件本體 | `meeting-notes-to-structured-doc` | `notes-to-action-digest`（這個是拆待辦，不是寫文件） |
| 想要拆解決策/待辦/待釐清清單 | `notes-to-action-digest` | `meeting-notes-to-structured-doc`（待辦事項不寫進文件本體，只會簡短提示並建議改用前者） |
| 1-1 準備時遇到敏感績效/回饋內容 | `feedback-growth-plan` | `one-on-one-prep-briefing`（這個 skill 明確排除產出新的績效判斷，遇到敏感情境會提示改用前者） |
| 從零開始釐清角色重疊 | `role-clarity-decision-rights`（產出待確認提案） | 直接手改 `docs/raci-matrix.md`（那是給已經定案的版本維護用的） |

### 刻意不接進 Action Register 的 skill

`feedback-growth-plan` 的輸出屬於敏感人事內容（觀察到的行為、成長領域、對話草案），刻意沒有加上「延伸追蹤」指向共用的 `docs/action-register.md`，避免跟其他事務性 action item 混在同一份可能被更多人看到的追蹤表裡。
