# IT and Cybersecurity Lab Portfolio

## Overview

This repository documents three beginner-level technical projects in network diagnostics, service recovery, and isolated security assessment. Each project follows a structured process: define a problem, establish a test environment, collect evidence, evaluate the results, and document limitations.

The portfolio supports preparation for IT support, networking, and cybersecurity internships, with a longer-term focus on authorized offensive security and red teaming.

## Objectives

- Develop practical troubleshooting skills using PowerShell, Linux, and basic networking concepts.
- Distinguish name-resolution, connection, and application failures through controlled tests.
- Document security observations with evidence, appropriate validation, and remediation guidance.
- Produce reproducible technical reports that communicate both findings and uncertainty.

## Project index

| Project | Investigation focus | Deliverables | Status |
| --- | --- | --- | --- |
| [01: Network troubleshooting](projects/01-network-troubleshooting/README.md) | A service cannot be reached: identify which layer fails | Small PowerShell diagnostic script and three troubleshooting tickets | Completed with guidance |
| [02: Local web-service recovery](projects/02-service-recovery/README.md) | A local website stops working or returns an error | Reproducible service setup, health check, recovery runbook | Completed with guidance |
| [03: Isolated security assessment](projects/03-security-assessment/README.md) | An owner needs to understand a lab machine's exposed services and one weakness | Scope, service inventory, one evidence-backed finding, remediation advice | Completed with guidance |

## Review the work

- [Network troubleshooting report](projects/01-network-troubleshooting/report.md) and [diagnostic script](projects/01-network-troubleshooting/scripts/Test-LabConnection.ps1).
- [Service recovery report](projects/02-service-recovery/report.md), [runbook](projects/02-service-recovery/runbook.md), and [health-check script](projects/02-service-recovery/scripts/Test-LabHttp.ps1).
- [Security assessment report](projects/03-security-assessment/report.md) and [anonymous FTP finding](projects/03-security-assessment/finding-anonymous-ftp.md).
- [CTF experience](activities/packet-capture-ctf.md): solved OSINT and web challenges, separate from the three lab projects.

## Methodology

1. Define the question, scope, and expected behavior.
2. Record the environment, prerequisites, and tool versions.
3. Establish a baseline and change one condition at a time where practical.
4. Record commands and observations, separating measured results from interpretation.
5. Repeat relevant checks to evaluate recovery or confirm a finding.
6. Report conclusions, limitations, references, and remaining work.

These are educational lab investigations. Findings will apply to the tested configurations; they do not establish performance or security outcomes for production environments.

## Progress

**Current stage:** All three scoped projects completed with guidance. Results and limitations are documented.

## Repository organization

| Location | Contents |
| --- | --- |
| `projects/` | Project objectives, procedures, acceptance criteria, and results |
| `docs/` | Schedule, learning exercises, and documentation guidance |
| `templates/` | Session record, troubleshooting ticket, security finding, and technical report templates |
| `local-only/` | Ignored local working evidence; not uploaded to GitHub |

Start with the [documentation guide](docs/documentation-guide.md). Use the [technical report template](templates/technical-report.md) for project reports and the [session record](templates/session-note.md) for daily observations.

## Scope and evidence handling

Testing is restricted to owned or explicitly authorized lab systems. Vulnerable virtual machines require verified network isolation before assessment. Submitted evidence must exclude credentials, personal information, and unrelated system data. Virtual machine images and raw private evidence remain outside version control.

## References

- [Microsoft: Test-NetConnection](https://learn.microsoft.com/en-us/powershell/module/nettcpip/test-netconnection)
- [Python: http.server](https://docs.python.org/3/library/http.server.html)
- [Nmap reference guide](https://nmap.org/book/man.html)
- [GitHub: Markdown syntax](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)

## AI assistance

I used AI to help structure the projects, develop scripts, explain commands, and review documentation. I ran the lab exercises and supplied the test results. Reports distinguish observed results from recommendations and untested assumptions.
