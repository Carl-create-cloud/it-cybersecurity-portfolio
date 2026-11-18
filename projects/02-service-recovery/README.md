# Project 02: Local web-service recovery

Status: completed with guidance.

## Objective

Deploy a local demonstration web service, evaluate its behavior under controlled failures, and document a reproducible recovery procedure. Implement a health check that distinguishes connection failure from an HTTP response.

## Investigation question

How do connection tests and HTTP responses differ when the service is healthy, stopped, or serving a missing resource?

## Methodology

1. Check whether Python 3 is available on the chosen host; record its version. Resolve setup before following commands.
2. Create a dedicated directory containing only a harmless demo index.html page.
3. From that directory, run `python -m http.server 8000 --bind 127.0.0.1` (use the verified Python command on your machine). The module serves files, 8000 selects the port, and the bind argument limits access to the local machine. Use a dedicated terminal and stop with Ctrl+C.
4. Open `http://127.0.0.1:8000/` on the same machine. Record an HTTP success and complete Project 01's positive connection case.
5. Reproduce two failures: stop your demo process; request a nonexistent page. Record how connection failure differs from HTTP 404. Restore the process or request the correct path and retest.
6. Write a small health-check script that reports HTTP status or connection failure and returns a nonzero exit code on failure.
7. Write a runbook explaining startup, verification, common faults, recovery, and shutdown.

This is a local training service, not production hosting. Python's simple server is not intended for production use. Do not serve your home directory or repository root.

## Acceptance criteria

- [x] Demo page, verified startup instructions, and health-check source.
- [x] Healthy response, stopped-server failure, and missing-page response tested.
- [x] Health check distinguishes success and failure with appropriate exit status.
- [x] Recovery runbook reproduced from fresh terminals with assistance; see reproduction evidence.
- [x] [Report](report.md) explains why an open port alone is insufficient; assisted explanation recorded.

## Results and limitations

On November 9, 2026, learner-provided output confirmed Python 3.14.0, startup bound to 127.0.0.1:8000, HTTP status 200, and the expected Project 02 page content. See [baseline evidence](notes/healthy-baseline.md). The [missing-page case](notes/missing-page.md) records HTTP 404 followed by a successful correct-path request. The [stopped-service case](notes/stopped-service.md) records shutdown, connection failure, restart, and fresh HTTP 200 with expected content. These are guided observations; the automated main paths and exit codes are recorded in [script validation](notes/script-validation.md). Fresh-terminal reproduction using the [recovery runbook](runbook.md) was completed with assistance; see [reproduction evidence](notes/runbook-reproduction.md), including final shutdown. A content-marker mismatch under HTTP 200 has not been tested. The [report](report.md) summarizes results, corrections, assistance, and unresolved limitations. The experiment concerns a local static service; it does not evaluate production availability, authentication, or load handling.

## References

- [Python http.server](https://docs.python.org/3/library/http.server.html).
