# Project 02: Local web-service recovery

Status: planned; no service started or failures tested yet.

## What I want to learn

I'll run a simple website on my own computer, deliberately stop it or request a missing page, and work out how to identify each problem. I want to understand why a running server doesn't always mean the website is working. I'll also write recovery instructions that I can follow later without guessing.

## Steps to work through

1. Check whether Python 3 is available on the chosen host; record its version. Resolve setup before following commands.
2. Create a dedicated directory containing only a harmless demo index.html page.
3. From that directory, run `python -m http.server 8000 --bind 127.0.0.1` (use the verified Python command on your machine). The module serves files, 8000 selects the port, and the bind argument limits access to the local machine. Use a dedicated terminal and stop with Ctrl+C.
4. Open `http://127.0.0.1:8000/` on the same machine. Record an HTTP success and complete Project 01's positive connection case.
5. Reproduce two failures: stop your demo process; request a nonexistent page. Record how connection failure differs from HTTP 404. Restore the process or request the correct path and retest.
6. Write a small health-check script that reports HTTP status or connection failure and returns a nonzero exit code on failure.
7. Write a runbook explaining startup, verification, common faults, recovery, and shutdown.

This is a local training service, not production hosting. Python's simple server is not intended for production use. Do not serve your home directory or repository root.

## Before I call this finished

- [ ] Demo page, verified startup instructions, and health-check source.
- [ ] Healthy response, stopped-server failure, and missing-page response tested.
- [ ] Health check distinguishes success and failure with appropriate exit status.
- [ ] Recovery runbook reproduced from a fresh terminal.
- [ ] Report explains why an open port alone is insufficient.

Reference: [Python http.server](https://docs.python.org/3/library/http.server.html).
