# 1:1 Meeting Tools

兩個不依賴任何 CLI、單機瀏覽器就能直接打開使用的 1:1 工具，跟 `one-on-one-prep-briefing/SKILL.md` 目的相同（幫 1:1 做準備、記錄），差別在於這兩個是純手動、離線的版本，適合不方便用 Claude Code / Codex 的場合。

## 檔案

| 檔案 | 用途 |
|---|---|
| `one_on_one_meeting_template.html` | 1:1 議程與筆記工具：員工議題優先、主管議題與回饋、職涯發展、心情/wellbeing 追蹤、Action Items、會議摘要、下次會議規劃。填寫內容自動存在瀏覽器 localStorage，並可下載成含資料的 HTML 檔（檔名 `1on1_<姓名>_<日期>.html`）。 |
| `ai_one_on_one_prep_prompt.html` | 填入某位團隊成員的背景資訊後，產生一段可直接貼給 AI 助理（ChatGPT/Claude/Gemini/Copilot 等）的 prompt，請 AI 幫忙草擬這次 1:1 的討論重點。工具本身不呼叫任何 AI，只負責組出 prompt 文字。 |

## 用法

直接用瀏覽器打開 `.html` 檔即可使用，不需要安裝或部署。兩個工具都會把你填寫的內容存在瀏覽器的 localStorage（同一台裝置、同一個瀏覽器下次打開會自動載入），也都提供「下載」按鈕輸出一份帶有目前填寫內容的獨立 HTML 檔。

## 隱私提醒

下載出來的檔案（`1on1_*.html`、`ai_1on1_prep_*.html`）會包含你填入的真實姓名與筆記內容，屬於機密個資，**不要提交進任何版控**。如果你把這個 repo clone 到自己的專案裡使用，記得在自己專案的 `.gitignore` 加上對應規則，比照 `docs/ar/`、`docs/raci/` 等資料夾「範本公開、實際內容不進版控」的原則。`ai_one_on_one_prep_prompt.html` 產生的 prompt 在貼給第三方 AI 工具前，也要先檢查是否包含不該外流的機密資訊。

## 跟 skill 的關係

`one-on-one-prep-briefing/SKILL.md` 是同樣目的的 CLI/skill 版本，適合已經在用 Claude Code / Codex 的情境，且能處理更彈性的輸入（例如貼上一段雜亂的舊筆記）。這兩個 HTML 工具則是不依賴任何 AI CLI、單機就能用的版本。兩者擇一使用即可，不需要同時維護。
