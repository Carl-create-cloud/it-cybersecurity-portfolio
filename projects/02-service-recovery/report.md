# Local HTTP service diagnosis and recovery

Status: guided implementation and assisted reproduction complete; report reviewed against supplied evidence.

Dates: November 9 and 11, 2026.

## Objective and scope

Determine how a healthy page, a missing resource, and a stopped local service differ, and verify the appropriate recovery action. The experiment used Windows PowerShell, learner-verified Python 3.14.0, a dedicated static sample page, and the owned loopback endpoint 127.0.0.1:8000. No external systems or virtual machines were tested. The PowerShell version was not recorded.

## Methodology

The learner followed the [runbook](runbook.md) using separate Server and Check windows. Python served the project sample-site directory, bound to 127.0.0.1. The [health-check script](scripts/Test-LabHttp.ps1) made fresh requests with a five-second timeout and checked HTTP 200 plus the exact marker `Project 02 service is running`. It returned exit 0 only when both checks passed, and exit 1 otherwise. The learner read `$LASTEXITCODE` immediately after each script invocation.

Controlled changes were requesting /missing-page.html, stopping Python, and restarting it. November 11 reproduction also exposed working-directory mistakes. Evidence consists of learner-supplied terminal output, with server logs corroborating requests and shutdowns; the assistant did not independently monitor processes.

## Results

| Condition | Observation | Exit code | Verified correction |
| --- | --- | --- | --- |
| Homepage from correct sample directory | HTTP 200; expected marker found; Healthy True | 0 | Baseline |
| Missing page | HTTP 404; Healthy False; content check not performed | 1 | Request / with the same server running; HTTP 200, marker found, exit 0 |
| Stopped Python service | No HTTP response; blank status and content result; Healthy False | 1 | Restart Python; fresh HTTP 200, marker found, exit 0 |
| Server started from C:\ using relative sample-site path | / returned HTTP 404 | 1 | Stop server, change to project directory, restart; HTTP 200 and expected marker |
| Final shutdown | Keyboard interrupt received, exiting. | Not applicable | Foreground server shutdown recorded |

See [script validation](notes/script-validation.md) for guided tests and [runbook reproduction](notes/runbook-reproduction.md) for November 11 results, explanation review, and shutdown evidence. Earlier [baseline](notes/healthy-baseline.md), [missing-page](notes/missing-page.md), and [stopped-service](notes/stopped-service.md) notes preserve the initial observations.

## Analysis and corrective actions

An open TCP connection establishes a connection to an address and port. It does not establish an HTTP status or expected page content. This script therefore combines two application checks: HTTP 200 and the expected marker. Healthy describes these defined criteria only.

The missing-page response demonstrates that a running server can respond with an error. Correcting the requested path restored the healthy result without restarting Python. By contrast, the deliberately stopped service returned no HTTP response; restarting Python restored service in that controlled case. A no-response error in another environment would need investigation rather than an assumed restart fix.

Each PowerShell window has its own working directory. The Check window initially could not locate the relative script path from C:\. The Server window separately resolved .\sample-site relative to C:\, returning 404 for /. Changing to the project directory resolved these observed problems. The existence or contents of C:\sample-site were not independently inspected.

The learner correctly identified HTTP 200 and content as the health criteria. Feedback refined the explanation that TCP alone leaves resource delivery unknown, rather than establishing that delivery failed.

## Limitations and further work

- Reproduction required help with working directories and completing the path comparison. It demonstrates assisted use of written instructions, not unaided proficiency.
- HTTP 200 with a missing expected marker was not runtime-tested. The source requires the marker, but that branch's behavior is not claimed as verified.
- Earlier raw content output contained a leading encoding artifact. Its cause and correction remain unverified; the recorded marker comparisons nevertheless passed.
- One matching marker does not prove complete page correctness, production availability, authentication, performance, or security.
- Results cover the stated local configuration. No additional fault types or other PowerShell versions were validated.

## Conclusion and assistance

The recorded checks distinguish a healthy response, a received HTTP error, and a failure without an HTTP response. Correcting the request path and restarting the stopped service each restored the defined healthy result in the appropriate controlled case. Final shutdown was recorded.

AI assistance supported script development, explanations, documentation, and evidence review. The learner ran the commands and supplied the observations. This report summarizes those records; generated prose is not additional experimental evidence. During the explanation check, the learner correctly answered that running only the health check while Python is stopped produces a failed request. The distinction between correcting a path and restarting the server required clarification; an unaided full explanation remains future practice.
