# Action Register、RACI、ADR、Meeting Notes、1:1、Async/Team Update、Stakeholder Report、Coaching/Skill Gap、Career Development — 範本與活文件

八組你直接管控、手動編輯（或手動填寫）的活文件，加上輔助更新的 skill。

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
├── stakeholder_update_template.html   # 完整專案狀態報告工具（進度/風險/資源/待決事項），單機瀏覽器打開即可（公開，追蹤進 git）
├── ai_meeting_summary_template.html   # 會議原始筆記 + 4 組 AI prompt（摘要/決議/action item/洞察）工具（公開，追蹤進 git）
├── ai_coaching_prompt_template.html   # 產生下屬成長/教練建議的 AI prompt 工具（公開，追蹤進 git）
├── coaching_plan_tracker.html         # 單一下屬的長期教練計畫追蹤工具（目標/技能矩陣/session log），單機瀏覽器打開即可（公開，追蹤進 git）
├── skill_gap_analysis_template.html   # 團隊技能矩陣 → 產生技能缺口分析 AI prompt 的工具（公開，追蹤進 git）
├── career_development_plan_template.html  # 單一下屬的長期職涯發展計畫工具（願景/目標/技能矩陣/里程碑），單機瀏覽器打開即可（公開，追蹤進 git）
├── ai_career_path_prompt_template.html    # 產生職涯路徑/晉升準備建議的 AI prompt 工具（公開，追蹤進 git）
├── ar/                                 # 實際的 Action Register 內容（.gitignore 排除，只留 .gitkeep）
├── raci/                               # 實際的 RACI Matrix 內容（.gitignore 排除，只留 .gitkeep）
├── adr/                                 # 實際的 ADR 內容，一個決策一個檔案（.gitignore 排除，只留 .gitkeep）
├── mn/                                  # 實際的會議原始紀錄，一次會議一個檔案（.gitignore 排除，只留 .gitkeep；也存放 ai_meeting_summary_template.html 的填寫結果）
├── 1on1/                                # 實際的 1:1 紀錄，兩個工具下載出來的填寫檔案存這裡（.gitignore 排除，只留 .gitkeep）
├── updates/                             # 實際的 async/team update/stakeholder report 紀錄，三個工具下載出來的填寫檔案存這裡（.gitignore 排除，只留 .gitkeep）
└── coaching/                            # 實際的教練/職涯發展計畫內容，career_development_plan_template.html 下載出來的填寫檔案存這裡（.gitignore 排除，只留 .gitkeep）
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
- Async/Team Update/Stakeholder Report：直接用瀏覽器打開 `docs/async_update_template.html`（個人每日/每週/每個 sprint 的狀態更新）、`docs/team_update_email_prompt.html`（產生給利害關係人的週報 email prompt）、或 `docs/stakeholder_update_template.html`（完整專案狀態報告，含進度表/風險/資源/待決事項），填完下載存進 `docs/updates/`（檔名例如 `async_update_<姓名>_<日期>.html`、`team_update_email_<team>.html`、`stakeholder_update_<專案>_<日期>.html`）。
- 會議摘要：`docs/ai_meeting_summary_template.html` 會議中先記原始筆記，會後用工具內建的 4 組 AI prompt（摘要/決議/action item/洞察）分別複製貼給 AI 助理，貼回輸出後下載存進 `docs/mn/`（跟 `mn.template.md` 手動版本共用同一個資料夾）。
- 週期性向上報告草稿：手上有一份填好的 `stakeholder_update_template.html` 加上這個週期累積的多份 `ai_meeting_summary_template.html`，想收斂成一份精簡、固定骨架的向上報告草稿，用 `shared-skills/weekly-upward-report-draft/SKILL.md`。
- Coaching/Skill Gap：`docs/ai_coaching_prompt_template.html`（產生下屬成長建議的 AI prompt）、`docs/coaching_plan_tracker.html`（長期教練計畫追蹤）、`docs/skill_gap_analysis_template.html`（團隊技能矩陣 → 缺口分析 prompt）都只提供瀏覽器內填寫/列印/複製，沒有下載填寫結果的功能——填完直接列印存 PDF、或複製產生的 prompt，不會留下自動命名的匯出檔案。
- Career Development：`docs/career_development_plan_template.html`（單一下屬的長期職涯發展計畫）填完可以用工具內建的「下載」按鈕存成 `.txt`，存進 `docs/coaching/`；`docs/ai_career_path_prompt_template.html`（產生職涯路徑/晉升準備建議的 AI prompt）跟其他 AI prompt 工具一樣沒有下載功能，只能複製。

`docs/ar/`、`docs/raci/`、`docs/adr/`、`docs/mn/`、`docs/1on1/`、`docs/updates/`、`docs/coaching/` 底下的檔案（`.gitkeep` 除外）都被 `.gitignore` 排除，不會被提交進這個 repo，因為裡面通常會累積真實的內部資訊。`shared-skills/validate-skills.sh` 掃描每個子目錄時也會跳過整個 `docs/`，不會把它當成缺 SKILL.md 的 skill 來報錯。

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
| 產出一份完整的專案狀態報告（進度表、風險、資源/預算、待決事項） | 用瀏覽器打開 `docs/stakeholder_update_template.html` 手動填寫；如果先跑過 `shared-skills/delivery-health-review/SKILL.md` 產出證據支持的狀態判斷，可以把結果填進這份報告的對應欄位 |
| 開會時先記原始筆記，會後用 AI 整理成摘要/決議/action item/洞察 | 用瀏覽器打開 `docs/ai_meeting_summary_template.html`，會中記原始筆記，會後用工具內建的 4 組 AI prompt 分別產生摘要/決議/action item/洞察，貼回工具後下載存進 `docs/mn/`；跟 `shared-skills/notes-to-action-digest/SKILL.md` 是同一件事的兩種介面（一個是離線瀏覽器 + 你自己貼給 AI，一個是直接請 AI CLI 處理） |
| 把這個週期填好的 `stakeholder_update_template.html`（現況）+ 多份 `ai_meeting_summary_template.html`（會議摘要）收斂成一份精簡的向上報告草稿 | `shared-skills/weekly-upward-report-draft/SKILL.md`——依固定上限篩選每個段落的項目數、去識別化組織觀察、跨來源重複項目只列一次 |
| 針對某位下屬產生開放式的成長/教練建議 AI prompt（不是針對特定事件的回饋） | `docs/ai_coaching_prompt_template.html`；如果是要針對具體觀察到的行為給回饋，改用 `shared-skills/feedback-growth-plan/SKILL.md` |
| 追蹤某位下屬的長期教練計畫（目標、技能矩陣、歷次 session 記錄） | 用瀏覽器打開 `docs/coaching_plan_tracker.html` 填寫，列印/存 PDF 留存 |
| 分析團隊技能缺口，產出招募/訓練優先順序建議 | 用瀏覽器打開 `docs/skill_gap_analysis_template.html`，填每位工程師的技能矩陣後產生 AI prompt；缺口分析結果如果要拿來規劃季度 headcount，可接 `shared-skills/capacity-roadmap-scenarios/SKILL.md`；如果要據此設計面試流程，可接 `shared-skills/hiring-interview-calibration/SKILL.md` |
| 追蹤某位下屬的長期職涯發展計畫（願景、目標、里程碑、技能矩陣、主管支持承諾） | 用瀏覽器打開 `docs/career_development_plan_template.html` 填寫，下載後存進 `docs/coaching/`；跟 `docs/coaching_plan_tracker.html` 用途重疊——這個偏重「長期職涯路徑規劃」，`coaching_plan_tracker.html` 偏重「逐次教練 session 記錄」，依需要擇一或搭配使用 |
| 針對某位下屬產生職涯路徑/晉升準備建議的 AI prompt | `docs/ai_career_path_prompt_template.html`；產出內容是給主管自己參考的建議，不是正式的晉升決定 |

`action-register-maintainer` 只會**提出建議的異動**（新增哪些列、哪些該標記逾期、哪些該移到已完成），不會自己動手改你的 `docs/ar/<檔名>.md`——實際要不要採用建議、要不要真的修改檔案，由你決定並自己動手改。`architecture-decision-record` 沒有對應的「維護建議」skill，因為 ADR 本來就是一次性產出、之後偶爾手動更新狀態，不需要跨會議持續比對。所有 `docs/*.html` 工具也都沒有對應的「維護建議」skill——這些都是一次一份、獨立存檔的紀錄，不需要跨會議/跨週期比對。

## 哪些 skill 會指過來這裡

輸出裡包含待辦/action item 的 skill，在各自的 Output Contract 最後都加了一條「延伸追蹤（選填）」，指向 `action-register-maintainer` 與你的 `docs/ar/` 底下的檔案：

`notes-to-action-digest`、`daily-priority-briefing`、`weekly-wrapup-focus`、`one-on-one-prep-briefing`、`team-standup-digest`、`retro-synthesis`、`postmortem-facilitator`、`delivery-health-review`、`project-recovery-plan`、`customer-escalation-management`、`managed-service-operations-review`、`cloud-cost-reliability-review`、`commitment-risk-review`、`cross-team-dependency-log`、`meeting-notes-to-structured-doc`

輸出裡出現「負責人反覆不清楚」這類責任歸屬問題的 skill，同樣加了一條指向 `role-clarity-decision-rights` 與你的 `docs/raci/` 底下的檔案：

`delivery-health-review`、`customer-escalation-management`、`commitment-risk-review`、`architecture-decision-record`、`cross-team-dependency-log`

`feedback-growth-plan` 刻意沒有接進來——它的輸出屬於敏感人事內容，不適合跟其他事務性 action item 混在同一份共用追蹤表裡。

`one-on-one-prep-briefing` 的 Output Contract 加了一條「替代方案」，指向 `docs/one_on_one_meeting_template.html`、`docs/ai_one_on_one_prep_prompt.html` 這兩個離線瀏覽器工具。

`team-standup-digest` 的 Required Input 加了一條說明，指向 `docs/async_update_template.html`——如果團隊成員手上還沒有固定的更新撰寫習慣，可以先用這個工具寫，產出的內容再彙整餵給這個 skill。

`weekly-wrapup-focus` 的 Output Contract 加了一條「延伸應用」，指向 `docs/team_update_email_prompt.html`——把這個 skill 產出的本週完成事項/下週 focus，轉成給利害關係人的 email。

`delivery-health-review` 的 Output Contract 加了一條「延伸應用」，指向 `docs/stakeholder_update_template.html`——把這個 skill 產出的證據支持狀態判斷，填進一份完整的利害關係人狀態報告。

`notes-to-action-digest` 的 Output Contract 加了一條「替代方案」，指向 `docs/ai_meeting_summary_template.html`——不方便用 AI CLI 時，可以先用這個離線瀏覽器工具記筆記、產生 AI prompt，自己貼給 AI 助理。

`weekly-upward-report-draft/SKILL.md` 是把 `docs/stakeholder_update_template.html`（現況）和 `docs/ai_meeting_summary_template.html`（會議摘要）這兩個工具的填寫結果收斂成精簡草稿的下游步驟——先分別填好這兩個工具，再把內容貼給這個 skill。

`feedback-growth-plan` 跟 `docs/ai_coaching_prompt_template.html` 是兩種不同性質的工具，不是同一件事的兩種介面：`feedback-growth-plan` 一定要有具體觀察到的事件才能產出，且明確禁止模糊特質標籤；`ai_coaching_prompt_template.html` 是開放式的成長/教練規劃，不需要綁定單一事件。兩者可以搭配使用，但不要互相取代。

## 想幫多個團隊/專案分開追蹤？

`docs/ar/`、`docs/raci/`、`docs/adr/`、`docs/1on1/`、`docs/updates/`、`docs/coaching/` 都是資料夾，不是單一檔案，可以依團隊/專案（或依人）各自複製一份範本、取不同檔名（例如 `docs/ar/platform-team.md`、`docs/1on1/1on1_alice_2026-07-15.html`），彼此獨立維護，不用共用同一份表格。

## 隱私提醒

`docs/1on1/`、`docs/updates/`、`docs/mn/`、`docs/coaching/` 底下的檔案會包含真實姓名、筆記或專案內部資訊，屬於機密/內部資料，跟 `docs/ar/`、`docs/raci/`、`docs/adr/` 一樣被 `.gitignore` 排除，不會被提交進這個公開 repo。`ai_one_on_one_prep_prompt.html`、`team_update_email_prompt.html`、`ai_meeting_summary_template.html`、`ai_coaching_prompt_template.html`、`skill_gap_analysis_template.html`、`ai_career_path_prompt_template.html` 產生的 prompt 在貼給第三方 AI 工具前，也要先檢查是否包含不該外流的機密資訊。

`coaching_plan_tracker.html`、`skill_gap_analysis_template.html` 填寫後通常會包含真實姓名、技能評分、教練筆記，屬於敏感人事內容——這兩個工具沒有「下載」按鈕，只能列印/存 PDF 或截圖，存檔時不要存進任何會被提交進版控的位置（不論是這個 repo 還是你自己使用的專案 repo）。`career_development_plan_template.html` 有下載按鈕，填寫後的 `.txt` 檔同樣屬於敏感人事內容，只能存進 `docs/coaching/`（已被 `.gitignore` 排除）。

`ai_career_path_prompt_template.html` 產生的 prompt 內建一段提醒：AI 給的「晉升準備評估」只是給主管自己參考的建議，不是正式的晉升決定——正式的晉升判斷仍然要走公司自己的 calibration 流程，不能把 AI 輸出直接當成依據。
