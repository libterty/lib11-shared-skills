# Shared Skills

一組給 Claude Code（或任何能讀 markdown 並照著執行的 AI CLI，例如 Codex）使用的「管理技能」與「個人生產力技能」，用純 markdown 定義，沒有 Claude 專屬語法，附結構驗證機制。

這個 repo 可以獨立使用，也可以當作 git submodule 掛在其他專案下使用。

> **兩個跨領域的最高優先 skill，自動套用、不用使用者明確要求：**
> - **`communication-writing`**：只要輸出包含要送給別人看的文字（email、工作訊息、向上報告、客戶/HR 溝通、任何 skill 產出的溝通草案），管**怎麼寫**。細節見 [`communication-writing/SKILL.md`](communication-writing/SKILL.md) 與 `_shared/conventions.md` §10。
> - **`communication-riqc`**：只要是工作進度回報、或回應提問與臨時任務指派，管**講什麼、怎麼排**（R-I-Q-C 四段結構）——不限對上，對主管/GM/董事長/客戶、平行同事或其他團隊、下屬都適用。細節見 [`communication-riqc/SKILL.md`](communication-riqc/SKILL.md) 與 `_shared/conventions.md` §11。
>
> 兩者同時適用時，先用 `communication-riqc` 排結構，再用 `communication-writing` 把每段寫清楚。要讓這兩條規則在每次啟動、任何專案、任何機器都自動載入（不用手動呼叫），見下方「方式四」。

---

## 目錄結構

```text
shared-skills/
├── _shared/
│   └── conventions.md          # 所有 skill 都必須遵守的共用規則（唯一權威來源）
├── docs/                       # 非 skill 的參考資料/範本，見 docs/README.md
├── references/                 # skill 索引、跨 skill 依賴、範例情境、Fireflies 設定
│   ├── skill-catalog.md
│   ├── skill-dependencies.md
│   ├── fireflies-setup.md
│   └── docs/example-scenarios.md
├── validate-skills.sh           # 結構與安全啟發式驗證腳本
├── install-global-policies.sh   # 把有 global-policy-snippet.md 的 skill 設成全域自動套用
├── install-claude-tools.sh      # 讓 Claude Code 全域發現這些 skill
├── install-codex-tools.sh       # 讓 Codex 註冊 global skills + prompt fallback
├── communication-writing/       # 跨領域最高優先寫作標準
├── communication-riqc/          # 跨領域最高優先回報結構標準
└── <skill-name>/SKILL.md        # 每個 skill 一個資料夾
```

`_shared/`、`docs/`、`references/` 都不是 skill，`validate-skills.sh` 掃描時會跳過這些。`docs/` 底下累積實際的內部資訊（Action Register、RACI、ADR、會議記錄、1:1、教練計畫等），整個被 `.gitignore` 排除，避免不小心把內部內容提交進這個公開 repo。細節見 `docs/README.md`。

---

## 這些 skill 是什麼、怎麼運作

每個 `SKILL.md` 都是給 Claude 讀的「操作手冊」，固定包含 8 個區塊：Trigger（何時用）、Required Input（要給什麼資料）、Workflow（怎麼分析）、Output Contract（輸出長什麼樣）、Safety Constraints（絕對不能做的事）、Missing-Data Behavior（資料不足時怎麼誠實表達）、Self-Review Checklist（自我檢查清單）、Anonymized Eval Case（匿名化測試情境）。

所有 skill 共同遵守 `_shared/conventions.md`，重點是：

- 每個事實陳述都要附 **Source ID**（可追溯出處）
- 每句斷言標明 **Fact／Pattern／Hypothesis**，三者不能混為一談
- 不得捏造客戶承諾、incident root cause、人員績效判斷、交付日期或成本效益數字
- 對外或對人（1:1、績效）的內容一律只是**草稿**，需要人工審核簽核
- 不會宣稱自己執行了任何破壞性操作、雲端變更、合約承諾——skill 只產出分析與建議，行動永遠由人決定

---

## 怎麼使用

### 方式一：手動指名檔案（任何 AI CLI 都能用）

跟 Claude／Codex 說明情境，並直接指向 skill 檔案：

> 「請照 `shared-skills/project-recovery-plan/SKILL.md` 的定義，幫我針對 XX 專案做一份 recovery plan。以下是目前的狀況：……」

Claude 會讀取該 `SKILL.md`，照 Required Input 檢查資料夠不夠，缺的部分依 Missing-Data Behavior 明講「證據不足」，然後照 Workflow 產出 Output Contract 規定的欄位。準備好 Required Input 欄位的資料再開口，能省掉一輪來回。

### 方式二：Claude Code 原生發現

Claude Code 的 Skill 工具是從 `~/.claude/skills/<name>/SKILL.md` 探索 skill 的，不是這裡的 `shared-skills/`。跑 `shared-skills/install-claude-tools.sh`（見「方式四」）會把 `shared-skills/<name>/` symlink 到那個位置，全域生效——同一台機器上任何專案都能讓 Claude Code 原生列出並主動提議使用這些 skill。

### 方式三：Codex

Codex 會從 `~/.codex/skills/<name>/SKILL.md` 探索 global skills。`install-codex-tools.sh` 會把 `shared-skills/<name>/` symlink 到那個位置，讓 Codex 當成原生 skill；同時把 `SKILL.md` 去掉 YAML frontmatter 後存成 custom prompt（`~/.codex/prompts/*.md`），作為 `/<skill-name>` 手動呼叫的 fallback。

### 方式四：全域自動套用（跨機器、跨 CLI，不用手動呼叫）

方式一到三都需要你手動指名檔案、或 Claude 自己判斷任務相關才會套用。`communication-writing`、`communication-riqc` 這種「不用等使用者要求就要套用」的規則，光靠這樣不夠可靠——所以額外把精簡的強制規則寫進 Claude Code 跟 Codex **每次啟動都會讀取**的全域設定檔（`~/.claude/CLAUDE.md`、`~/.codex/AGENTS.md`）。

在任何一台機器上，clone 這個 repo（或它所在的父 repo）之後執行：

```bash
shared-skills/install-global-policies.sh  # 把全域強制規則寫進兩個 CLI 的全域設定
shared-skills/install-claude-tools.sh     # 讓 Claude Code 全域發現這些 skill
shared-skills/install-codex-tools.sh      # 讓 Codex 註冊 global skills + prompt fallback
```

第一支腳本是**冪等**的，而且**會自動發現新的全域規則**：任何 `shared-skills/<skill-name>/global-policy-snippet.md` 都會被包成獨立的註解標記區塊寫進兩個全域設定檔——新增一個要全域套用的 skill，只要幫它加一份 `global-policy-snippet.md`，不用改這支腳本。之後改了規則、`git pull`，重跑一次腳本只會更新對應的區塊，不動到你自己加的其他個人設定。

驗證有沒有生效：

- Claude Code：新開一個 session，輸入 `/context` 確認有載入 `~/.claude/CLAUDE.md`；或直接問「List the communication rules you must apply when drafting an email.」
- Codex：`codex --ask-for-approval never "Summarize the instructions you must follow when writing an email."`

### 驗證

新增/修改 skill 後執行 `bash validate-skills.sh`，會檢查 8 個必要區塊、frontmatter、Source ID／Fact／Hypothesis 標記慣例、以及是否出現未經限定的絕對承諾語句。這是**結構性**檢查，抓不到語意上的漏洞。

---

## 找 skill、看範例、串接用法

- **完整 skill 索引**（分類、路徑、使用時機）：[`references/skill-catalog.md`](references/skill-catalog.md)
- **單一 skill 的範例輸入 + 跨 skill 串接情境**：[`references/docs/example-scenarios.md`](references/docs/example-scenarios.md)
- **skill 之間的依賴關係**（誰的輸出接誰、哪些 skill 互斥）：[`references/skill-dependencies.md`](references/skill-dependencies.md)
- **Fireflies.ai 會議記錄工具設定**（含藍牙音訊除錯）：[`references/fireflies-setup.md`](references/fireflies-setup.md)
