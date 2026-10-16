# cognee-skill

Bộ **Agent Skills** cho [cognee](https://github.com/topoteretes/cognee) — mirror từ thư mục
[`.agents/skills/`](https://github.com/topoteretes/cognee/tree/main/.agents/skills) của repo gốc
(symlink `.claude/skills` trong repo gốc cũng trỏ tới đây).

Repo này là bản mirror **chỉ-đọc**: không sửa file skills trực tiếp ở đây — mọi thay đổi đến từ
upstream `topoteretes/cognee@main` và được sync tự động bằng GitHub Actions (mỗi ngày, lúc 03:00 UTC).

## Cấu trúc

```
cognee-skill/
├── skills/<skill-name>/SKILL.md   # 19 skills, mirror từ .agents/skills của upstream
├── scripts/sync.sh                # sync thủ công trên máy local
└── .github/workflows/sync.yml     # auto-sync định kỳ (cron) từ upstream
```

## Danh sách skills

| Skill | Dùng khi |
|---|---|
| [`cognee-install`](skills/cognee-install/SKILL.md) | Cài cognee, chạy flow `remember → recall` đầu tiên với Python SDK |
| [`cognee-ingestion`](skills/cognee-ingestion/SKILL.md) | Nạp dữ liệu vào memory bằng `remember()` (text, file, URL, repo, DB, ontology, chunking…) |
| [`cognee-recall`](skills/cognee-recall/SKILL.md) | Truy vấn memory bằng `recall()` / `search()` — chọn search type, scope, đọc kết quả |
| [`cognee-forget`](skills/cognee-forget/SKILL.md) | Xoá dữ liệu khỏi memory bằng `forget()` an toàn (1 document / cả dataset) |
| [`cognee-cli`](skills/cognee-cli/SKILL.md) | Điều khiển cognee từ terminal: `cognee-cli` remember/recall/forget, config, migrations |
| [`cognee-server`](skills/cognee-server/SKILL.md) | Chạy cognee API server (+ UI) trên máy mình, health check, auth |
| [`cognee-docker`](skills/cognee-docker/SKILL.md) | Chạy cognee bằng Docker image có sẵn hoặc docker compose (UI + MCP + Postgres + Neo4j) |
| [`cognee-integrations`](skills/cognee-integrations/SKILL.md) | Kết nối LLM/embedding providers, DB (Postgres, Neo4j…), S3, MCP server qua `.env` |
| [`cognee-custom-graph-models`](skills/cognee-custom-graph-models/SKILL.md) | Tự định nghĩa shape knowledge graph: DataPoint, identity fields, typed Edges |
| [`cognee-custom-pipelines`](skills/cognee-custom-pipelines/SKILL.md) | Viết custom tasks/pipelines, `add_data_points`, `memify`, debug data flow |
| [`cognee-migrations`](skills/cognee-migrations/SKILL.md) | Database migrations — Alembic (relational) + graph/vector, `cognee-cli upgrade/downgrade` |
| [`cognee-permissions`](skills/cognee-permissions/SKILL.md) | Users, tenants, roles, chia sẻ dataset, multi-tenancy, PermissionDeniedError |
| [`cognee-performance`](skills/cognee-performance/SKILL.md) | Tối ưu tốc độ/chi phí/rate limit: batching, chunk size, per-stage models |
| [`cognee-improve-sessions`](skills/cognee-improve-sessions/SKILL.md) | Session memory & `improve()` — lưu conversation, agent traces, feedback |
| [`cognee-community`](skills/cognee-community/SKILL.md) | Plugins cộng đồng: Qdrant/Milvus/Redis…, connectors (Slack, Gmail, Notion…), custom retrievers |
| [`company-brain-company-qa`](skills/company-brain-company-qa/SKILL.md) | Cookbook: company memory Q&A từ SQL + support tickets + docs |
| [`company-brain-follow-up-agent`](skills/company-brain-follow-up-agent/SKILL.md) | Cookbook: rút next steps từ call mới nhất → Linear issue + Slack |
| [`personalized-email`](skills/personalized-email/SKILL.md) | Cookbook: draft reply Gmail theo tone của bạn, dùng memory từ các meeting |
| [`self-hosted-companion`](skills/self-hosted-companion/SKILL.md) | Cookbook: companion chat biết folder notes (Obsidian/journal) và mọi cuộc chat trước |

## Cách dùng

Cài vào agent của bạn (Claude Code, Cursor, Codex, …) theo chuẩn Agent Skills — copy thư mục skill
chứa `SKILL.md` vào thư mục skills của agent, ví dụ:

```bash
# ví dụ: cài 1 skill cho Claude Code
git clone https://github.com/Stellarhold170NT/cognee-skill.git
cp -r cognee-skill/skills/cognee-recall ~/.claude/skills/
```

Hoặc cài cả bộ:

```bash
cp -r cognee-skill/skills/* ~/.claude/skills/
```

## Sync từ upstream

**Tự động** — workflow `sync.yml` chạy cron `0 3 * * *` (hoặc bấm *Run workflow* trong tab Actions):
sparse-checkout `.agents/skills` từ `topoteretes/cognee@main`, rsync vào `skills/`,
commit + push nếu có thay đổi (dùng `GITHUB_TOKEN` mặc định, không cần PAT).

**Thủ công trên máy local:**

```bash
./scripts/sync.sh
```

## Nguồn & bản quyền

- Nguồn: [`topoteretes/cognee`](https://github.com/topoteretes/cognee) — thư mục `.agents/skills/`
- Bản skills mirror giữ nguyên license gốc của upstream: **Apache-2.0** (xem [LICENSE](LICENSE)).
- File skills không được sửa tay trong repo này; contributions nên gửi PR về upstream.
