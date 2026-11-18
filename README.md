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

| Project | Investigation focus | Planned output | Status |
| --- | --- | --- | --- |
| [01: Network troubleshooting](projects/01-network-troubleshooting/README.md) | A service cannot be reached: identify which layer fails | Small PowerShell diagnostic script and three troubleshooting tickets | Guided implementation complete; independent reproduction pending |
| [02: Local web-service recovery](projects/02-service-recovery/README.md) | A local website stops working or returns an error | Reproducible service setup, health check, recovery runbook | Guided implementation and assisted reproduction complete; limitations documented |
| [03: Isolated security assessment](projects/03-security-assessment/README.md) | An owner needs to understand a lab machine's exposed services and one weakness | Scope, service inventory, one evidence-backed finding, remediation advice | Assessment and report prepared; remediation unsuccessful; final explanation pending |

## Methodology

1. Define the question, scope, and expected behavior.
2. Record the environment, prerequisites, and tool versions.
3. Establish a baseline and change one condition at a time where practical.
4. Record commands and observations, separating measured results from interpretation.
5. Repeat relevant checks to evaluate recovery or confirm a finding.
6. Report conclusions, limitations, references, and remaining work.

These are educational lab investigations. Findings will apply to the tested configurations; they do not establish performance or security outcomes for production environments.

## Progress

**Current stage:** Project 01 guided implementation and acceptance checks complete, supported by learner-provided observations. Independent reproduction remains pending. Project 02 guided implementation and assisted reproduction are complete, with a report and documented limitations. Project 03 has a supported anonymous FTP finding and a completed investigation report; remediation was unsuccessful and final learner explanation remains pending.

**Target period:** November 1-20, 2026, with study sessions adapted to school workload. The [roadmap](docs/roadmap.md) records milestones and completion criteria.

**Next milestone:** review the Project 03 report and deliver a five-minute learner explanation. The broader [Day 1 environment inspection](docs/day-01.md) remains pending.

## Repository organization

| Location | Contents |
| --- | --- |
| `projects/` | Project objectives, procedures, acceptance criteria, and future results |
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

## Assistance disclosure

AI assistance was used to prepare project structure, scripts, and documentation. Results for all three projects are based on learner-supplied terminal output and browser observations. Generated text is not experimental evidence; independent reproduction remains pending.
