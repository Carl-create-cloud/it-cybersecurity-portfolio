# IT and Cybersecurity Learning Portfolio

A computer science student's hands-on practice in troubleshooting, service operations, and authorized security assessment.

**Status:** project scaffolding created; practical work and findings are not yet completed. Target: three small, documented projects by November 20, 2026.

| Project | Problem to solve | Deliverable | Status |
| --- | --- | --- | --- |
| [01: Network troubleshooting](projects/01-network-troubleshooting/README.md) | A service cannot be reached: identify which layer fails | Small PowerShell diagnostic script and three troubleshooting tickets | Planned |
| [02: Local web-service recovery](projects/02-service-recovery/README.md) | A local website stops working or returns an error | Reproducible service setup, health check, recovery runbook | Planned |
| [03: Isolated security assessment](projects/03-security-assessment/README.md) | An owner needs to understand a lab machine's exposed services and one weakness | Scope, service inventory, one evidence-backed finding, remediation advice | Planned |

## Start here

1. Follow the [roadmap](docs/roadmap.md).
2. Learn the [documentation method](docs/documentation-guide.md).
3. Begin [Day 1](docs/day-01.md) and record actual observations.
4. Copy a [template](templates/session-note.md) into the relevant project's notes directory after each session.

## Evidence and honesty

Keep commands, observations, and interpretation separate. A planned exercise is not a completed project. Version banners are leads, not proof of exploitable vulnerabilities. Label simulations, untested recommendations, and AI assistance. Be able to explain every submitted script and finding.

Only test owned or explicitly authorized lab systems. Review evidence before committing; omit credentials, personal identifiers, VM images, and raw captures. Use `local-only/` for working evidence that must stay on the computer.

## Learning resources

- [Microsoft: Test-NetConnection](https://learn.microsoft.com/en-us/powershell/module/nettcpip/test-netconnection)
- [Python: http.server](https://docs.python.org/3/library/http.server.html)
- [Nmap reference guide](https://nmap.org/book/man.html)
- [GitHub: Markdown syntax](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)

This repository currently contains planning and templates prepared with AI assistance. Experiments, scripts, results, and learner explanations will be added as the work is performed.
