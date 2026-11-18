# Network troubleshooting report

Status: completed with guidance. Date: November 4, 2026.

## Objective and scope

Distinguish DNS lookup failure, TCP connection failure, and application verification in an owned local lab. TCP checks were restricted to 127.0.0.1; the deliberately invalid hostname portfolio-test.invalid was used for name-resolution failure. The lab used Windows PowerShell and a loopback-bound Python HTTP server on port 8000.

## Method and results

The learner ran the explained commands and supplied terminal output and browser observations. The [diagnostic script](scripts/Test-LabConnection.ps1) reports name resolution and TCP results separately, skips TCP when resolution fails, and explicitly states that it does not check HTTP content.

| Case | Observation | Interpretation and action |
| --- | --- | --- |
| [Stopped local service](tickets/01-stopped-local-service.md) | TCP sequence False, True, False, True; expected webpage observed during the initial running state and after recovery | Starting the practice service restored access in the controlled case. Ping success did not establish service availability. |
| [Wrong port](tickets/02-wrong-port.md) | Port 8001 failed, followed by port 8000 succeeding | Correcting the destination port restored the TCP connection. |
| [Invalid name](tickets/03-failed-name.md) | portfolio-test.invalid returned a name-resolution error | The intentional invalid name did not resolve; this does not establish a general DNS outage. |
| [Script validation](notes/script-validation.md) | Valid TCP and DNS paths recorded; port 70000 rejected | Invalid input is distinct from a failed connection. A skipped TCP check is not a measured False result. |

## Reproduction

Use the [README](README.md) for prerequisites, the loopback server command, script examples, expected fields, and shutdown instructions. Use separate server and check terminals. Do not change persistent execution policy or probe unrelated targets for this exercise.

## Limitations and assistance

TCP success does not establish HTTP health. Browser content was checked separately; no HTTP status was captured for the initial browser case. The script supports IPv4 and only the stated lab targets, and it does not diagnose every possible connection failure. A localhost lookup does not establish external DNS health. The included sample-page copy was not revalidated from a fresh checkout during the original learner session.

AI assisted with script preparation, explanations, and documentation. Recorded practical observations came from the learner. This report consolidates the existing tickets and validation notes; it does not add new runtime results.
