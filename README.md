# Learning IT and cybersecurity

I'm a third-year computer science student learning networking, troubleshooting, and cybersecurity. I'm interested in red teaming, and I'm also looking at IT internships where I can build practical experience.

I've used PowerShell and the Linux terminal a little, but I'm still getting comfortable with commands. I already have Kali Linux in VirtualBox. This repo is where I'll keep three small projects, the problems I run into, and what I learn while fixing them.

**Right now:** the plan and note templates are ready. I haven't completed the practical exercises yet. My target is November 20, 2026, studying about four hours a day.

| Project | What I want to figure out | What I'll make | Status |
| --- | --- | --- | --- |
| [01: Network troubleshooting](projects/01-network-troubleshooting/README.md) | A service cannot be reached: identify which layer fails | Small PowerShell diagnostic script and three troubleshooting tickets | Planned |
| [02: Local web-service recovery](projects/02-service-recovery/README.md) | A local website stops working or returns an error | Reproducible service setup, health check, recovery runbook | Planned |
| [03: Isolated security assessment](projects/03-security-assessment/README.md) | An owner needs to understand a lab machine's exposed services and one weakness | Scope, service inventory, one evidence-backed finding, remediation advice | Planned |

## Where I'm starting

1. Follow the [roadmap](docs/roadmap.md).
2. Learn the [documentation method](docs/documentation-guide.md).
3. Begin [Day 1](docs/day-01.md) and record actual observations.
4. Copy a [template](templates/session-note.md) into the relevant project's notes directory after each session.

## How I'll keep notes

For each exercise, I'll write down what I tried, what happened, and why I think it happened. If something doesn't work, that belongs in the notes too. I'll add results as I do the work and keep unfinished steps marked as unfinished.

Security testing will stay inside my own lab or an explicitly authorized setup. Private working files go in `local-only/`; passwords, personal information, and VM images don't belong in this repo.

## Learning resources

- [Microsoft: Test-NetConnection](https://learn.microsoft.com/en-us/powershell/module/nettcpip/test-netconnection)
- [Python: http.server](https://docs.python.org/3/library/http.server.html)
- [Nmap reference guide](https://nmap.org/book/man.html)
- [GitHub: Markdown syntax](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)

I used AI to help organize the initial plan and templates. As I work through the projects, I'll add my own observations and explanations of the results.
