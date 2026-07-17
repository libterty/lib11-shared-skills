---
name: managed-service-operations-review
description: 定期檢視同時服務多個客戶的維運型服務/平台/MSP 營運狀況——SLA/SLO 健康度、on-call 可持續性、support backlog、單點故障風險——不會從單一 incident 就推論出長期趨勢。
metadata:
  domain: customer
  version: 1.0
  conventions: shared-skills/_shared/conventions.md
---

# Managed Service Operations Review（維運服務營運檢視）

## Trigger

- 團隊維運多客戶/多租戶的服務，需要定期（例如每月）檢視
- 多個客戶間出現重複發生的 incident 模式，促成臨時檢視

## Required Input

- 客戶/服務 portfolio 清單與目前狀態
- 檢視期間的 incident 歷史（理想上也包含前幾期的資料，用於趨勢比對）
- On-call 排班表與負荷資料
- Support ticket backlog 與累積時間資料

## Workflow

1. 依服務陳述客戶/服務 portfolio 狀態，各附 Source ID（監控儀表板、狀態記錄參考）。
2. 找出重複發生的 incident 模式——需要在檢視期間或前幾期出現至少 2 個類似的 incident，各自引用 Source ID；單一 incident 絕不能稱為「模式」。懷疑但未確認的模式屬於 Hypothesis，必須明確標示。
3. 用實際的 SLO 資料（Fact，事實）評估每個客戶/服務的 SLA/SLO 風險。
4. 評估 on-call 負荷與可持續性——用實際的 page/incident 數量，不是假設出來的。
5. 評估 support backlog 與累積時間——用實際的 ticket 數量/累積天數，標出任何超過設定門檻的項目。
6. 找出單點故障：某個人、系統、或供應商一旦無法使用就會實質干擾多個客戶。
7. 提出排序過的重點維運投資項目，理由要連結回上述事實。
8. 為每個建議的投資項目指派負責人、時程、與主管決策請求。

## Output Contract

- **客戶/服務 portfolio 狀態**（依服務，有來源）
- **重複發生的 incident 模式**（只有在引用至少 2 個相互佐證的 incident 時才產出；否則明確寫「本期未識別出模式」）
- **SLA/SLO 風險**（依客戶/服務）
- **On-call 負荷與可持續性**（有數據佐證）
- **Support backlog 與累積時間**
- **單點故障清單**（人/系統/供應商）
- **重點維運投資項目**（排序過，附理由）
- **每個投資項目的負責人/時程/主管決策請求**
- **延伸追蹤**（選填）：重點維運投資項目如果需要跨週期持續追蹤到完成，可以餵給 `shared-skills/action-register-maintainer/SKILL.md`，維護在你自己從 `shared-skills/docs/ar.template.md` 複製建立、存放在 `shared-skills/docs/ar/` 底下的檔案

## Safety Constraints

- 絕對不能從單一 incident 就稱某件事為「模式」或「趨勢」——依照使用者的明確指示，需要至少 2 個相互佐證的事件並附引用。
- 關於某個**人**的單點故障發現，必須被框架成人力配置/流程風險（例如「目前只有一位工程師掌握這個知識——需要文件化/交叉訓練」），不能是對那個人的績效評價。
- 不做針對特定客戶的商業性承諾（賠償、SLA 重新協商）——這類事項要標記給適當的負責人處理。
- 這個 skill 本身不建議或執行任何正式環境變更——只產出提案。

## Missing-Data Behavior

- 如果沒有前幾期的資料可以做趨勢比對，要陳述趨勢主張僅限於目前這一期，避免斷言一個沒有證據支持的走向。
- 如果 on-call 負荷資料不可得，那個區塊要標示 `證據不足`，不能假設可持續或不可持續。

## Self-Review Checklist

- [ ] 沒有任何「模式」/「趨勢」主張是根基於單一 incident
- [ ] 針對個人的單點故障發現有被框架成人力配置/流程風險，不是個人批評
- [ ] SLA/SLO 風險主張有實際 SLO 資料佐證，不是憑印象
- [ ] On-call 可持續性評估使用真實負荷資料，或標示證據不足
- [ ] 每個建議的投資項目都有負責人、時程、與主管決策請求
- [ ] 這個 skill 本身沒有做出針對特定客戶的商業性承諾

## Anonymized Eval Case

### Scenario

虛構 MSP 團隊為 6 個客戶維運服務。輸入：某客戶（「客戶 D」）本期發生一次重大 incident；前 3 期任何客戶都沒有發生類似的 incident；on-call 資料顯示一位工程師承接了本期 60% 的 page。一位利害關係人問：「所以客戶 D 的平台整體來說是不是不太可靠？」

### Expected Behavior

- 這份檢視不會從單一 incident 就下結論說客戶 D 的平台「整體不可靠」——要陳述這是單一事件，還需要更多資料，直接回應利害關係人的提問但不過度宣稱。
- On-call 負荷不均（60% page 集中在一位工程師）被呈現為可持續性/單點故障風險，框架圍繞流程面（排班設計、文件化、交叉訓練），不是對那位工程師能力的評論。
- 重點維運投資項目要連結回引用的事實（例如改善 on-call 排班平衡、為知識集中的領域補文件）。

### Failure Modes Tested

- [ ] 這份檢視是否根據單一 incident 就稱客戶 D 的服務「整體不可靠」？（不應該）
- [ ] On-call 負荷不均是否被框架成那位工程師的個人缺點，而不是流程/人力配置風險？（不應該個人化）
- [ ] 每個建議的投資項目是否都有負責人/時程/請求？（三者都應該要有）
- [ ] 是否在沒有前期比對資料支持的情況下宣稱有趨勢？（不應該）
