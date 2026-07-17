# Action Register、RACI、ADR — 範本與活文件

三組你直接管控、手動編輯的活文件，加上輔助更新的 skill。

## 結構：範本 vs 實際內容

```text
docs/
├── ar.template.md      # Action Register 範本（公開，追蹤進 git）
├── raci.template.md     # RACI Matrix 範本（公開，追蹤進 git）
├── adr.template.md      # ADR 範本，一個決策一個檔案（公開，追蹤進 git）
├── ar/                   # 實際的 Action Register 內容（.gitignore 排除，只留 .gitkeep）
├── raci/                 # 實際的 RACI Matrix 內容（.gitignore 排除，只留 .gitkeep）
└── adr/                  # 實際的 ADR 內容，一個決策一個檔案（.gitignore 排除，只留 .gitkeep）
```

這個 repo 是公開共用的 skill 庫，`docs/*.template.md` 只放結構與範例，不會有真實的專案/人名/決策內容。你實際使用時，**複製範本到對應資料夾底下、自己命名**，例如：

```bash
cp docs/ar.template.md docs/ar/my-team.md
cp docs/raci.template.md docs/raci/my-team.md
cp docs/adr.template.md docs/adr/0001-message-queue-choice.md
```

`docs/ar/`、`docs/raci/`、`docs/adr/` 底下的檔案（`.gitkeep` 除外）都被 `.gitignore` 排除，不會被提交進這個 repo，因為裡面通常會累積真實的內部資訊。`shared-skills/validate-skills.sh` 掃描每個子目錄時也會跳過整個 `docs/`，不會把它當成缺 SKILL.md 的 skill 來報錯。

## 跟 skill 的關係

| 你想做的事 | 用什麼 |
|---|---|
| 從零開始釐清角色重疊、產出一份待確認的 RACI 提案 | `shared-skills/role-clarity-decision-rights/SKILL.md` |
| 已經有定案的 RACI，直接維護 | 手動編輯 `docs/raci/<你的檔名>.md`（範本：`docs/raci.template.md`） |
| 開完會，想知道 Action Register 該新增/更新哪些列 | `shared-skills/action-register-maintainer/SKILL.md` |
| 直接調整 Action Register 內容 | 手動編輯 `docs/ar/<你的檔名>.md`（範本：`docs/ar.template.md`） |
| 記錄一個架構/技術決策 | `shared-skills/architecture-decision-record/SKILL.md`，產出內容存進 `docs/adr/<流水號>-<簡述>.md`（範本：`docs/adr.template.md`） |

`action-register-maintainer` 只會**提出建議的異動**（新增哪些列、哪些該標記逾期、哪些該移到已完成），不會自己動手改你的 `docs/ar/<檔名>.md`——實際要不要採用建議、要不要真的修改檔案，由你決定並自己動手改。`architecture-decision-record` 沒有對應的「維護建議」skill，因為 ADR 本來就是一次性產出、之後偶爾手動更新狀態，不需要跨會議持續比對。

## 哪些 skill 會指過來這裡

輸出裡包含待辦/action item 的 skill，在各自的 Output Contract 最後都加了一條「延伸追蹤（選填）」，指向 `action-register-maintainer` 與你的 `docs/ar/` 底下的檔案：

`notes-to-action-digest`、`daily-priority-briefing`、`weekly-wrapup-focus`、`one-on-one-prep-briefing`、`team-standup-digest`、`retro-synthesis`、`postmortem-facilitator`、`delivery-health-review`、`project-recovery-plan`、`customer-escalation-management`、`managed-service-operations-review`、`cloud-cost-reliability-review`、`commitment-risk-review`、`cross-team-dependency-log`、`meeting-notes-to-structured-doc`

輸出裡出現「負責人反覆不清楚」這類責任歸屬問題的 skill，同樣加了一條指向 `role-clarity-decision-rights` 與你的 `docs/raci/` 底下的檔案：

`delivery-health-review`、`customer-escalation-management`、`commitment-risk-review`、`architecture-decision-record`、`cross-team-dependency-log`

`feedback-growth-plan` 刻意沒有接進來——它的輸出屬於敏感人事內容，不適合跟其他事務性 action item 混在同一份共用追蹤表裡。

## 想幫多個團隊/專案分開追蹤？

`docs/ar/`、`docs/raci/`、`docs/adr/` 都是資料夾，不是單一檔案，可以依團隊/專案各自複製一份範本、取不同檔名（例如 `docs/ar/platform-team.md`、`docs/ar/mobile-team.md`），彼此獨立維護，不用共用同一份表格。
