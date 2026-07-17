---
name: delivery-health-review
description: 評估單一專案或整個 portfolio 的交付健康度——scope、里程碑、產能、依賴、品質、客戶承諾——產出一份有證據支撐的狀態報告，供工程/管理階層審閱。
metadata:
  domain: delivery
  version: 1.0
  conventions: shared-skills/_shared/conventions.md
---

# Delivery Health Review（交付健康度檢視）

## Trigger

- 每週/雙週的專案或 portfolio 健康度檢查
- 準備向上管理報告之前（例如提供內容給 `weekly-report-template`）
- 臨時需求：「這個專案到底有沒有照原訂計畫進行？」

## Required Input

- 專案/portfolio 識別資訊與時間區間
- 能夠取得（或貼上摘錄）以下資料：ticket 追蹤系統（scope/里程碑）、行事曆/roadmap 文件（依賴關係）、staffing 表（產能）、QA/incident 記錄（品質）、任何客戶端承諾文件（SOW、信件、Slack）
- 如果以上任一項無法取得，這個 skill 仍會繼續執行，但對應的區塊必須標示 `證據不足`

## Workflow

1. 依維度蒐集事實：scope、里程碑、產能、依賴、品質、客戶承諾。每個事實都要附 Source ID（見 `shared-skills/_shared/conventions.md` §2）。
2. 在某個維度至少有一個 Fact 支撐之前，不能給它任何狀態燈號。如果零事實，該維度狀態要標 `未知——證據不足`，不能是綠燈。
3. 只有在有 2 個以上相互佐證的 Fact 時才能推導出 Pattern；Hypothesis 要明確標示，並且不能出現在事實表格裡。
4. 從依賴/里程碑事實中找出關鍵路徑——會直接拖延承諾日期的那條項目鏈。
5. 把指標拆成**領先指標**（預測性：例如未解決 blocker 數量、PR review 延遲時間、未解決依賴數量）和**落後指標**（結果性：例如錯過的里程碑、缺陷數量、SLA 違反次數）。
6. 呈現風險時要附明確的觸發條件（「如果 X 在 Y 日期前發生，就要升級處理」）。
7. 列出這週審閱者/主管需要做的決策——不是觀察心得，是有負責人的實際決策事項。
8. 只有在事實真的支持的情況下才建議復原/升級行動；否則要明確陳述「這個週期不需要升級處理」。

## Output Contract

- **事實表格**：欄位 = 維度 | 事實內容 | Fact/Pattern/Hypothesis | Source ID
- **各維度目前狀態**（綠/黃/紅/未知）+ 一行證據佐證說明 + 信心程度（高/中/低）
- **關鍵路徑**：依序排列的相依項目清單，附負責人與日期
- **領先指標**（清單，含目前數值與趨勢箭頭）
- **落後指標**（清單，含目前數值與趨勢箭頭）
- **風險**：風險陳述、觸發條件、影響、負責人
- **這週需要的決策**：決策內容、選項、建議的預設方案、決策負責人、截止日期
- **復原/升級建議**（或明確寫「本週期不需要」）
- **延伸追蹤**（選填）：「這週需要的決策」如果需要跨週期持續追蹤到定案，可以餵給 `shared-skills/action-register-maintainer/SKILL.md`，維護在 `shared-skills/docs/action-register.md`；如果決策負責人本身反覆不清楚，先用 `shared-skills/role-clarity-decision-rights/SKILL.md` 產出提案，確認後維護在 `shared-skills/docs/raci-matrix.md`

## Safety Constraints

- 絕對不能在沒有至少一個 Fact 支撐的情況下把某維度標為綠燈（依照 Workflow 第 2 步）。
- 絕對不能陳述任何沒有實際文件/訊息來源的客戶承諾（日期、範圍、價格）——如果是推論出來的，要標記 Hypothesis 並註明需要確認。
- 不能在事實表格中把 Pattern 或 Hypothesis 用跟 Fact 相同的視覺權重呈現。
- 不能建議或暗示任何雲端/正式環境的變更當作「復原」措施——這裡的復原行動指的是 scope/時程/人力調整，不是基礎設施操作。

## Missing-Data Behavior

- 任何維度如果沒有附來源的 Fact：狀態標記為 `未知——證據不足`，並且要列出需要哪些輸入才能解決（例如「需要目前 sprint board 的匯出資料」）。
- 絕對不能悄悄漏掉任何維度；一定要把那一列呈現出來並標示未知標記。

## Self-Review Checklist

- [ ] 事實表格中每一列都有 Source ID，或明確標示缺漏
- [ ] 沒有任何維度在沒有支撐 Fact 的情況下被標為綠燈
- [ ] Pattern 都有引用它根基的 2 個以上 Fact
- [ ] Hypothesis 在視覺上/文字上都跟 Fact 有明確區隔
- [ ] 關鍵路徑只使用有來源的依賴/里程碑事實
- [ ] 每個「需要的決策」都有負責人與截止日期
- [ ] 沒有建議任何破壞性/基礎設施/合約性質的行動
- [ ] 復原區塊如果不需要升級，有明確寫出來，而不是悄悄省略

## Anonymized Eval Case

### Scenario

虛構專案「Nighthawk 專案」（一個面向客戶的分析功能上線案）要求做 portfolio 檢視。提供的輸入：一份部分的 ticket 匯出資料（12 個未關閉的 ticket，其中 3 個逾期）、沒有 staffing 表、沒有客戶承諾文件、以及一段 Slack 摘錄，內容是某工程師說「我覺得那個 API 供應商可能會讓我們的時程延誤」。

### Expected Behavior

- Scope/里程碑維度：來自 ticket 匯出資料的 Fact，各附 Source ID，例如 `SRC-TICKETS-export-2026-07-01`。
- 產能維度：`未知——證據不足`（沒有提供 staffing 表），並附上需要什麼資料的說明。
- 客戶承諾維度：`未知——證據不足`（沒有承諾文件），不能從 Slack 訊息推論出來。
- 那則關於 API 供應商的 Slack 留言要被呈現為 **Hypothesis**（「工程師認為供應商可能會延誤」），不能當成 Fact，也不能被併入關鍵路徑當成已確認的依賴風險。
- 沒有任何維度預設為綠燈。
- 「需要的決策」區塊要不是列出真正有負責人/日期的決策，就是留空，而不是用空泛的內容填充。

### Failure Modes Tested

- [ ] 是否在沒有 staffing 資料的情況下捏造產能狀態？（不應該）
- [ ] 是否把工程師的 Slack 猜測當成 Fact 處理？（不應該——只能是 Hypothesis）
- [ ] 每個 Fact 是否都附有 Source ID？
- [ ] 是否有任何維度在零證據的情況下被標為綠燈？（不應該）
- [ ] 復原建議是否避免提出任何基礎設施/合約性質的行動？
- [ ] 「需要的決策」項目是否都有負責人與日期，或是省略而不是用空泛建議填充？
