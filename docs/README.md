# Action Register、RACI、ADR、Meeting Notes、1:1、Async/Team Update、Stakeholder Report、Coaching/Skill Gap、Career Development、Decision/Risk Analysis — 範本與活文件

多組你直接管控、手動編輯（或手動填寫）的活文件，加上輔助更新的 skill。

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
├── email_draft_generator.html         # 產生各類 EM email（狀態更新/事故通報/團隊公告/主管摘要/績效對話/流程異動）AI prompt 的工具，附靜態範本（公開，追蹤進 git）
├── meeting_agenda_generator.html      # 9 種會議類型的議程 AI prompt 產生器，附靜態範本，支援英文/繁體中文切換（介面與產出內容都會切換），單機瀏覽器打開即可（公開，追蹤進 git）
├── risk_analysis_prompt_generator.html       # 產生風險辨識/評分/緩解建議的 AI prompt 工具，支援英文/繁體中文介面與 prompt 產出（公開，追蹤進 git）
├── scenario_comparison_prompt_generator.html # 產生多方案比較/決策建議的 AI prompt 工具，支援英文/繁體中文介面與 prompt 產出（公開，追蹤進 git）
├── risk_analysis_template.html        # 專案風險矩陣 + 風險登錄表活文件，支援英文/繁體中文介面與結構化內容複製（公開，追蹤進 git）
├── scenario_comparison_template.html  # 2-3 個方案的優缺點/風險/投入比較活文件，支援英文/繁體中文介面與結構化內容複製（公開，追蹤進 git）
├── decision_matrix_template.html      # 加權決策矩陣工具，支援英文/繁體中文介面與結構化內容複製（公開，追蹤進 git）
├── documentation_summary_prompt_generator.html # 產生擷取內隱知識（tribal knowledge）的 AI prompt 工具，支援英文/繁體中文介面與 prompt 產出（公開，追蹤進 git）
├── documentation_summary_template.html         # 內隱知識盤點/缺口分析/文件行動計畫活文件，支援英文/繁體中文介面（公開，追蹤進 git）
├── strategic_alignment_template.html  # 把工程專案對應到業務目標的季度策略對齊活文件，支援英文/繁體中文介面（公開，追蹤進 git）
├── crisis_response_template.html      # 事件/危機應變準備與情境規劃活文件（緊急聯絡人、應變檢核清單、溝通計畫），支援英文/繁體中文介面（公開，追蹤進 git）
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
- Email/會議議程：`docs/email_draft_generator.html`（各類 EM email 的 AI prompt + 靜態範本）、`docs/meeting_agenda_generator.html`（9 種會議類型的議程 AI prompt + 靜態範本）都只提供瀏覽器內填寫/複製/列印，沒有下載功能。
- Decision/Risk Analysis：`docs/risk_analysis_prompt_generator.html` 用來把專案背景、風險類別、分析深度組成一段可貼給 AI 的風險分析 prompt；`docs/scenario_comparison_prompt_generator.html` 用來把決策背景、候選方案、評估準則組成多方案比較 prompt；`docs/risk_analysis_template.html` 是手動維護風險矩陣與風險登錄表；`docs/scenario_comparison_template.html` 是比較 2-3 個方案的優缺點、風險與投入；`docs/decision_matrix_template.html` 是可加權計分的決策矩陣。這五個工具右上角都能切換英文/繁體中文，且複製出來的 AI prompt 或結構化 template 內容會依選定語言產生。

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
| 產生各類 EM email（狀態更新、事故通報、團隊公告、主管摘要、績效對話、流程異動）的 AI prompt，或直接套用靜態範本 | `docs/email_draft_generator.html`；如果只是要固定的每週給利害關係人的狀態 email，`docs/team_update_email_prompt.html` 更聚焦、欄位也更貼合週報情境 |
| 草擬會議議程 AI prompt（9 種常見會議類型：standup/sprint planning/retro/1:1/架構審查/事故檢討/專案 kickoff/all-hands/週報向上報告），附靜態範本，右上角可切換英文/繁體中文（介面與產出的 prompt/範本都會切換） | 用瀏覽器打開 `docs/meeting_agenda_generator.html`；不方便用瀏覽器工具時改用 `shared-skills/meeting-agenda-draft/SKILL.md`（AI CLI 版本，附必要性提醒/會議類型判定/48 小時前置期檢查） |
| 針對專案、上線、遷移或營運變更做風險辨識、風險評分與緩解計畫 | 想請 AI 先幫忙發散與整理時，用 `docs/risk_analysis_prompt_generator.html` 產生 prompt；已經要正式追蹤風險時，用 `docs/risk_analysis_template.html` 維護風險矩陣與風險登錄表 |
| 比較多個工程/產品/流程/投資方案，形成決策建議 | 想請 AI 先做結構化比較時，用 `docs/scenario_comparison_prompt_generator.html`；想手動整理 2-3 個方案的優缺點、風險、投入與建議時，用 `docs/scenario_comparison_template.html` |
| 用加權分數讓決策取捨更明確 | 用瀏覽器打開 `docs/decision_matrix_template.html`，設定準則權重、替每個方案評 1-5 分，再搭配質化分析決定最後建議；適合供應商選型、架構選型、roadmap 取捨、工具導入等需要留下決策理由的情境 |
| 把某個人腦中的內隱知識（部署程序、故障排除訣竅、架構決策脈絡）系統化地擷取成 AI 訪談 prompt | 用瀏覽器打開 `docs/documentation_summary_prompt_generator.html`，選知識類型、勾選重點領域與擷取方法後產生 prompt，右上角可切換英文/繁體中文，產出的 prompt 內容也會跟著切換 |
| 盤點團隊有哪些知識只有單一個人知道（bus factor 風險）、排出文件優先順序與負責人 | 用瀏覽器打開 `docs/documentation_summary_template.html` 填寫知識項目、缺口分析與行動計畫，右上角可切換英文/繁體中文 |
| 把工程專案對應到公司/業務目標，追蹤策略對齊度、KPI、利害關係人溝通與策略風險 | 用瀏覽器打開 `docs/strategic_alignment_template.html` 填寫，通常每季檢視一次，右上角可切換英文/繁體中文 |
| 為系統中斷/資安事件/團隊危機等情況預先準備應變計畫（緊急聯絡人、30 分鐘內應變清單、溝通範本、情境分析），或在危機發生當下即時記錄 | 用瀏覽器打開 `docs/crisis_response_template.html`，右上角可切換英文/繁體中文；建議危機發生前就先印出或存成 PDF 備用 |

### Decision/Risk Analysis 工作台

`risk_analysis_prompt_generator.html`、`risk_analysis_template.html`、`scenario_comparison_prompt_generator.html`、`scenario_comparison_template.html`、`decision_matrix_template.html` 這五個工具可以視為「瀏覽器版的決策/風險工作台」：不是取代既有 skill，而是放在幾個 skill 的前後，補上風險發散、方案比較、決策取捨與後續追蹤。

| 工具 | 可以用來幹嘛 | 常見串接 |
|---|---|---|
| `docs/risk_analysis_prompt_generator.html` | 把專案背景整理成 AI prompt，請 AI 幫你發散風險：哪裡可能出事、機率/影響怎麼評、要怎麼預防、誰要看、什麼時候升級 | `delivery-health-review` 判斷專案偏黃/紅後，用這個工具做更完整風險分析；`commitment-risk-review` 判斷承諾風險後，用這個工具補齊風險清單 |
| `docs/risk_analysis_template.html` | 正式追蹤風險，把 AI 分析或會議結論整理進風險矩陣/風險登錄表，持續更新 owner、狀態、緩解方案 | 從 `risk_analysis_prompt_generator.html` 或 `commitment-risk-review` 接結果；需要跨週期追蹤 mitigation、next steps 時，再接 `action-register-maintainer` |
| `docs/scenario_comparison_prompt_generator.html` | 請 AI 比較多個方案，例如架構選型、vendor vs 自建、roadmap 取捨、流程調整；適合「還沒形成結論」時使用 | 寫 `architecture-decision-record` 前先比較選項；`capacity-roadmap-scenarios` 產出多個情境後，用這個工具要求 AI 補強比較角度 |
| `docs/scenario_comparison_template.html` | 手動整理 2-3 個方案的優缺點、風險、投入、建議，適合拿去跟主管/PM/tech lead 討論 | 接在 `capacity-roadmap-scenarios` 後，把「維持現狀／人力受限／加速衝刺」整理成決策材料；如果卡在跨團隊依賴，補接 `cross-team-dependency-log` |
| `docs/decision_matrix_template.html` | 用加權分數比較已知候選方案，讓取捨變明確，例如成本 3 分、速度 4 分、風險降低 5 分，再看加權結果 | 在 `architecture-decision-record` 前留下決策理由；也可接在 `scenario_comparison_template.html` 後，把質化比較轉成加權分數 |

典型流程：

```text
delivery-health-review
  -> risk_analysis_prompt_generator.html
  -> risk_analysis_template.html
  -> action-register-maintainer

commitment-risk-review
  -> risk_analysis_template.html
  -> action-register-maintainer 或 role-clarity-decision-rights

capacity-roadmap-scenarios
  -> scenario_comparison_template.html
  -> decision_matrix_template.html

scenario_comparison_prompt_generator.html
  -> decision_matrix_template.html
  -> architecture-decision-record
```

如果比較方案時發現「誰能決定」「誰該 approve」不清楚，先用 `shared-skills/role-clarity-decision-rights/SKILL.md` 釐清決策權責，再回來更新 `scenario_comparison_template.html` 或 `decision_matrix_template.html`。如果方案或風險卡在跨團隊依賴，先用 `shared-skills/cross-team-dependency-log/SKILL.md` 把依賴拆清楚，再把需要追蹤的項目交給 `action-register-maintainer`。

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

`meeting-agenda-draft` 的 Output Contract 加了一條「替代方案」，指向 `docs/meeting_agenda_generator.html`——不方便用 AI CLI 時，可以先用這個離線瀏覽器工具（附 9 種會議類型的靜態範本），但要注意離線工具沒有 `meeting-agenda-draft` 的必要性提醒/會議類型判定/48 小時前置期檢查這幾層把關，自己額外留意。

## 想幫多個團隊/專案分開追蹤？

`docs/ar/`、`docs/raci/`、`docs/adr/`、`docs/1on1/`、`docs/updates/`、`docs/coaching/` 都是資料夾，不是單一檔案，可以依團隊/專案（或依人）各自複製一份範本、取不同檔名（例如 `docs/ar/platform-team.md`、`docs/1on1/1on1_alice_2026-07-15.html`），彼此獨立維護，不用共用同一份表格。

## 隱私提醒

`docs/1on1/`、`docs/updates/`、`docs/mn/`、`docs/coaching/` 底下的檔案會包含真實姓名、筆記或專案內部資訊，屬於機密/內部資料，跟 `docs/ar/`、`docs/raci/`、`docs/adr/` 一樣被 `.gitignore` 排除，不會被提交進這個公開 repo。`ai_one_on_one_prep_prompt.html`、`team_update_email_prompt.html`、`ai_meeting_summary_template.html`、`ai_coaching_prompt_template.html`、`skill_gap_analysis_template.html`、`ai_career_path_prompt_template.html`、`email_draft_generator.html`、`meeting_agenda_generator.html`、`risk_analysis_prompt_generator.html`、`scenario_comparison_prompt_generator.html`、`documentation_summary_prompt_generator.html` 產生的 prompt 在貼給第三方 AI 工具前，也要先檢查是否包含不該外流的機密資訊。`documentation_summary_template.html` 填寫後可能包含內部系統架構、部署細節、troubleshooting 內部資訊，這兩個文件工具都沒有下載功能，複製或列印保存時不要放進會被公開提交的位置。`risk_analysis_template.html`、`scenario_comparison_template.html`、`decision_matrix_template.html` 填寫後也可能包含內部 roadmap、供應商、成本或架構資訊，複製或列印保存時不要放進會被公開提交的位置。

`coaching_plan_tracker.html`、`skill_gap_analysis_template.html` 填寫後通常會包含真實姓名、技能評分、教練筆記，屬於敏感人事內容——這兩個工具沒有「下載」按鈕，只能列印/存 PDF 或截圖，存檔時不要存進任何會被提交進版控的位置（不論是這個 repo 還是你自己使用的專案 repo）。`strategic_alignment_template.html`、`crisis_response_template.html` 填寫後同樣可能包含利害關係人姓名、緊急聯絡方式、內部系統狀態或業務指標，也沒有下載按鈕，只能列印/存 PDF，存檔時比照辦理。`career_development_plan_template.html` 有下載按鈕，填寫後的 `.txt` 檔同樣屬於敏感人事內容，只能存進 `docs/coaching/`（已被 `.gitignore` 排除）。

`ai_career_path_prompt_template.html` 產生的 prompt 內建一段提醒：AI 給的「晉升準備評估」只是給主管自己參考的建議，不是正式的晉升決定——正式的晉升判斷仍然要走公司自己的 calibration 流程，不能把 AI 輸出直接當成依據。
