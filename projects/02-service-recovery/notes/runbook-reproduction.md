# Runbook reproduction — November 11, 2026

Evidence source: learner-supplied terminal output from Server and Check PowerShell windows. Reproduction used the written runbook with assistant help for working-directory errors; it is not an unaided proficiency claim.

## Observed results

| Condition | Request result | HTTP status | Expected content found | Healthy | Exit code |
| --- | --- | --- | --- | --- | --- |
| Server started from C:\ with relative sample-site path; request / | HTTP error response | 404 | Not checked | False | 1 |
| Server restarted from Project 02 directory; request / | Response received | 200 | True | True | 0 |
| Request /missing-page.html | HTTP error response | 404 | Not checked | False | 1 |
| Python stopped; request / | Request failed without HTTP response | None received | Not checked | False | 1 |
| Python restarted; request / | Response received | 200 | True | True | 0 |

Each supplied script result was immediately followed by $LASTEXITCODE. Server logs corroborate GET / returning 404 at 22:16:23, GET / returning 200 at 22:18:06, GET /missing-page.html returning 404 at 22:18:29, and GET / returning 200 after restart at 22:19:41. Two intermediate shutdowns show Keyboard interrupt received, exiting.

## Working-directory troubleshooting

An earlier Check-window invocation from C:\ could not locate .\scripts\Test-LabHttp.ps1. The learner supplied Process-scoped RemoteSigned policy, so that error was script-path lookup failure rather than an execution-policy block.

The Server window also initially started from C:\. Its relative .\sample-site argument referred to C:\sample-site rather than the project's sample-site directory. Startup alone did not establish correct content delivery: / returned HTTP 404. After stopping Python, changing to the project directory, and starting the same command, / returned HTTP 200 with the expected marker. No independent inspection of C:\sample-site was performed.

## Learner explanation

The learner identified the health-check script and $LASTEXITCODE as the commands used and described healthy resource delivery versus a missing resource on a reachable server. Feedback clarified that the defined healthy result requires HTTP 200 plus the expected marker; HTTP 404 is a server response and may contain an error page. The initial learner note omitted specific observed values; the table above records the subsequently supplied evidence.

## Corrected-path follow-up

Following instructions to leave Python running, the learner supplied a new /missing-page.html check with HTTP 404, Healthy False, and immediate exit code 1. The next default-path check returned Response received, HTTP 200, Http200 True, ExpectedContentFound True, Healthy True, empty ErrorDetail, and immediate exit code 0. This supports corrected-path recovery without a restart in the learner-reported sequence; no independent process monitoring was performed.

## Final shutdown and reproduction outcome

The learner supplied the same server session's log: GET /missing-page.html returned 404 at 22:55:24, then GET / returned 200 at 22:56:05, followed by Keyboard interrupt received, exiting. This corroborates corrected-path recovery without an intervening restart and confirms final foreground server shutdown. The returned prompt was not included; the explicit shutdown message supports process exit.

Runbook reproduction is complete with assistance. All requested states have learner-provided evidence. This does not establish unaided proficiency. Last confirmed server state: stopped.

## Explanation review

The learner stated: "Because TCP port only tells server is available but resources has not been delivered" and "Health check script checks content and Http200". This correctly identifies the two health-check criteria and the need for an application check. Feedback refined the TCP statement: a successful TCP connection establishes that a connection opened to the selected address and port; it does not establish whether the expected HTTP resource was delivered. Lack of delivery cannot be inferred from TCP success alone. In this script, Healthy requires HTTP 200 and the exact expected text marker together.

## Remaining project work

- The report now documents untested content-mismatch behavior and the unresolved encoding artifact as limitations. Unaided explanation remains future practice.

## Final explanation check

After clarification of path correction versus restarting Python, the learner correctly answered "Failed request" when asked what the health check would do while Python was stopped. This verifies recognition that the script diagnoses rather than starts the server; it does not establish an unaided full explanation.
