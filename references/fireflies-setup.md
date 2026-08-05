# 會議記錄工具設定：Fireflies.ai

這些 skill 的輸入常常來自會議逐字稿/摘要，這裡是實際把 Fireflies.ai 設定起來、餵資料進 skill 的完整流程。

## 基本設定與使用步驟

1. 到 [fireflies.ai](https://fireflies.ai/) 用 Google/Microsoft/Email 註冊，免費、不用信用卡
2. 進 **Integrations → Calendar**，串接 Google Calendar 或 Outlook（這步是自動加入會議的必要條件）
3. 打開 **「Automatically Join」**，之後行事曆上排定的 Zoom/Meet/Teams 會議，AI notetaker（顯示名稱通常是 "Fred" 或 "Notetaker"）會自動加入並開始錄製，全程不用手動按任何按鈕
4. 會議結束後 5-10 分鐘，逐字稿、AI 摘要、自動抽取的 Action Items 會出現在 Dashboard，並寄一封附連結的通知信
5. 可以在 **Analytics** 分頁看到 talk-to-listen ratio、最長獨白時間、發言字數、填充詞次數等參與度數據（1-1 自我檢視很好用，見 `meeting-participation-balance-review` skill）
6. 用 Dashboard 的關鍵字搜尋可以跨「所有歷史會議」找同一個主題被提過幾次（見 `cross-meeting-topic-tracker` skill）
7. Fireflies 有官方 **MCP Server**，可以讓 Claude 直接讀取會議資料，不用手動複製貼上

## 不讓 Bot 加入會議、改用 Desktop App 錄系統音訊

有些會議不方便讓 Fireflies Bot（顯示名稱 "Fred"/"Notetaker"）出現在參與者名單裡，可以改用 **Fireflies Desktop App 的 Take Notes（System Audio）模式**：本機直接擷取系統音訊輸出＋麥克風輸入，不邀請 Bot 進會議。

1. 安裝並登入 **Fireflies Desktop App**
2. 第一次使用時允許：麥克風權限、以及系統設定 → **隱私權與安全性 → 螢幕與系統錄音**（macOS 14 Sonoma 後的名稱；13 Ventura 叫「螢幕錄製」）裡的 Fireflies 開關
3. 正常加入 Zoom/Meet/Teams，打開 Fireflies Desktop App，點右上角 **Take Notes**
4. 把 **Settings → Recording & Privacy → Auto-record meetings** 改成 `Only when I invite fred@fireflies.ai`（或在 Upcoming Meetings 關掉該場會議的 Fireflies 加入開關），避免 Bot 自動加入
5. 限制：不會存原始音訊/影片；說話者可能只顯示 Speaker 1/2、不一定能直接對應到姓名；開會前最好先做 1 分鐘測試

## 如果戴藍牙耳機開會、System Audio 錄不到對方聲音（只錄得到自己說話）

這是 macOS 藍牙協定層級的已知衝突，不是 Fireflies 的權限問題——如果同一副藍牙耳機**同時**被系統設成輸入（麥克風）跟輸出（喇叭），只要有 App 要收音，macOS 會把藍牙連線從高音質的 **A2DP** 切到免持通話用的 **HFP**（單聲道、16000Hz），系統音訊輸出的品質會被一起拖垮，甚至聽不到。判斷方法：`system_profiler SPAudioDataType` 看藍牙耳機的輸入取樣率是不是 16000（HFP 特徵值）。

修法是把輸入跟輸出裝置分開，不要共用同一副藍牙耳機。開會前（或懷疑輸入又被耳機搶走時）跑：

```bash
brew install switchaudio-osx   # 只需裝一次
bash fix-bluetooth-audio-input.sh
```

`fix-bluetooth-audio-input.sh` 會檢查目前的輸入裝置，如果不是內建麥克風（代表被藍牙耳機搶走、跑 HFP），就自動切回內建麥克風；輸出維持藍牙耳機不動，聽對方聲音仍走 A2DP 高音質。已經是內建麥克風的話就什麼都不做。內建麥克風的裝置名稱寫死在腳本的 `BUILTIN_MIC` 變數裡，跟你系統顯示的名稱不一樣的話要自己改。

改完後完整重開 Fireflies Desktop App（`⌘+Q` 而不是只關視窗）再測一次，讓它重新抓到新的音訊裝置設定。

**注意：藍牙耳機重新連線後可能會把輸入搶回去。** macOS 有時會在藍牙耳機重新連上時自動把輸入焦點切回耳機（也就是又跑回 HFP、重現同樣的問題）。如果之後又發現錄不到對方聲音，重跑一次 `fix-bluetooth-audio-input.sh` 即可。

## 把 Fireflies 輸出接進 skill

| Skill | 用 Fireflies 輸出的哪個部分 |
|---|---|
| `notes-to-action-digest` | 逐字稿/AI 摘要 → 拆解決策/待辦/待釐清 |
| `meeting-notes-to-structured-doc` | 多次會議摘要 → 整合成一份知識文件 |
| `one-on-one-prep-briefing` | 上次 1-1 的摘要/Action Items → 會前簡報 |
| `meeting-participation-balance-review` | Analytics 分頁的 talk-time/參與度數據 → 自我檢視 |
| `cross-meeting-topic-tracker` | 跨會議關鍵字搜尋結果 → 同一主題的演變時間軸 |
