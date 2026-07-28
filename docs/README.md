# Action Register、RACI、ADR、Meeting Notes、1:1、Async/Team Update — 範本與活文件

六組你直接管控、手動編輯（或手動填寫）的活文件，加上輔助更新的 skill。

## 結構：範本 vs 實際內容

```text
docs/
├── ar.template.md                     # Action Register 範本（公開，追蹤進 git）
├── raci.template.md                   # RACI Matrix 範本（公開，追蹤進 git）
├── adr.template.md                    # ADR 範本，一個決策一個檔案（公開，追蹤進 git）
├── mn.template.md                     # 單次會議原始紀錄範本（公開，追蹤進 git）
├── one_on_one_meeting_template.html   # 1:1 議程/筆記工具，單機瀏覽器打開即可（公開，追蹤進 git）
├── ai_one_on_one_prep_prompt.html     # 產生 AI 1:1 prep prompt 的工具（公開，追蹤進 git）
├── async_update_template.html         # 個人 async standup/狀態更新撰寫工具（公開，追蹤進 git）
├── team_update_email_prompt.html      # 產生團隊向利害關係人週報 email 的 AI prompt 工具（公開，追蹤進 git）
├── ar/                                 # 實際的 Action Register 內容（.gitignore 排除，只留 .gitkeep）
├── raci/                               # 實際的 RACI Matrix 內容（.gitignore 排除，只留 .gitkeep）
├── adr/                                 # 實際的 ADR 內容，一個決策一個檔案（.gitignore 排除，只留 .gitkeep）
├── mn/                                  # 實際的會議原始紀錄，一次會議一個檔案（.gitignore 排除，只留 .gitkeep）
├── 1on1/                                # 實際的 1:1 紀錄，兩個工具下載出來的填寫檔案存這裡（.gitignore 排除，只留 .gitkeep）
└── updates/                             # 實際的 async/team update 紀錄，兩個工具下載出來的填寫檔案存這裡（.gitignore 排除，只留 .gitkeep）
```

這個 repo 是公開共用的 skill 庫，`docs/*.template.md` 和 `docs/*.html` 只放結構、範例與工具本身，不會有真實的專案/人名/決策內容。你實際使用時：

- AR/RACI/ADR/MN：**複製範本到對應資料夾底下、自己命名**，例如：

```bash
cp docs/ar.template.md docs/ar/my-team.md
cp docs/raci.template.md docs/raci/my-team.md
cp docs/adr.template.md docs/adr/0001-message-queue-choice.md
cp docs/mn.template.md docs/mn/2026-07-15-weekly.md
```

- 1:1：直接用瀏覽器打開 `docs/one_on_one_meeting_template.html` 或 `docs/ai_one_on_one_prep_prompt.html` 填寫，填完用工具內建的「下載」按鈕，把產出的 HTML 檔存進 `docs/1on1/`（檔名自帶姓名/日期，例如 `1on1_<姓名>_<日期>.html`、`ai_1on1_prep_<姓名>.html`）。
- Async/Team Update：直接用瀏覽器打開 `docs/async_update_template.html`（個人每日/每週/每個 sprint 的狀態更新）或 `docs/team_update_email_prompt.html`（產生給利害關係人的週報 email prompt），填完下載存進 `docs/updates/`（檔名例如 `async_update_<姓名>_<日期>.html`、`team_update_email_<team>.html`）。

`docs/ar/`、`docs/raci/`、`docs/adr/`、`docs/mn/`、`docs/1on1/`、`docs/updates/` 底下的檔案（`.gitkeep` 除外）都被 `.gitignore` 排除，不會被提交進這個 repo，因為裡面通常會累積真實的內部資訊。`shared-skills/validate-skills.sh` 掃描每個子目錄時也會跳過整個 `docs/`，不會把它當成缺 SKILL.md 的 skill 來報錯。

`docs/mn/` 是選用的：如果你想讓 `docs/ar/`、`docs/raci/` 的「來源」欄位能真的連到一份可回溯的原始會議記錄，就用它存每次會議的逐字稿/筆記；如果只需要一句話描述來源（例如「2026-07-15 週會」），不用建立這份檔案也沒關係，細節見 `docs/mn.template.md`。

## 跟 skill 的關係

| 你想做的事 | 用什麼 |
|---|---|
| 從零開始釐清角色重疊、產出一份待確認的 RACI 提案 | `shared-skills/role-clarity-decision-rights/SKILL.md` |
| 已經有定案的 RACI，直接維護 | 手動編輯 `docs/raci/<你的檔名>.md`（範本：`docs/raci.template.md`） |
| 開完會，想知道 Action Register 該新增/更新哪些列 | `shared-skills/action-register-maintainer/SKILL.md` |
| 直接調整 Action Register 內容 | 手動編輯 `docs/ar/<你的檔名>.md`（範本：`docs/ar.template.md`） |
| 記錄一個架構/技術決策 | `shared-skills/architecture-decision-record/SKILL.md`，產出內容存進 `docs/adr/<流水號>-<簡述>.md`（範本：`docs/adr.template.md`） |
| 保留一份會議的原始逐字稿/筆記，讓 AR/RACI 的「來源」欄位可以回溯 | 手動存進 `docs/mn/<日期>-<會議簡稱>.md`（範本：`docs/mn.template.md`），選用，不存也不影響 AR/RACI 運作 |
| 1-1 會前用 AI 產生談話重點 | `shared-skills/one-on-one-prep-briefing/SKILL.md`（AI CLI 版本），或不方便用 CLI 時改用 `docs/ai_one_on_one_prep_prompt.html`（離線瀏覽器版本，產生的 prompt 自己貼給 AI 助理） |
| 記錄一次 1-1 的議程/筆記 | 用瀏覽器打開 `docs/one_on_one_meeting_template.html` 填寫，下載後存進 `docs/1on1/<檔名>.html` |
| 寫自己的一份 async standup/狀態更新 | 用瀏覽器打開 `docs/async_update_template.html` 填寫，內建「Copy for Slack/Email」快速複製；填完的多份更新可以餵給 `shared-skills/team-standup-digest/SKILL.md` 彙整成「誰卡住/需要介入」摘要 |
| 把零散進度/風險/指標整理成一封給利害關係人的週報 email | 用瀏覽器打開 `docs/team_update_email_prompt.html`，選對象與語氣後產生 AI prompt，自己貼給 AI 助理草擬 email；跟 `shared-skills/weekly-wrapup-focus/SKILL.md` 的輸出可以互補（後者先產出本週完成事項＋下週 focus，再用這個工具轉成給利害關係人的 email） |

`action-register-maintainer` 只會**提出建議的異動**（新增哪些列、哪些該標記逾期、哪些該移到已完成），不會自己動手改你的 `docs/ar/<檔名>.md`——實際要不要採用建議、要不要真的修改檔案，由你決定並自己動手改。`architecture-decision-record` 沒有對應的「維護建議」skill，因為 ADR 本來就是一次性產出、之後偶爾手動更新狀態，不需要跨會議持續比對。`one_on_one_meeting_template.html`、`ai_one_on_one_prep_prompt.html`、`async_update_template.html`、`team_update_email_prompt.html` 也都沒有對應的「維護建議」skill——這些都是一次一份、獨立存檔的紀錄，不需要跨會議/跨週期比對。

## 哪些 skill 會指過來這裡

輸出裡包含待辦/action item 的 skill，在各自的 Output Contract 最後都加了一條「延伸追蹤（選填）」，指向 `action-register-maintainer` 與你的 `docs/ar/` 底下的檔案：

`notes-to-action-digest`、`daily-priority-briefing`、`weekly-wrapup-focus`、`one-on-one-prep-briefing`、`team-standup-digest`、`retro-synthesis`、`postmortem-facilitator`、`delivery-health-review`、`project-recovery-plan`、`customer-escalation-management`、`managed-service-operations-review`、`cloud-cost-reliability-review`、`commitment-risk-review`、`cross-team-dependency-log`、`meeting-notes-to-structured-doc`

輸出裡出現「負責人反覆不清楚」這類責任歸屬問題的 skill，同樣加了一條指向 `role-clarity-decision-rights` 與你的 `docs/raci/` 底下的檔案：

`delivery-health-review`、`customer-escalation-management`、`commitment-risk-review`、`architecture-decision-record`、`cross-team-dependency-log`

`feedback-growth-plan` 刻意沒有接進來——它的輸出屬於敏感人事內容，不適合跟其他事務性 action item 混在同一份共用追蹤表裡。

`one-on-one-prep-briefing` 的 Output Contract 加了一條「替代方案」，指向 `docs/one_on_one_meeting_template.html`、`docs/ai_one_on_one_prep_prompt.html` 這兩個離線瀏覽器工具。

`team-standup-digest` 的 Required Input 加了一條說明，指向 `docs/async_update_template.html`——如果團隊成員手上還沒有固定的更新撰寫習慣，可以先用這個工具寫，產出的內容再彙整餵給這個 skill。

`weekly-wrapup-focus` 的 Output Contract 加了一條「延伸應用」，指向 `docs/team_update_email_prompt.html`——把這個 skill 產出的本週完成事項/下週 focus，轉成給利害關係人的 email。

## 想幫多個團隊/專案分開追蹤？

`docs/ar/`、`docs/raci/`、`docs/adr/`、`docs/1on1/`、`docs/updates/` 都是資料夾，不是單一檔案，可以依團隊/專案（或依人）各自複製一份範本、取不同檔名（例如 `docs/ar/platform-team.md`、`docs/1on1/1on1_alice_2026-07-15.html`），彼此獨立維護，不用共用同一份表格。

## 隱私提醒

`docs/1on1/`、`docs/updates/` 底下的檔案會包含真實姓名、筆記或專案內部資訊，屬於機密/內部資料，跟 `docs/ar/`、`docs/raci/`、`docs/adr/`、`docs/mn/` 一樣被 `.gitignore` 排除，不會被提交進這個公開 repo。`ai_one_on_one_prep_prompt.html`、`team_update_email_prompt.html` 產生的 prompt 在貼給第三方 AI 工具前，也要先檢查是否包含不該外流的機密資訊。
