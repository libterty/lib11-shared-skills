# Example Scenarios

練習用範例情境,幫助熟悉這個 repo 裡各個 skill 的輸入格式與觸發時機。分類方式對照 `references/skill-catalog.md`。每個情境附一段可以直接貼給 Claude 的範例輸入,實際使用時把範例資料換成你自己的真實內容。

建議練習順序:先從 E 類的 `daily-priority-briefing` → `one-on-one-prep-briefing` → `meeting-agenda-draft` 上手,這三個最貼近日常場景,也最容易感受到 Fact/Hypothesis 標註、Source ID、和「草案待你簽核」這幾條 cross-cutting 規則(見 `_shared/conventions.md`)的效果。

## E. 個人生產力與日常會議工作流程

**daily-priority-briefing** — 情境:週一早上進辦公室
> 「幫我看今天的行事曆、還沒回的信件/ticket,加上昨天沒做完的『review PR #482』和『回覆客戶 A 的續約問題』,整理成今天的優先序清單,並標出行程衝突。」

**one-on-one-prep-briefing** — 情境:等下 3 點要跟工程師 Kevin 1-1
> 「等下 3 點要跟 Kevin 1-1,上次會議他答應要完成 rate limiter 的 POC 並跟我回報進度,也提到想討論升遷的事。幫我整理回顧重點跟這次談話建議切入點。」

**team-standup-digest** — 情境:整理團隊 Slack 上的 async standup
> 「這是今天團隊 5 個人在 Slack 貼的 standup(貼上文字)——幫我整理成 blockers / highlights / 需要我介入的地方。」

**problem-statement-framing** — 情境:主管丟了一句模糊任務,還沒開始分析
> 「GM 跟我說『我們今年要提升團隊的工程效能』,只有這一句話,沒有其他背景。幫我照 Basic Question / Context / Decision Makers & Stakeholders / Criteria for Success / Solution Scope / Constraints / Key Sources of Insight 七個欄位,把這個任務收斂成可以分析的問題定義,並列出還缺哪些資訊、該去問誰。」

**meeting-agenda-draft** — 情境:明天要開一場例行 sprint review
> 「明天下午 2 點要開 sprint review,30 分鐘,參與者是我、PM Amy、工程師 3 位。目的是同步這個 sprint 完成的項目跟下個 sprint 的風險。幫我草擬議程。」

**meeting-question-decomposer**(配 `meeting-agenda-draft` 使用)— 情境:核心問題太模糊,還不知道怎麼開會
> 「下週要開會決定『要不要把現有的單體服務拆成微服務』,這個問題還很模糊,幫我拆解成今天會議該回答的子問題、會前該準備的背景資料、跟可以先放 parking lot 的項目。」

**notes-to-action-digest** — 情境:一串很長的信件討論串
> 「這是我跟客戶 IT 主管來回 6 封信的內容(貼上),幫我整理出決策事項、附負責人的待辦、待釐清問題、跟純資訊內容。」

**meeting-notes-to-structured-doc** — 情境:想把 3 次零散的架構討論會議記錄整合進 wiki
> 「這是過去一個月 3 次關於『資料庫遷移』討論的會議記錄(貼上),幫我整合成一份可以放進團隊 wiki 的結構化文件草稿。」

**cross-meeting-topic-tracker**(跟上面不同:這個是「同一主題」隨時間演變)
> 「用 Fireflies 搜尋『多雲備援』這個關鍵字,找到 4 場會議的片段(貼上),幫我整理成時間軸,標出立場怎麼變化、還沒解決的部分。」

**retro-synthesis** — 情境:Sprint retro 白板貼滿 sticky notes
> 「這是這次 retro 白板上 20 張 sticky notes 的文字(貼上),幫我歸納成幾個主題,並提出排序過的具體 action item 草案。」

**cross-team-dependency-log** — 情境:3 個團隊各自回報進度,但看不出誰卡住誰
> 「這是 Platform、Data、Mobile 三團隊這週的狀態更新(貼上),幫我整理成誰在等誰、卡多久、風險等級的依賴清單。」

**engineering-metrics-review** — 情境:手動從 GitHub 匯出 PR 數據
> 「這是上個月的 PR cycle time 跟 deploy 頻率原始數字(貼上 CSV/表格),幫我分析趨勢跟可能的瓶頸。」

**weekly-wrapup-focus** — 情境:週五下班前
> 「這週做完的事:A、B、C;還沒做完的:D。幫我整理本週完成總結,並提出下週排序過的重點清單。」

**hiring-pipeline-status** — 情境:手上有 8 個候選人卡在不同階段
> 「這是從 Greenhouse 匯出的候選人階段資料(貼上),幫我整理成 pipeline 現況,標出卡住的階段跟逾期沒跟進的人。」

**meeting-participation-balance-review** — 情境:Fireflies 給了你這場會議的說話佔比數據
> 「這是我今天主持的 1-1 的 Fireflies talk-to-listen 分析(貼上),幫我檢視我是不是講太多、聽太少。」

**stakeholder-pre-brief-for-results-meeting** — 情境:下週要公布一個會讓某人不開心的決策
> 「下週的季度回顧會議要公布『某功能延期,原因是團隊 B 的 API 沒準時交付』,這可能讓團隊 B 的負責人在會議上被動。幫我規劃該先跟誰、用什麼順序個別溝通。」

**action-register-maintainer** — 情境:手上已經有一份 Action Register 活文件
> 「這是這週兩場會議的記錄(貼上),對照 `docs/ar/2026-q3.md` 現有內容,幫我列出建議新增/更新/標記逾期的異動(你自己決定要不要套用)。」

## A. 交付與專案管理

**delivery-health-review**
> 「幫我評估『客戶 X 資料平台』這個專案目前的交付健康度——這是目前的 scope、里程碑、產能、依賴、品質資訊(貼上)。」

**project-recovery-plan**
> 「『客戶 Y 遷移專案』已經延遲兩個月、scope 一直在跑掉、客戶信任在流失,幫我做一份復原計畫。」

**capacity-roadmap-scenarios**
> 「Q4 規劃要決定要不要加 2 個 headcount,幫我產出維持現狀／人力受限／加速衝刺三種情境,附取捨。」

**strategy-execution-mbto-check**
> 「我們打算把客服支援全面轉成 AI 客服機器人,這個方向還很模糊,幫我做一次 Market/Business/Technology/Organization 落地風險檢查,特別是組織/KPI/誘因這塊常被忽略的角度。」

**strategy-execution-review**
> 「兩個月前啟動的『每週無會議日』試點,當初假設是能提升深度工作時間,這是最近蒐集到的新證據(貼上),幫我區分情緒性/利益性/事實性的反對意見,給出繼續/調整/停止的建議。」

## B. Incident、可靠性與雲端維運

**incident-executive-update**
> 「production API 從 14:20 開始間歇性 502,還在排查中,幫我草擬一份給主管的狀態更新。」

**postmortem-facilitator**
> 「上週五的 15 分鐘全站中斷已經解決,幫我主持一份無責備的檢討報告草稿。」

**cloud-cost-reliability-review**
> 「幫我做一次 AWS 帳單 + SLO 達成率 + on-call 負載的整合檢視(我把這幾份數據貼給你)。」

**architecture-decision-record**
> 「我們決定把訊息佇列從 SQS 換成 Kafka,幫我寫一份 ADR,附選項比較跟 rollback 計畫。」

## C. 客戶與跨組織交付

**customer-escalation-management**
> 「客戶 Z 因為連續兩次 deploy 造成他們的排程作業失敗,揚言要考慮不續約,幫我整理事實時間軸跟圍堵計畫。」

**commitment-risk-review**
> 「Sales 剛簽了一份 SOW,承諾 6 週內交付一個客製整合功能,幫我從工程角度審查這個承諾的交付跟維運風險。」

**managed-service-operations-review**
> 「幫我做這季的 MSP 維運健康度檢視——SLA 達成率、on-call 負載、support backlog(資料貼上)。」

## D. 人才與組織能力

**feedback-growth-plan**
> 「工程師 Tom 這季在 code review 上給的回饋常常太晚,影響團隊 velocity,幫我規劃一次回饋對話跟成長計畫。」

**hiring-interview-calibration**
> 「我們要開一個 Senior Backend Engineer 職缺,幫我設計面試流程跟 scorecard。」

**role-clarity-decision-rights**
> 「Tech Lead 跟 PM 對『技術債要不要排進這個 sprint』常常各說各話,幫我設計一份決策權責提案。」
