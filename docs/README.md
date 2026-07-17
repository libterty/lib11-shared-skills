# Action Register & RACI Tracker

兩份你直接管控、手動編輯的活文件，加上一個輔助更新的 skill。

## 檔案

- `shared-skills/docs/action-register.md` — 行動追蹤表，記錄每個 action item 的負責人/來源/截止日期/狀態，跨會議持續維護
- `shared-skills/docs/raci-matrix.md` — 責任分配表，定義每個決策/任務類型誰是 R/A/C/I

這兩份都是純 markdown 表格，直接用編輯器打開改就好，不需要任何工具或 skill 才能使用。`shared-skills/docs/` 底下放的是非 skill 的參考資料/範本，`scripts/validate-skills.sh` 會跳過這個目錄，不會把它當成一個缺 SKILL.md 的 skill 來報錯。

## 跟 skill 的關係

| 你想做的事 | 用什麼 |
|---|---|
| 從零開始釐清角色重疊、產出一份待確認的 RACI 提案 | `shared-skills/role-clarity-decision-rights/SKILL.md` |
| 已經有定案的 RACI，直接維護 | 手動編輯 `shared-skills/docs/raci-matrix.md` |
| 開完會，想知道 Action Register 該新增/更新哪些列 | `shared-skills/action-register-maintainer/SKILL.md` |
| 直接調整 Action Register 內容 | 手動編輯 `shared-skills/docs/action-register.md` |

`action-register-maintainer` 只會**提出建議的異動**（新增哪些列、哪些該標記逾期、哪些該移到已完成），不會自己動手改 `shared-skills/docs/action-register.md`——實際要不要採用建議、要不要真的修改檔案，由你決定並自己動手改。
