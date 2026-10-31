# Project 01: Network troubleshooting toolkit

Status: planned; no diagnostic script or results yet.

## Objective

Develop a small PowerShell diagnostic tool that separates name-resolution failures from TCP connection failures. Document how the observations support fault isolation in a basic IT support scenario.

## Investigation question

Which diagnostic observations distinguish an invalid hostname, an unreachable service port, and a successful connection?

## Methodology

1. Learn working directories, IP addresses, DNS, and ports. Complete the Day 1 note.
2. Manually inspect local network configuration and explain relevant fields; keep personal network data local.
3. Test an owned service with `Test-NetConnection`, explaining target and port first.
4. Build `scripts/Test-LabConnection.ps1` with target and port parameters. Report name-resolution and TCP results separately, timestamp the result, handle invalid input, and avoid changing network configuration.
5. Document three controlled cases: correct local address/port, deliberately wrong port, and a deliberately nonexistent name ending in `.invalid`. Label intentional failures as simulations.
6. Repeat the successful case and explain how evidence narrowed the fault.

Use only localhost or explicitly scoped lab targets. The live local service used for positive tests will be introduced in Project 02; the positive test may remain pending until then.

## Acceptance criteria

- [ ] Script source with usage examples and no embedded credentials.
- [ ] Positive connection, wrong-port, and failed-name cases recorded with actual results.
- [ ] Invalid input produces a useful error.
- [ ] Three tickets using the troubleshooting template.
- [ ] README includes limitations and a short explanation in the learner's own words.

Suggested folders: scripts/, notes/, evidence/. Commit only reviewed evidence.

## Results and limitations

No tests have been completed. Record each case's input, expected behavior, actual output, and interpretation in the [technical report](../../templates/technical-report.md). TCP success establishes a connection, not application health; a failed connection does not by itself identify a root cause.

## References

- [Microsoft Test-NetConnection](https://learn.microsoft.com/en-us/powershell/module/nettcpip/test-netconnection).
