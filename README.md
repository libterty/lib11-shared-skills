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
│   ├── ar.template.md          # Action Register 範本（公開，追蹤進 git）
│   ├── raci.template.md        # RACI Matrix 範本（公開，追蹤進 git）
│   ├── adr.template.md         # ADR 範本，一個決策一個檔案（公開，追蹤進 git）
│   ├── ar/                     # 實際的 Action Register 內容（.gitignore 排除，只留 .gitkeep）
│   ├── raci/                   # 實際的 RACI Matrix 內容（.gitignore 排除，只留 .gitkeep）
│   └── adr/                    # 實際的 ADR 內容（.gitignore 排除，只留 .gitkeep）
├── validate-skills.sh          # 結構與安全啟發式驗證腳本
└── <skill-name>/SKILL.md       # 每個 skill 一個資料夾
```

`_shared/` 和 `docs/` 不是 skill，`validate-skills.sh` 掃描每個子目錄時會跳過這兩個。`docs/ar/`、`docs/raci/`、`docs/adr/` 底下會累積真實的內部資訊（實際 action item、實際責任分配、實際架構決策），所以整個被 `.gitignore` 排除——複製對應的 `*.template.md` 到這些資料夾底下開始用，不會不小心把內部內容提交進這個公開 repo。細節見 `docs/README.md`。

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
| `action-register-maintainer` | 開完會，建議 `docs/ar/<檔名>.md` 該新增/更新哪些列（只建議，不自己動手改檔案） |

---

## Day-to-day / 每週工作節奏怎麼用

### 每天

| 時機 | Skill | 範例呼叫 |
|---|---|---|
| 上班前 | `daily-priority-briefing` | 「請照 `shared-skills/daily-priority-briefing/SKILL.md` 的定義，幫我盤點今天的優先序。今天的行事曆是：……，未處理的信件/ticket 有：……」 |
| 開完任何會議（不限形式） | `notes-to-action-digest` | 「請照 `shared-skills/notes-to-action-digest/SKILL.md` 的定義，幫我拆解這段會議記錄。逐字稿如下：……」 |
| 1-1 開始前幾分鐘 | `one-on-one-prep-briefing` | 「請照 `shared-skills/one-on-one-prep-briefing/SKILL.md` 的定義，幫我準備跟 [對象] 的 1-1。上次的 1-1 筆記是：……」 |
| 查看團隊 async standup 回報 | `team-standup-digest` | 「請照 `shared-skills/team-standup-digest/SKILL.md` 的定義，幫我彙整今天的站會回報：……」 |

### 每週

| 時機 | Skill | 範例呼叫 |
|---|---|---|
| 週五收尾 | `weekly-wrapup-focus` | 「請照 `shared-skills/weekly-wrapup-focus/SKILL.md` 的定義，幫我總結這週完成的事，並建議下週 focus。這週完成的項目：……」 |
| Retro 結束後 | `retro-synthesis` | 「請照 `shared-skills/retro-synthesis/SKILL.md` 的定義，幫我整理這次 retro 的 sticky note：……」 |
| 定期專案健康度檢視 | `delivery-health-review` | 「請照 `shared-skills/delivery-health-review/SKILL.md` 的定義，幫我檢視 [專案] 這兩週的交付健康度。ticket 匯出如下：……」 |
| 跨團隊依賴檢查 | `cross-team-dependency-log` | 「請照 `shared-skills/cross-team-dependency-log/SKILL.md` 的定義，幫我彙整目前跨團隊的依賴狀態：……」 |

### 串連使用的情境

單一 skill 通常只處理一段輸入到一份輸出；下面是實際工作中常見的「上一個 skill 的輸出，餵給下一個 skill 當輸入」的串接場景。

#### 1. 會議 → 拆待辦 → 跨週期追蹤

```text
1) 「請照 notes-to-action-digest/SKILL.md 的定義，幫我拆解這場會議的逐字稿：……」
   → 得到待辦事項清單（含負責人/截止日期）

2) 「請照 action-register-maintainer/SKILL.md 的定義，讀取以下目前的 Action Register，
   跟這次會議拆出來的待辦事項比對，建議新增/更新哪些列：
   [貼上 docs/ar/<檔名>.md 目前內容] + [步驟 1 的待辦事項清單]」
   → 得到建議的異動清單，自己確認後手動套用到 docs/ar/<檔名>.md
```

#### 2. Retro → Action item → 追蹤

```text
1) 「請照 retro-synthesis/SKILL.md 的定義，幫我整理這次 retro 的 sticky note：……」
   → 得到主題分群與排序過的 action item 草案

2) 團隊確認負責人/截止日期後，用同一批 action item 呼叫 action-register-maintainer
   → 建議加進 docs/ar/<檔名>.md
```

#### 3. 專案出狀況 → 健康度檢視 → 復原計畫

```text
1) 「請照 delivery-health-review/SKILL.md 的定義，幫我檢視 [專案] 的交付健康度：……」
   → 得到事實表格與各維度狀態

2) 如果狀態明顯偏紅：「請照 project-recovery-plan/SKILL.md 的定義，
   沿用上面 delivery-health-review 的事實表格，幫我做一份復原計畫」
   → project-recovery-plan 的 Required Input 會直接沿用步驟 1 的事實，不用重新蒐集
```

#### 4. 責任歸屬不清 → 提案 → 定案維護

```text
1) 「請照 role-clarity-decision-rights/SKILL.md 的定義，
   幫我針對 [角色重疊的具體事件] 設計一份決策權責提案：……」
   → 得到待確認的 DRI/Approver/Consulted/Informed 提案

2) 跟相關人員確認過後，手動把定案結果填進 docs/raci/<檔名>.md 長期維護
   （不是每次都重跑 skill，那份表格是給你自己更新的）
```

#### 5. 多次零散會議 → 主題演變／知識文件

```text
情境 A（同一主題被反覆討論，想知道現在講到哪）：
「請照 cross-meeting-topic-tracker/SKILL.md 的定義，幫我整理 [主題] 在這幾場會議中的演變：
 [會議1摘要 + 日期] [會議2摘要 + 日期] [會議3摘要 + 日期]」

情境 B（想要一份長期可查的知識文件，不只是時間軸）：
「請照 meeting-notes-to-structured-doc/SKILL.md 的定義，
 把這幾次會議記錄整合成一份 [主題] 的知識文件草稿：……」
```

#### 6. Incident 結束 → Postmortem → 改善行動追蹤

```text
1) 「請照 postmortem-facilitator/SKILL.md 的定義，幫我主持這次 incident 的檢討：……」
   → 得到時間軸、促成因素、改善行動（附負責人/截止日期）

2) 把改善行動清單餵給 action-register-maintainer，比對 docs/ar/<檔名>.md
   → 建議新增，跨週期追蹤到真正完成，不會開完會就忘記
```

#### 7. Fireflies.ai（或任何會議轉錄工具）→ 多個 skill

Fireflies.ai 這類工具通常一次會產出好幾種不同的輸出（逐字稿/AI 摘要、Action Items、Analytics 參與度數據、跨會議關鍵字搜尋結果），對應到不同的 skill，不是只有一種用法：

```text
情境 A（逐字稿/AI 摘要 → 拆待辦 → 持續追蹤）：
1) 把 Fireflies 產出的逐字稿或 AI 摘要貼給：
   「請照 notes-to-action-digest/SKILL.md 的定義，幫我拆解這份會議摘要：……」
   → 得到決策事項/待辦/待釐清問題

2) 「請照 action-register-maintainer/SKILL.md 的定義，讀取以下目前的 Action Register，
   跟步驟 1 的待辦事項比對，建議新增/更新哪些列：
   [docs/ar/<檔名>.md 目前內容] + [步驟 1 的待辦清單]」

情境 B（Analytics 參與度數據 → 自我檢視）：
「請照 meeting-participation-balance-review/SKILL.md 的定義，
 幫我檢視這場 1-1 的參與度。talk-to-listen ratio：……，最長獨白時間：……」

情境 C（跨會議關鍵字搜尋結果 → 主題演變時間軸）：
「請照 cross-meeting-topic-tracker/SKILL.md 的定義，
 幫我整理 [主題] 在這幾場會議中的討論演變：
 [搜尋結果片段1 + 日期] [搜尋結果片段2 + 日期] [搜尋結果片段3 + 日期]」
```

情境 A 和情境 C 可以再串起來：如果同一個主題橫跨多場會議、且每場都拆出了新的 action item，先跑情境 C 搞清楚「現在講到哪」，再針對最新一場用情境 A 更新 Action Register，避免針對已經過時的舊結論重複開待辦。

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
| `role-clarity-decision-rights` | `docs/raci/<檔名>.md` | 這個 skill 只產出待確認的 DRI/Approver/Consulted/Informed **提案**，人確認後才手動填進 `docs/raci/<檔名>.md` 當長期維護版本 |
| `architecture-decision-record` | `docs/adr/<流水號>-<簡述>.md` | 這個 skill 產出的 ADR 內容直接存進一個新的 ADR 檔案（一個決策一個檔案，範本見 `docs/adr.template.md`）；沒有另外的「維護建議」skill，因為 ADR 本來就是一次性產出，之後偶爾手動更新狀態即可 |

### 輸出的 action item 可以匯入 Action Register 持續追蹤

以下 skill 的 Output Contract 都有一條「延伸追蹤（選填）」，指向 `action-register-maintainer` + `docs/ar/<檔名>.md`：

`notes-to-action-digest`、`daily-priority-briefing`、`weekly-wrapup-focus`、`one-on-one-prep-briefing`、`team-standup-digest`、`retro-synthesis`、`postmortem-facilitator`、`delivery-health-review`、`project-recovery-plan`、`customer-escalation-management`、`managed-service-operations-review`、`cloud-cost-reliability-review`、`commitment-risk-review`、`cross-team-dependency-log`、`meeting-notes-to-structured-doc`

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

### 輸出牽涉到責任歸屬時，指向 role-clarity-decision-rights

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

### 明確互斥/分工的 skill（避免搞混用哪個）

| 情境 | 用這個 | 不要用這個 |
|---|---|---|
| 想要一份可長期參考的知識文件本體 | `meeting-notes-to-structured-doc` | `notes-to-action-digest`（這個是拆待辦，不是寫文件） |
| 想要拆解決策/待辦/待釐清清單 | `notes-to-action-digest` | `meeting-notes-to-structured-doc`（待辦事項不寫進文件本體，只會簡短提示並建議改用前者） |
| 1-1 準備時遇到敏感績效/回饋內容 | `feedback-growth-plan` | `one-on-one-prep-briefing`（這個 skill 明確排除產出新的績效判斷，遇到敏感情境會提示改用前者） |
| 從零開始釐清角色重疊 | `role-clarity-decision-rights`（產出待確認提案） | 直接手改 `docs/raci/<檔名>.md`（那是給已經定案的版本維護用的） |

### 刻意不接進 Action Register 的 skill

`feedback-growth-plan` 的輸出屬於敏感人事內容（觀察到的行為、成長領域、對話草案），刻意沒有加上「延伸追蹤」指向共用的 `docs/ar/<檔名>.md`，避免跟其他事務性 action item 混在同一份可能被更多人看到的追蹤表裡。
