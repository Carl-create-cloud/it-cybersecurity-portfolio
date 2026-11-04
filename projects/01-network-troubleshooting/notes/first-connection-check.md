# First local connection check

Status: baseline, controlled comparison, and recovery recorded. This chronological log retains earlier pending steps; later entries supersede them. See the project README for the final learner explanation.

## Objective and scope
Check whether a TCP connection can be established to port 8000 on this Windows computer. Target: loopback address 127.0.0.1 only. No VM or network configuration changes.

## Method
Run in Windows PowerShell:

```powershell
Test-NetConnection -ComputerName 127.0.0.1 -Port 8000
```

- Test-NetConnection performs a connection diagnostic.
- -ComputerName selects the destination; 127.0.0.1 refers to the Windows computer running the command.
- -Port 8000 selects TCP port 8000.
- TcpTestSucceeded reports whether the TCP connection was established.

## Expected behavior
Unknown until measured. True means a TCP connection was established. False means the attempt failed; it does not by itself prove why. This is a baseline observation, not yet a controlled wrong-port test.

## Actual observation
Learner supplied the following result from Windows PowerShell:

- Target: 127.0.0.1, TCP port 8000.
- Warning: TCP connect to (127.0.0.1 : 8000) failed.
- PingSucceeded: True; RTT: 0 ms.
- TcpTestSucceeded: False.
- Interface: Loopback Pseudo-Interface 1.

The loopback ping succeeded, but the TCP connection attempt failed. No listening service is a plausible explanation, not a verified cause. This observation does not establish an internet connectivity problem.

## Interpretation in the learner's own words
Pending.

## Next step
Review the observation, then prepare a controlled local service to compare successful and unsuccessful connections. Continue toward a reusable diagnostic script and reproducible troubleshooting cases.


## Successful connection comparison — November 4, 2026
The learner repeated the same command after being instructed to start the loopback-bound Python server and supplied:

```text
ComputerName     : 127.0.0.1
RemoteAddress    : 127.0.0.1
RemotePort       : 8000
InterfaceAlias  : Loopback Pseudo-Interface 1
SourceAddress   : 127.0.0.1
TcpTestSucceeded : True
```

The TCP connection now succeeds, compared with False in the baseline. This supports that a TCP endpoint accepted the connection at test time. Server startup output was not supplied; service identity, HTTP response, and page content have not yet been verified. Learner explanation remains pending.

Next verification: open http://127.0.0.1:8000 in a Windows browser while the practice server is running and report the actual page or error. Expected heading: My local lab service works.

## Browser verification — November 4, 2026
The learner reported these page contents after opening http://127.0.0.1:8000 in the Windows browser:

```text
My local lab service works
Project 1 connection test.
```

This verifies the expected practice page was displayed, in addition to the successful TCP connection. No HTTP status code was captured.

Learner explanation: "Because we use port 8000 as a server?"
Partial understanding: learner connects success with the service on port 8000. Clarification provided: Python runs the server program; port 8000 is the numbered TCP endpoint where it listens, not itself a server. Starting the listener explains the expected transition; the original baseline cause was not independently inspected.

Next exercise: stop the practice server with Ctrl+C in its PowerShell window, repeat the same TCP diagnostic in the other window, and report the actual result. Expected False; execution pending.

## Controlled stopped-service check — November 4, 2026
Following the instruction to stop the Python server with Ctrl+C, the learner supplied the repeated diagnostic output:

```text
WARNING: TCP connect to (127.0.0.1 : 8000) failed
ComputerName           : 127.0.0.1
RemoteAddress          : 127.0.0.1
RemotePort             : 8000
InterfaceAlias         : Loopback Pseudo-Interface 1
SourceAddress          : 127.0.0.1
PingSucceeded          : True
PingReplyDetails (RTT) : 0 ms
TcpTestSucceeded       : False
```

Observed sequence: baseline TCP False, TCP True after the server-start instruction, expected webpage displayed, then TCP False after the server-stop instruction. This is consistent with service availability changing with the server lifecycle. The loopback ping still succeeds, demonstrating that ping success does not establish availability of this TCP service. Process state was not independently captured.

Next step: restart the same loopback-bound practice server, repeat the TCP test, and refresh the browser page to verify recovery. Recovery remains pending. This stopped-service case is distinct from the planned wrong-port and failed-name cases.

## TCP recovery check — November 4, 2026
Following the instruction to restart the same practice server, the learner supplied:

```text
ComputerName     : 127.0.0.1
RemoteAddress    : 127.0.0.1
RemotePort       : 8000
InterfaceAlias  : Loopback Pseudo-Interface 1
SourceAddress   : 127.0.0.1
TcpTestSucceeded : True
```

TCP connectivity recovered after the stopped-service result. The observed TCP sequence is False → True → False → True. The browser refresh result after restart has not yet been supplied; application recovery remains pending. Next step: refresh http://127.0.0.1:8000 in Chrome while the server remains running and report the displayed content or error.

## Application recovery — November 4, 2026
After the restart and successful TCP recovery check, the learner reported the refreshed browser page:

```text
My local lab service works
Project 1 connection test.
```

Expected page content is restored. Connection and application recovery are supported by learner-provided results. No HTTP status code or process-state capture was collected. See ../tickets/01-stopped-local-service.md for the consolidated case. Independent learner explanation remains pending.
