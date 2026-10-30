# templator-peppol

Peppol BIS 3.0 UBL/XML invoice templator with client-side XSLT transformation, Peppol validation backend, and SAPI-SK proxy integration. Part of the e-invoicing pipeline: create → validate → transform → send.

## Pipeline Overview

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Create    │───▶│  Validate   │───▶│ Transform   │───▶│   Send      │
│  (peppol-   │    │  (Peppol    │    │  (XSLT →    │    │  (SAPI-SK   │
│   features) │    │   validator)│    │   HTML)     │    │   proxy)    │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
       │                │                │                │
   Port 10001        Internal         Client-side      /sapi/*
                    (Saxon)           (browser)
```

## Features

- **Invoice Creation**: Web UI for creating/loading Peppol BIS 3.0 invoices
- **Validation**: Saxon-based UBL XSD + CEN EN16931 + Peppol EN16931 validation
- **XSLT Transformation**: Client-side XML → HTML with multiple templates
- **Template Library**: oberon-modern-1 (A4 print mode), oberon-klasik, oberon-vyhotovena
- **SAPI-SK Integration**: Proxy + Swagger UI for Slovak e-invoicing
- **Peppol Directory**: Participant lookup via REST API
- **Docker Stack**: Single `docker compose up` for full pipeline

## Components

| Component | Port | Description |
|-----------|------|-------------|
| `peppol-features` | 10001 | Root gateway (invoice editor, validator, transformer, SAPI link) |
| `templator` | internal | XSLT transformation backend (Saxon) |
| `peppol-validator` | internal | Peppol BIS validation (Saxon) |
| `sapi-sk-proxy` | internal | SAPI-SK API proxy + Swagger UI |

## Prerequisites

- Docker + Docker Compose
- Validation artifacts at `/home/rugent/data/peppol-validation-downloader-fixed/peppol-validation/downloaded` (read-only mount)

## Installation

```bash
git clone https://github.com/Rugents-masterpiece/templator-peppol.git
cd templator-peppol

# Start full stack
docker compose up -d --build

# Access
# Invoice editor:     http://<host>:10001/
# SAPI Swagger UI:    http://<host>:10001/sapi-docs/
# Validator health:   http://<host>:10001/validator-health
```

## Configuration

`docker-compose.yml` mounts:
- Validation artifacts (read-only): `/home/rugent/data/peppol-validation-downloader-fixed/...`
- Templates: `./docs/sablony/` → container
- Sample XML: `./docs/xml/` → container

Environment variables (in `docker-compose.yml`):
- `SAPI_BASE_URL` — upstream SAPI-SK endpoint
- `VALIDATOR_SAXON_PATH` — Saxon JAR location

## Usage

### 1. Create/Load Invoice
- Open `http://<host>:10001/`
- Upload XML or create manually
- Validates instantly via Peppol validator

### 2. Transform to HTML
- Go to "Vizualizácia" tab
- Select template (oberon-modern-1 recommended)
- Click "Transformovať" → preview HTML/PDF

### 3. Send via SAPI-SK
- Click "SAPI-SK" → opens Swagger UI
- Authenticate with client credentials
- POST invoice to `/sapi/v1/documents`

## Template Development

Templates in `docs/sablony/`:
- `oberon-modern-1.xslt` — modern, A4 print mode, QR codes
- `oberon-klasik.xslt` — classic layout
- `oberon-vyhotovena-1.xslt` — with pre-filled data

Test locally:
```bash
# In browser dev tools on transform page
# Or use saxon-cli directly
java -jar saxon-he.jar -s:invoice.xml -xsl:template.xslt -o:output.html
```

## Validation Artifacts

Required for Peppol validation (not in repo — mount from host):
- UBL 2.1 XSD schemas
- CEN EN16931 schematrons
- Peppol BIS 3.0 rules

Source: https://github.com/peppol/peppol-bis-billing-3.0

## Security

- No credentials in repository
- SAPI client credentials via environment / Swagger UI only
- Validation artifacts mounted read-only
- Runs on isolated Docker network


## 🤝 Contributing

Contributions are welcome! Whether it's bug fixes, new features, documentation improvements, or testing — every contribution helps.

### Ways to Contribute

| Type | Description |
|------|-------------|
| 🐛 **Bug Reports** | Found an issue? Open a GitHub Issue with steps to reproduce, expected vs actual behavior, and environment details |
| ✨ **Feature Requests** | Have an idea? Open a GitHub Issue with the "enhancement" label describing the use case |
| 📝 **Documentation** | Fix typos, clarify setup steps, add examples — PRs to `README.md` or `/docs` are always appreciated |
| 🔧 **Code** | Bug fixes, new features, refactoring, tests |
| 🧪 **Testing** | Test on different hardware/OS, report compatibility |
| 💡 **Ideas & Feedback** | Discussions, RFCs, architecture suggestions |

### Quick Start for Contributors

```bash
# 1. Fork the repository
# 2. Clone your fork
git clone https://github.com/YOUR-USERNAME/REPO-NAME.git
cd REPO-NAME

# 3. Create a feature branch
git checkout -b feature/your-feature-name

# 4. Make changes, test locally
# (see README for local development setup)

# 5. Commit with conventional commits
git commit -m "feat: add amazing feature"

# 6. Push and open a Pull Request
git push origin feature/your-feature-name
```

### Commit Convention

We use [Conventional Commits](https://www.conventionalcommits.org/):

```
feat:     new feature
fix:      bug fix
docs:     documentation only
style:    formatting, no code change
refactor: code restructuring
test:     adding tests
chore:    maintenance, deps, build
```

Examples:
- `feat: add voice selection UI for TTS`
- `fix: handle GPU OOM in model offloading`
- `docs: clarify Docker setup for ARM64`

### Pull Request Guidelines

- ✅ **One feature/fix per PR** — keeps reviews focused
- ✅ **Tests pass** — run local tests before pushing
- ✅ **Update docs** — if behavior changes, update README/comments
- ✅ **No credentials** — never commit `.env`, keys, tokens
- ✅ **Small, focused commits** — easier to review

### Development Setup

See the **Installation** section above for local setup. Most projects use:

```bash
# Python projects
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
# or pip install -e ".[dev]" for dev dependencies

# .NET projects
dotnet restore
dotnet build

# Docker projects
docker compose up -d --build
```

### Code Style

| Language | Formatter | Linter |
|----------|-----------|--------|
| Python | `black` | `ruff` |
| C# | `dotnet format` | Built-in |
| JavaScript/TypeScript | `prettier` | `eslint` |
| Blazor | `dotnet format` | Built-in |

Run formatters before committing:
```bash
# Python
black . && ruff check .

# .NET
dotnet format

# JS/TS (if applicable)
prettier --write .
```

### Reporting Security Issues

**Do not open public issues for security vulnerabilities.** Email directly or use GitHub's private vulnerability reporting.

### Community

- 💬 **Discussions**: Use GitHub Discussions for questions, ideas, RFCs
- 🐛 **Issues**: Bug reports, feature requests
- 📧 **Contact**: Open an issue for maintainer contact

### Recognition

Contributors are recognized in:
- GitHub Contributors graph
- Release notes (for significant contributions)
- `AUTHORS.md` or `CONTRIBUTORS.md` (if maintained)

---

**Thank you for contributing!** 🎉

---

## 📄 License

This project is licensed under the MIT License — see [LICENSE](LICENSE) for details.

MIT License allows:
- ✅ Commercial use
- ✅ Modification
- ✅ Distribution
- ✅ Private use
- ❌ No liability
- ❌ No warranty

---

## ⭐ Star History

If you find this project useful, please consider giving it a star! It helps with visibility and motivation.

## License

MIT
