# Ticket 01: Local web service unavailable after stopping the server

Status: resolved in the practice exercise; learner explanation reviewed.

## Problem and expected behavior
A deliberately stopped practice web server no longer accepted TCP connections on port 8000. Expected running behavior: TCP connectivity and the practice webpage at http://127.0.0.1:8000.

## Environment and authorized scope
Owned Windows host, Windows PowerShell, Chrome, and Python 3.14.0 (version checked by assistant). Testing was restricted to loopback 127.0.0.1. The practice server served C:\Cybersecurity_RedTeam_Learning\lab-web. No VM or network configuration changes were needed.

## Hypotheses and tests
Evidence: [learner-provided observations](../notes/first-connection-check.md).

The learner ran this command in Windows PowerShell at each TCP check:

```powershell
Test-NetConnection -ComputerName 127.0.0.1 -Port 8000
```

| Step | Actual observation | Interpretation |
| --- | --- | --- |
| Initial baseline | TCP False; ping True | Port connection failed; baseline cause not independently established. |
| After server-start instruction | TCP True; expected page displayed | TCP endpoint accepted connections and the practice page was accessible. |
| After Ctrl+C stop instruction | TCP False; ping True | Consistent with the deliberately stopped service; ping did not establish service availability. |
| After restart instruction | TCP True; expected page displayed again | Connection and application recovery verified by learner-provided results. |

## Root cause
The controlled case is consistent with the practice server being stopped and therefore no longer accepting connections. Process state was not independently captured; failure of a TCP test alone does not prove a stopped process. The original baseline cause remains unverified.

## Fix, rollback, and verification
Restart procedure provided to the learner:

```powershell
python -m http.server 8000 --bind 127.0.0.1 --directory "C:\Cybersecurity_RedTeam_Learning\lab-web"
```

Following this instruction, the learner supplied a successful TCP test and reported the refreshed page text: "My local lab service works" and "Project 1 connection test."

Cleanup: press Ctrl+C in the server window when finished. Final cleanup has not been verified.

## Prevention, limitations, and lessons
Keep the practice server process running while testing. Binding to loopback limits this exercise to the same computer. Ping success does not prove a web service is available; TCP success does not prove the expected webpage is returned.

This was an intentional local failure simulation, not a production incident. Evidence consists of learner-supplied terminal output and browser observations, not independently collected process logs or HTTP status codes. It does not demonstrate external networking or DNS troubleshooting.

The learner associated the successful connection with the server listening on 8000 and distinguished TCP success from verifying the page in Chrome; see the project README. Documentation was prepared with AI assistance from the supplied results.
