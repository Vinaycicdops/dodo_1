# Task 4 — Reconnaissance & Penetration Testing

## Part A: Passive Reconnaissance & Attack Surface Report

---

### 1. Executive Summary
The objective of this assessment was to identify and map the publicly exposed attack surface of `dodopayments.tech` using only **passive reconnaissance** techniques. All information was collected from public third-party sources and metadata exposed by the target's endpoints. 

In strict adherence to the Rules of Engagement (RoE), **no active scanning, automated vulnerability scanners, exploitation, directory brute forcing, or authenticated testing** was performed against any target infrastructure.

**Key Findings:**
* **Subdomain Discovery:** Passive enumeration identified **128 unique subdomains** associated with `dodopayments.tech`.
* **Live Host Validation:** Out of the 128 candidates, **50 live HTTP(S) endpoints** were validated as active.
* **Technology Fingerprinting:** Exposed systems include critical developer tools, workflow automation, databases, session replay, identity providers, and frontend applications.
* **Transport Layer Security:** The TLS configuration for the main endpoint received an **A+** grade, utilizing modern TLS 1.2/1.3 protocols, secure AEAD ciphers, and enforcing Perfect Forward Secrecy.

---

### 2. Scope & Rules of Engagement
* **Target Domain:** `dodopayments.tech`
* **Assessment Type:** Passive Reconnaissance (OSINT)
* **Out of Scope (Strictly Forbidden):** Active exploitation, login brute forcing, directory fuzzing, API fuzzing, automated vulnerability scanning (e.g., Nessus, Nikto), and any testing against `dodopayments.com` or third-party services.
* **Testing Window:** July 31, 2026

---

### 3. Methodology & Tools Used
The passive reconnaissance workflow was executed in sequential stages to ensure comprehensive coverage without interacting directly with the target server in an intrusive manner.

| Phase | Tool | Description / Purpose | Command/Source Used |
| :--- | :--- | :--- | :--- |
| **Subdomain Enumeration** | `crt.sh` | Queries public Certificate Transparency (CT) logs | HTTPS search for `%.dodopayments.tech` |
| **Subdomain Enumeration** | `subfinder` | Passive subdomain discovery via public APIs | `subfinder -d dodopayments.tech -silent` |
| **Subdomain Enumeration** | `assetfinder` | Finds subdomains using public datasets | `assetfinder --subs-only dodopayments.tech` |
| **Subdomain Enumeration** | `amass` | Passive network intelligence aggregation | `amass enum -passive -d dodopayments.tech` |
| **Live Host Validation** | `httpx` | Verifies host reachability, HTTP response codes, and headers | `cat all_subdomains.txt \| httpx -silent -title -status-code -tech-detect -follow-redirects` |
| **TLS Posture Review** | `testssl.sh` | Evaluates transport layer security strength and vulnerabilities | `./testssl.sh https://dodopayments.com` |

---

### 4. Public Asset Inventory
From the **128 unique subdomains** discovered during passive enumeration, **50 live HTTP(S) endpoints** were identified. Below is the categorized inventory of these live assets:

#### A. Main Website & Marketing Frontends
These endpoints host the public-facing brand pages and documentation.
* `https://dodopayments.tech` (Status: 200 | Title: *Billing & Payments Platform for AI-First Companies*) — Tech: Astro (5.18.0), Cloudflare.
* `https://www.dodopayments.tech` (Status: 200 | Title: *Billing & Payments Platform for AI-First Companies*) — Tech: Astro (5.18.0), Cloudflare.
* `https://website.dodopayments.tech` (Status: 200 | Title: *Billing & Payments Platform for AI-First Companies*) — Tech: Astro (5.18.0), Cloudflare.

#### B. Core Application & Customer Portals
The primary application interface and customer checkout systems.
* `https://app.dodopayments.tech` (Status: 200 | Title: *Dodo Payments*) — Tech: Next.js, React, Node.js, Cloudflare, Webpack.
* `https://checkout.dodopayments.tech` (Status: 404 | Title: *Dodo Payments*) — Tech: Next.js, React, Node.js, Vercel, Webpack.
* `https://test.checkout.dodopayments.tech` (Status: 404 | Title: *Dodo Payments*) — Tech: Next.js, React, Node.js, Vercel, Webpack.
* `https://customer.dodopayments.tech` (Status: 429) — Vercel Security Checkpoint.
* `https://partners.dodopayments.tech` (Status: 429) — Vercel Security Checkpoint.
* `https://test.customer.dodopayments.tech` (Status: 429) — Vercel Security Checkpoint.
* `https://www.customer.dodopayments.tech` (Status: 429) — Vercel Security Checkpoint.
* `https://www.test.customer.dodopayments.tech` (Status: 429) — Vercel Security Checkpoint.
* `https://www.partners.dodopayments.tech` (Status: 429) — Vercel Security Checkpoint.

#### C. Identity & Access Management (IAM)
* `https://keycloak.dodopayments.tech` (Status: 200 | Title: *Keycloak Administration Console*) — Tech: Keycloak, Cloudflare, HSTS.

#### D. Software Development & CI/CD Tooling
* `https://sonarqube.dodopayments.tech` (Status: 200 | Title: *SonarQube*) — Tech: SonarQube, Java, Cloudflare, HSTS.
* `https://codecov.dodopayments.tech` (Status: 200 | Title: *Codecov*) — Tech: Codecov, Cloudflare, HSTS.

#### E. Analytics & Databases
* `https://pinacolada.dodopayments.tech` (Status: 200 | Title: *Plausible · Simple, privacy-friendly alternative to Google Analytics*) — Tech: Plausible, Cloudflare, HSTS.
* `https://mb.dodopayments.tech` (Status: 200 | Title: *Metabase*) — Tech: Metabase, Cloudflare, HSTS.
* `https://clickhouse-dev-v2.dodopayments.tech` (Status: 200 | Title: *ClickHouse*) — Tech: ClickHouse HTTP Interface, Cloudflare, HSTS.
* `https://clickhouse-prod-v2.dodopayments.tech` (Status: 200 | Title: *ClickHouse*) — Tech: ClickHouse HTTP Interface, Cloudflare, HSTS.

#### F. Monitoring & Session Replay
* `https://ozone.dodopayments.tech` (Status: 200 | Title: *OpenReplay*) — Tech: OpenReplay, Envoy, Cloudflare.

#### G. Workflow Automation & Synchronization
* `https://n8n.dodopayments.tech` (Status: 200 | Title: *n8n.io - Workflow Automation*) — Tech: n8n, Cloudflare, HSTS.
* `https://sequin.dodopayments.tech` (Status: 200 | Title: *Sequin*) — Tech: Sequin, Cloudflare, HSTS.
* `https://sequindev.dodopayments.tech` (Status: 200 | Title: *Sequin*) — Tech: Sequin, Cloudflare, HSTS.

#### H. E-commerce Frontends & Stores
* `https://store.dodopayments.tech` (Status: 200 | Title: *Login – Vercel*) — Tech: React, Vercel, RxJS.
* `https://test.store.dodopayments.tech` (Status: 200 | Title: *Login – Vercel*) — Tech: React, Vercel, RxJS.
* `https://www.store.dodopayments.tech` (Status: 200 | Title: *Login – Vercel*) — Tech: React, Vercel, RxJS.
* `https://www.test.store.dodopayments.tech` (Status: 200 | Title: *Login – Vercel*) — Tech: React, Vercel, RxJS.

#### I. Internal Services & Sentinel Platforms
* `https://sentinal.dodopayments.tech` (Status: 200 | Title: *Dodo Sentinel*) — Tech: Next.js, React, Node.js, Webpack, Cloudflare.
* `https://squirrels.dodopayments.tech` (Status: 200 | Title: *Squirrels*) — Tech: Next.js, React, Node.js, Webpack, Cloudflare.
* `https://sentinal-v2.dodopayments.tech` (Status: 200 | Title: *Login – Vercel*) — Tech: React, Vercel, RxJS.
* `https://internal.dodopayments.tech` (Status: 403 | Title: *403 Forbidden - Dodo Payments*) — Tech: Cloudflare.

#### J. APIs, Proxies, and Error-state Endpoints
* `https://ai-proxy.dodopayments.tech` (Status: 401)
* `https://ssr-proxy.dodopayments.tech` (Status: 401)
* `https://chimely.dodopayments.tech` (Status: 200 | Title: *Chimely admin*) — Tech: Envoy proxy, Cloudflare.
* `https://partner-api.dodopayments.tech` (Status: 404) — Tech: Envoy proxy, Cloudflare.
* `https://sentra-server.dodopayments.tech` (Status: 404)
* `https://sentra-mcp-worker.dodopayments.tech` (Status: 404)
* `https://signoz-mcp.dodopayments.tech` (Status: 404 | Title: *404 Not Found*)
* `https://usesend-ses.dodopayments.tech` (Status: 404 | Title: *404 Not Found*)
* `https://wsserver.dodopayments.tech` (Status: 200)
* `https://live.dodopayments.tech` (Status: 403 | Title: *403 Forbidden - Dodo Payments*)
* `https://test.dodopayments.tech` (Status: 403 | Title: *403 Forbidden - Dodo Payments*)
* `https://dev.dodopayments.tech` (Status: 525) — SSL Handshake Failure.
* `https://events-dev.dodopayments.tech` (Status: 503) — Google Cloud CDN.
* `https://app-plunk-v2.dodopayments.tech` / `https://docs-plunk-v2.dodopayments.tech` / `https://api-plunk-v2.dodopayments.tech` / `https://plunk-v2.dodopayments.tech` / `https://sentry.dodopayments.tech` (Status: 403) — Cloudflare Attention Required.

---

### 5. Technology Inventory
From HTTP headers, SSL certificates, and technology detection signatures (`httpx`, `whatweb`), the following technology mapping represents the external stack:

| Technology | Domain/Usage | Purpose |
| :--- | :--- | :--- |
| **Cloudflare** | Edge infrastructure across most subdomains | Content Delivery Network (CDN) & Web Application Firewall (WAF) |
| **Vercel** | `customer.dodopayments.tech`, `store.dodopayments.tech` | Hosting platform for modern frontend applications |
| **Astro** (5.18.0) | `website.dodopayments.tech` | Static marketing site generation |
| **Next.js / React** | `app.dodopayments.tech`, `checkout.dodopayments.tech` | Server-side rendering & single page application framework |
| **Envoy** | `chimely.dodopayments.tech`, `partner-api.dodopayments.tech` | High-performance edge/service proxy |
| **Keycloak** | `keycloak.dodopayments.tech` | Identity Provider (IdP) for SSO and User Authentication |
| **SonarQube** | `sonarqube.dodopayments.tech` | Static Application Security Testing (SAST) & Code Quality |
| **n8n** | `n8n.dodopayments.tech` | Workflow Automation Platform |
| **Metabase** | `mb.dodopayments.tech` | Business Intelligence & Data Analytics Visualization |
| **ClickHouse** | `clickhouse-dev-v2.dodopayments.tech`, etc. | Column-oriented OLAP Database Management System |
| **OpenReplay** | `ozone.dodopayments.tech` | Session Replay & Frontend Monitoring |
| **Sequin** | `sequin.dodopayments.tech` | Real-time database streams & message queues synchronization |

---

### 6. TLS Security Assessment
A comprehensive analysis of transport layer security (TLS) configurations was performed on the primary endpoint using `testssl.sh`. 

#### Protocol Support
The server strictly disables obsolete, vulnerable cryptographic protocols, supporting only modern variants:
* **SSLv2 / SSLv3 / TLS 1.0 / TLS 1.1:** Disabled (Not Supported)
* **TLS 1.2:** Supported
* **TLS 1.3:** Supported

#### Cipher Suites & Forward Secrecy
Only modern Authenticated Encryption with Associated Data (AEAD) cipher suites are enabled. Cryptographically weak ciphers (RC4, 3DES, DES, NULL) are completely disabled.
* **Key exchange PFS mechanisms:** Enabled via curves X25519, P-256, P-384, and P-521.
* **Post-quantum resilience:** Hybrid post-quantum key exchange `X25519MLKEM768` is advertised.
* **Server-preferred ordering:** Enforced on TLS 1.2.

#### Vulnerability Assessment
The server is validated against common TLS implementation flaws:
* **Not Vulnerable to:** Heartbleed, CCS Injection, Ticketbleed, ROBOT, CRIME, POODLE, FREAK, DROWN, LOGJAM, BEAST, LUCKY13, SWEET32.
* **BREACH Consideration:** HTTP Gzip compression is enabled. While this is standard, it presents a minor threat vector under specific conditions where secrets are compressed within responses.

#### Overall Grade: A+
The configuration meets top-tier security standards, indicating robust transport security.

---

### 7. Publicly Exposed Services & Risk Observations
Without claiming specific vulnerabilities (in line with passive recon limits), the exposure of these administrative and operational platforms increases the potential attack surface:

* **Keycloak (`keycloak.dodopayments.tech`)**
  * *Context:* Serves as the central identity provider.
  * *Risk Observation:* Any misconfiguration or unpatched software vulnerability on an identity manager represents a single point of failure for authentication. It is a high-value target for credential stuffing, phishing, and denial of service.
* **SonarQube (`sonarqube.dodopayments.tech`)**
  * *Context:* Contains source code quality reports and vulnerability scans.
  * *Risk Observation:* If public access is misconfigured, it could leak source code structures, proprietary business logic, or hardcoded secrets.
* **Metabase (`mb.dodopayments.tech`)**
  * *Context:* A Business Intelligence dashboard connected to internal data stores.
  * *Risk Observation:* Exposing a BI platform to the public internet presents a risk of sensitive financial or customer data exposure in the event of access control bypasses or credential compromise.
* **n8n (`n8n.dodopayments.tech`)**
  * *Context:* Workflow engine running custom scripts and integrations with write access to external APIs.
  * *Risk Observation:* Compromising a workflow engine can grant attackers arbitrary command execution or access to external third-party API credentials stored within workflow configs.
* **ClickHouse HTTP Interfaces (`clickhouse-prod-v2.dodopayments.tech` / `clickhouse-dev-v2.dodopayments.tech`)**
  * *Context:* Columnar database HTTP ports.
  * *Risk Observation:* Exposing raw database HTTP endpoints to the public increases the likelihood of SQL injection attempts, brute force attacks, or database discovery.
* **OpenReplay (`ozone.dodopayments.tech`)**
  * *Context:* Session replay platform tracking customer UI interactions.
  * *Risk Observation:* Session replays can contain sensitive Personally Identifiable Information (PII) or credit card details if not properly masked, making this console highly attractive to attackers.
* **Sequin (`sequin.dodopayments.tech`)**
  * *Context:* Database synchronization.
  * *Risk Observation:* Synchronization pipelines can contain active API keys and DB connection strings, representing a major risk if accessed.

---

### 8. Security Recommendations
Based on the passive reconnaissance findings, the following defensive actions are recommended for review:
1. **IP Whitelisting & VPN/Zero-Trust Access:** Restrict public access to administrative portals (SonarQube, Metabase, n8n, Keycloak Admin Console, ClickHouse, Sequin) by placing them behind an internal VPN (e.g., WireGuard, Tailscale) or zero-trust access tunnels (e.g., Cloudflare Access).
2. **Access Control Audit:** Conduct a configuration audit on public administrative endpoints to guarantee that anonymous read access is disabled.
3. **MFA Enforcements:** Mandate Multi-Factor Authentication (MFA) across all identity services, specifically Keycloak and n8n consoles.
4. **Evaluate BREACH Risk:** Assess if HTTP response compression on endpoints handles sensitive dynamic data (e.g. CSRF tokens, session IDs) combined with user-controlled input in the same request.

---

### 9. Conclusion
The passive reconnaissance phase reveals a modern, mature public infrastructure. Strong transport encryption (TLS A+) and Cloudflare edge protection are active across the perimeter. However, several high-value administrative, database, and orchestration services are exposed to the public internet. Moving these behind a secure perimeter (Zero-Trust/VPN) will significantly shrink the externally visible attack surface before active pen-testing begins.

---

## Part B: Penetration Test (Authorized Target)

> [!IMPORTANT]
> This section is a placeholder for the active penetration testing results against the local `ledger-api` instance running at `http://localhost:8080`.

### 1. Executive Summary
*To be completed with a summary of the penetration testing findings.*

### 2. Scope & Methodology
* **Target Endpoint:** `http://localhost:8080` (Local `ledger-api` container)
* **Testing Scope:** OWASP Top 10 vulnerabilities (Injection, Broken Authentication, Sensitive Data Exposure, XML External Entities (XXE), Broken Access Control, Security Misconfiguration, Cross-Site Scripting (XSS), Insecure Deserialization, Using Components with Known Vulnerabilities, Insufficient Logging & Monitoring).
* **Tools Permitted:** Burp Suite Community, OWASP ZAP, nuclei, ffuf, sqlmap.
* **Testing Methodology Flow:**
  ```
  Reconnaissance
        ↓
  Endpoint Enumeration (ffuf)
        ↓
  HTTP Method Enumeration
        ↓
  Input Discovery
        ↓
  Behavioral Testing
        ↓
  OWASP Category Validation
        ↓
  White-box Verification
        ↓
  Risk Assessment
  ```

#### Initial Reconnaissance & Observation Log
| Endpoint | Method | Result | Observation |
| :--- | :--- | :--- | :--- |
| `/` | GET | 404 | No landing page. API-only application. |
| `/health` | GET | 200 | Health endpoint exposed. Normal behavior. |
| `/transactions` | GET | 200 | Returns transaction data without any authentication (exposing full PAN). |

### 3. Vulnerability Findings
| ID | Finding | Severity | Affected Endpoint | Status |
| :--- | :--- | :--- | :--- | :--- |
| **SEC-01** | Sensitive Data Exposure (Plaintext PAN Exchanged) | High | `/transactions` | Open |
| **SEC-02** | Security Misconfiguration (Information Disclosure via Server Headers) | Informational | All Endpoints | Open |
| **SEC-03** | Security Misconfiguration (Missing HTTP Security Headers) | Informational | All Endpoints | Open |

---

#### SEC-01: Sensitive Data Exposure (Plaintext PAN Exchanged)
* **Description:** The `/transactions` endpoint returns the transaction history ledger including sensitive credit card PANs (Primary Account Numbers) in cleartext. It does not require any authentication (API key, Bearer token, session cookie, etc.) to access.
  * *Note: Further investigation is required to establish whether this endpoint is intended to be public or if it represents an access control policy failure. A final conclusion on Broken Access Control is pending additional evidence.*
* **Affected Endpoint:** `http://localhost:8080/transactions`
* **Severity:** High (CVSS v3.1 Vector: `CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N` | Score: 7.5)
* **Reproduction Steps / PoC:**
  Request:
  ```http
  GET /transactions HTTP/1.1
  Host: localhost:8080
  Accept: */*
  ```
  Response:
  ```http
  HTTP/1.0 200 OK
  Content-Type: application/json
  Content-Length: 324
  Server: Werkzeug/0.14.1 Python/3.6.15
  Date: Fri, 31 Jul 2026 11:06:31 GMT

  {
    "transactions": [
      {
        "amount": 4200, 
        "currency": "USD", 
        "id": "txn_1001", 
        "pan": "4242424242424242", 
        "status": "captured"
      }, 
      {
        "amount": 1899, 
        "currency": "EUR", 
        "id": "txn_1002", 
        "pan": "5555555555554444", 
        "status": "refunded"
      }
    ]
  }
  ```
* **Impact:** 
  1. **Exposure of Sensitive Data (PAN):** Exposing the full Primary Account Number (PAN) increases the risk of fraud and card details misuse.
  2. **PCI DSS Compliance Failure:** Violates PCI DSS requirements, specifically Requirement 3.4 (rendering PAN unreadable anywhere it is stored or transmitted) and Requirement 8.1 (identifying and authenticating access to system components).
* **Remediation:** 
  1. **Access Control:** Enforce strong authentication (such as JWT tokens, API keys, or Session Cookies) on the `/transactions` endpoint.
  2. **Data Masking:** Mask cardholder data so that only the last 4 digits are returned (e.g., `XXXXXXXXXXXX4242`), unless there is a specific, authenticated business need to view the full PAN.

---

#### SEC-02: Security Misconfiguration (Information Disclosure via Server Headers)
* **Description:** The application server includes the `Server` header in HTTP responses, exposing the specific versions of the web server framework (`Werkzeug/0.14.1`) and the programming language runtime (`Python/3.6.15`).
* **Affected Endpoint:** All endpoints (`/`, `/health`, `/transactions`)
* **Severity:** Informational (CVSS v3.1 Vector: `CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N` | Score: 5.3)
* **Reproduction Steps / PoC:**
  Request:
  ```http
  GET /health HTTP/1.1
  Host: localhost:8080
  ```
  Response Headers:
  ```http
  HTTP/1.0 200 OK
  Content-Type: application/json
  Content-Length: 21
  Server: Werkzeug/0.14.1 Python/3.6.15
  ```
* **Impact:** Verbose server banners assist attackers in mapping out the exact technology stack of the application and identifying known CVEs or exploits targetable against those specific version ranges.
* **Remediation:** Configure the WSGI application or reverse proxy/ingress controller to strip or generalize the `Server` header (e.g. returning a generic name or disabling the header emission entirely).

---

#### SEC-03: Security Misconfiguration (Missing HTTP Security Headers)
* **Description:** The web server does not configure standard security-related HTTP headers that prevent browser-based attacks and enforce secure communication profiles.
* **Affected Endpoint:** All endpoints (`/`, `/health`, `/transactions`)
* **Severity:** Informational (CVSS v3.1 Vector: `CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:L/A:N` | Score: 3.7)
* **Missing Headers:**
  - `X-Content-Type-Options` (e.g., `nosniff` to prevent MIME-type sniffing)
  - `Content-Security-Policy` (to restrict resource execution environments)
  - `Strict-Transport-Security` (HSTS - to enforce SSL/TLS connections)
  - `X-Frame-Options` (to prevent Clickjacking)
  - `Referrer-Policy` (to control referrer leakage)
  - `Permissions-Policy` (to restrict hardware/browser api usage)
* **Impact:** Although APIs are primarily designed for programmatic integration, browser-based tools or client-side web clients connecting directly to these endpoints lack default browser security hardening, elevating risks such as content spoofing or framing.
* **Remediation:** Add middleware (e.g. using `flask-talisman` or custom response headers injection logic) or configure the cluster's ingress controller to append security headers to all responses.

---

### 4. Remediation & Retest Log
*To be updated once remediation controls are implemented and verified.*



I would split this into **two findings**. One is based on **black-box evidence**, and the second is **white-box validation** of the implementation.

---

# Finding 4: Insufficient Input Validation and Error Handling in `/tokenize`

**Severity:** Medium

## Summary

During testing of the `/tokenize` endpoint, the application accepted malformed and unexpected inputs without validation, generated tokens for arbitrary values, and returned unhandled server errors for invalid data types. The endpoint lacks proper input validation and robust error handling.

---

# Discovery Methodology

## Step 1 – Method Discovery

The endpoint was tested with a GET request.

```bash
curl -i http://localhost:8080/tokenize
```

Response:

```http
405 Method Not Allowed
Allow: POST
```

The endpoint accepts only POST requests.

---

## Step 2 – Valid Request

A valid PAN was submitted.

```bash
curl -X POST \
-H "Content-Type: application/json" \
-d '{"pan":"4242424242424242"}'
```

Response:

```json
{
  "last4": "4242",
  "token": "tok_477bba133c182267fe5f0869"
}
```

The endpoint generated a token and returned the last four digits of the supplied PAN.

---

## Step 3 – Deterministic Behavior

The same request was submitted multiple times.

Result:

```text
4242424242424242
↓

tok_477bba133c182267fe5f0869

(repeated)

↓

tok_477bba133c182267fe5f0869
```

Observation:

The endpoint consistently produces the same token for identical input.

---

## Step 4 – Input Validation Testing

### Arbitrary String

```json
{
  "pan":"abc"
}
```

Response:

```json
{
  "last4":"abc",
  "token":"tok_ba7816bf8f01cfea414140de"
}
```

Observation:

The endpoint accepts arbitrary strings instead of validating that the input is a payment card number.

---

### Empty String

```json
{
  "pan":""
}
```

Response:

```json
{
  "last4":"",
  "token":"tok_e3b0c44298fc1c149afbf4c8"
}
```

Observation:

Empty input is accepted and tokenized.

---

### Excessively Long Input

```json
{
  "pan":"1234567890123456789012345678901234567890"
}
```

Response:

```json
{
  "last4":"7890",
  "token":"tok_a4ebdd541454b84cc670c9f1"
}
```

Observation:

No length validation is performed.

---

### Input Normalization

Formatted PAN:

```text
4242 4242 4242 4242
```

Generated a different token from:

```text
4242424242424242
```

Likewise:

```text
 4242424242424242
```

produced yet another token.

Observation:

Equivalent PAN values are processed differently because whitespace and formatting characters are not normalized before token generation.

---

## Step 5 – Error Handling

### Null Input

```json
{
  "pan": null
}
```

Result:

```http
500 Internal Server Error
```

---

### Numeric JSON Value

```json
{
  "pan":4242424242424242
}
```

Result:

```http
500 Internal Server Error
```

Observation:

Unexpected input types cause unhandled exceptions instead of returning a client validation error.

---

# Impact

The endpoint does not validate input before processing and lacks robust error handling.

This may result in:

* Processing of invalid data.
* Inconsistent token generation for equivalent PAN values.
* Unexpected server exceptions.
* Reduced reliability and maintainability of the service.

---

# Evidence Summary

| Test                 | Result                    |
| -------------------- | ------------------------- |
| Missing PAN          | Token generated           |
| Empty PAN            | Token generated           |
| Arbitrary string     | Token generated           |
| Long input           | Token generated           |
| Different formatting | Different tokens          |
| Null value           | 500 Internal Server Error |
| Numeric value        | 500 Internal Server Error |

---

# Recommendation

* Validate that `pan` is present before processing.
* Accept only string input.
* Normalize PAN values (e.g., trim whitespace and remove formatting characters) before tokenization.
* Validate PAN length and format.
* Return `400 Bad Request` for invalid requests instead of `500 Internal Server Error`.

---

# Finding 5: Weak Tokenization Implementation (White-box Validation)

**Severity:** Medium

## Summary

Source code review confirmed that the application generates tokens by computing a deterministic SHA-256 hash of the supplied PAN and truncating the result. This is a hashing mechanism rather than a secure tokenization implementation.

---

## White-box Validation

Code review identified logic equivalent to:

```python
token = sha256(pan).hexdigest()[:24]
```

This implementation:

* Generates identical tokens for identical PANs.
* Uses no secret key or salt.
* Does not implement reversible or vault-backed tokenization.

---

## Black-box Evidence

Behavior observed during testing supported this implementation:

* Repeated requests using the same PAN produced identical tokens.
* Different PANs consistently produced different deterministic tokens.

---

## Impact

A deterministic unsalted hash is not a substitute for secure payment tokenization. If the algorithm is known, identical PANs will always map to identical tokens, enabling correlation of repeated values. Proper tokenization typically relies on a secure token vault or a keyed cryptographic mechanism rather than a plain hash.

---

## Recommendation

Replace the hash-based approach with a dedicated tokenization mechanism, such as:

* A vault-backed random token mapped to the original PAN.
* A keyed cryptographic construction (e.g., HMAC) if deterministic behavior is required.
* A tokenization service designed for handling payment card data.

---

This separation is how many professional assessments are written:

* **Finding 4** is supported entirely by **black-box testing**.
* **Finding 5** is confirmed through **white-box review**, avoiding claims about the cryptographic implementation that couldn't be proven from runtime behavior alone.


These are **not vulnerabilities**, so they shouldn't appear under the **Findings** section. Instead, they belong in the **Methodology**, **Testing Summary**, and **Positive Security Observations** sections of a professional penetration test report.

Here's how I'd write them.

---

# 3. Methodology

The assessment combined automated and manual testing techniques to evaluate the application against the OWASP Top 10.

### Tools Used

* Burp Suite Community Edition *(optional if you use it later)*
* `ffuf` for endpoint enumeration
* `curl` for manual HTTP request crafting and verification
* `sqlmap` for automated SQL injection testing
* `nuclei` (v3.11.0, community templates v10.4.6) for signature-based vulnerability detection

### Testing Approach

1. Enumerated exposed endpoints using `ffuf`.
2. Identified supported HTTP methods and input parameters.
3. Performed manual testing for OWASP Top 10 vulnerabilities, including SSRF, injection, sensitive data exposure, unsafe deserialization, and security misconfiguration.
4. Used automated scanners (`sqlmap` and `nuclei`) to supplement manual testing.
5. Validated selected findings through white-box source code review where applicable.

---

# 4. Security Testing Summary

## SQL Injection Testing

Automated SQL injection testing was performed using **sqlmap** against the `/transactions` endpoint.

The `id` parameter was identified and tested for boolean-based, error-based, time-based, stacked query, and UNION-based SQL injection techniques.

### Result

No SQL injection vulnerabilities were identified.

Key observations from `sqlmap`:

* The `id` parameter was determined to be non-dynamic.
* No injectable behavior was detected.
* No database errors or SQL execution indicators were observed.

**Conclusion**

No evidence of SQL Injection was identified during the assessment.

---

## Cross-Site Scripting (XSS)

Manual testing was performed by supplying script payloads to user-controlled input parameters.

Example payload:

```html
<script>alert(1)</script>
```

The payload did not execute or appear in any HTML response.

The tested endpoint (`/fetch`) returns JSON responses rather than rendering user-controlled input into HTML pages.

**Conclusion**

No reflected Cross-Site Scripting vulnerabilities were identified during testing.

---

## Nuclei Scan

An automated scan was performed using **Nuclei v3.11.0** with the latest community template set (v10.4.6).

### Result

No template-based vulnerabilities were detected.

**Observation**

The application's primary weaknesses were application-specific business logic and implementation flaws (such as SSRF, sensitive data exposure, and unsafe deserialization), which are not generally detectable through signature-based scanning alone.

---

# Low Severity Finding

## Finding: Security Misconfiguration – Missing Security Headers and Server Version Disclosure

**Severity:** Low

**CVSS v3.1:** **3.7 (Low)**

**Vector:** `CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N`

**OWASP Category:** A05 – Security Misconfiguration

---

### Affected Endpoint

```
GET /health
```

---

### Description

The application exposes the underlying web server and runtime version through the `Server` response header and does not include several commonly recommended HTTP security headers.

Observed response:

```http
HTTP/1.0 200 OK
Content-Type: application/json
Server: Werkzeug/0.14.1 Python/3.6.15
```

Missing security headers include:

* `Content-Security-Policy`
* `X-Frame-Options`
* `X-Content-Type-Options`
* `Referrer-Policy`
* `Strict-Transport-Security`

---

### Reproduction Steps

```bash
curl -I http://localhost:8080/health
```

Observe the response headers.

---

### Impact

Although the absence of these headers does not directly expose the application to compromise, it weakens the application's overall security posture by:

* Revealing software and runtime versions that may assist attackers during reconnaissance.
* Missing browser-side protections against clickjacking, MIME-type confusion, and other client-side attacks.
* Reducing defense-in-depth for future application changes.

---

### Recommendation

* Remove or minimize the `Server` header where possible.
* Configure the application or reverse proxy to include appropriate security headers, including:

  * `Content-Security-Policy`
  * `X-Frame-Options`
  * `X-Content-Type-Options`
  * `Referrer-Policy`
  * `Strict-Transport-Security` (when served over HTTPS)

---

This structure is closer to what you'd see in reports from consulting firms like NCC Group, Bishop Fox, or NetSPI: **actual vulnerabilities** are presented as findings, while **tests that found no issues** (e.g., SQLi, XSS, Nuclei) are documented in the methodology or testing summary to demonstrate assessment coverage rather than being reported as vulnerabilities.
