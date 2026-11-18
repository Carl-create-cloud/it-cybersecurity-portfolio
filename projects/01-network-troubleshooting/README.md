# Project 01: Network troubleshooting toolkit

Status: completed with guidance.

## Objective

Develop a small PowerShell diagnostic tool that separates name-resolution failures from TCP connection failures. Document how the observations support fault isolation in a basic IT support scenario.

## Investigation question

Which diagnostic observations distinguish an invalid hostname, an unreachable service port, and a successful connection?

## Methodology

1. Learn relevant terms during guided exercises. The broader Day 1 inspection remains a separate pending activity.
2. Restrict this initial project to loopback; broader host-network inspection was deferred.
3. Test an owned service with `Test-NetConnection`, explaining target and port first.
4. Build `scripts/Test-LabConnection.ps1` with target and port parameters. Report name-resolution and TCP results separately, timestamp the result, handle invalid input, and avoid changing network configuration.
5. Document three controlled cases: correct local address/port, deliberately wrong port, and a deliberately nonexistent name ending in `.invalid`. Label intentional failures as simulations.
6. Repeat the successful case and explain how evidence narrowed the fault.

Use only localhost or explicitly scoped lab targets. A loopback-bound Python practice server was introduced during Project 01 for connection and recovery checks. Project 02 will develop the service health check and recovery procedure further.

## Acceptance criteria

- [x] Script source with usage examples and no embedded credentials.
- [x] Positive connection, wrong-port, and failed-name cases recorded with actual results.
- [x] Invalid input produces a useful error: port 70000 rejected with an explicit maximum of 65535; see [script validation](notes/script-validation.md).
- [x] Three tickets using the troubleshooting template.
- [x] README includes limitations and a short explanation in the learner's own words.

Suggested folders: scripts/, notes/, evidence/. Commit only reviewed evidence.

## Results and limitations

See the [technical report](report.md) for a concise summary of the three cases and script validation.

The [stopped-service and recovery case](tickets/01-stopped-local-service.md) records learner-provided TCP results and browser observations. The [wrong-port case](tickets/02-wrong-port.md) records TCP failure on 8001 followed by success on 8000. The [failed-name case](tickets/03-failed-name.md) records the expected nonexistent-name error. The [script validation record](notes/script-validation.md) includes successful and failed connection paths and a name-resolution failure. The learner correctly distinguished TCP connection success from checking the expected page in the browser. TCP success establishes a connection, not application health; a failed connection does not by itself identify a root cause.

## References

- [Microsoft Test-NetConnection](https://learn.microsoft.com/en-us/powershell/module/nettcpip/test-netconnection).

## Run the diagnostic script
Requires Windows PowerShell with Test-NetConnection and Resolve-DnsName available. From this project's directory:

```powershell
.\scripts\Test-LabConnection.ps1 -Target localhost -Port 8000
.\scripts\Test-LabConnection.ps1 -Target localhost -Port 8001
.\scripts\Test-LabConnection.ps1 -Target portfolio-test.invalid -Port 8000
```

A service must already be listening on 127.0.0.1:8000 for the positive test; see the [local service case](tickets/01-stopped-local-service.md). Port 8001 is an intentional wrong-port example, not a guarantee that no other program uses it.

If local script execution is blocked and no organizational policy prohibits it, the exercised session-only setup is:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
```

This setting ends when the PowerShell session closes. It does not change persistent user or machine policy.

## Output interpretation and scope
| Field | Meaning |
| --- | --- |
| NameResolution | Succeeded, Failed, or Not needed when the input is an IP address. |
| ResolvedAddress | IPv4 lookup result or the direct loopback address. |
| TcpCheck | Performed, Not performed, or Error. |
| TcpTestSucceeded | True or False when measured; blank when no result was obtained. |
| Detail | Connection interpretation or captured error information. |
| HttpCheck | Always not performed: this script does not request a webpage. |

Allowed targets are 127.0.0.1, localhost, and portfolio-test.invalid. TCP probes are restricted to 127.0.0.1. The invalid name is used for lookup practice only. This small tool supports IPv4 and one port per invocation; it is not a general network scanner. Name lookups can contact the configured resolver; localhost success does not verify external DNS health.

Evidence is learner-provided terminal output and browser observations. The assistant prepared the script and documentation; the learner supplied the explanation recorded below. No process inventory or packet capture was collected. The practice page is included in sample-site/ for reproduction. Recorded browser results used the original lab-web/ copy; running the bundled copy from a fresh checkout has not yet been verified.

## Learner explanation
> "only that the connection opened to confirm we must type http://127.0.0.1:8000/ on browser to check it"

The learner also identified portfolio-test.invalid as the name that failed resolution, explained why 70000 exceeds the permitted port range, and associated the intended server with port 8000. These answers followed guided practice and corrections.

## Reproduce the local service
Python must be installed. From this project directory, run in the first PowerShell window:

```powershell
python -m http.server 8000 --bind 127.0.0.1 --directory .\sample-site
```

Leave this window running. In a second PowerShell window, run the diagnostic examples above. In Chrome, open http://127.0.0.1:8000/ and verify the heading "My local lab service works" and text "Project 1 connection test." A successful TCP result alone does not verify that content.

To reproduce the stopped-service case, press Ctrl+C in the server window, repeat the TCP check, then restart the same server and verify both TCP and the browser page. Record actual outcomes, even if they differ from the earlier results. Stop the server with Ctrl+C when finished.
