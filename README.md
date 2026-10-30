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

## License

MIT
