# Ticket 02: Connection attempt to the wrong local port

Status: resolved in the controlled exercise; correct-port TCP comparison verified from learner-provided output.

## Problem and expected behavior
Intentional simulation: the practice web server is configured for TCP port 8000, but the diagnostic targets port 8001. Expected: connection failure on 8001 if no service accepts connections there, while the intended service remains reachable on 8000.

## Environment and authorized scope
Owned Windows host; Windows PowerShell; loopback 127.0.0.1 only. Python practice service previously configured for port 8000. No configuration changes were made for this test.

## Hypotheses and tests
Learner ran:

```powershell
Test-NetConnection -ComputerName 127.0.0.1 -Port 8001
```

Learner-provided output:

```text
WARNING: TCP connect to (127.0.0.1 : 8001) failed
ComputerName           : 127.0.0.1
RemoteAddress          : 127.0.0.1
RemotePort             : 8001
InterfaceAlias         : Loopback Pseudo-Interface 1
SourceAddress          : 127.0.0.1
PingSucceeded          : True
PingReplyDetails (RTT) : 0 ms
TcpTestSucceeded       : False
```

The connection to 8001 failed while loopback ping succeeded. This matches the prediction, but does not independently prove that no process is listening. The subsequent check on 8000 succeeded, as recorded below.

## Root cause
The test deliberately selected a different port from the configured practice server port. The subsequent correct-port test succeeded on 8000, supporting the destination-port mismatch as the explanation for failure to reach the intended practice service on 8001. The test does not independently establish why 8001 rejected or failed the connection.

## Fix, rollback, and verification
Applied correction: learner targeted port 8000 and repeated the diagnostic. The supplied output reports TcpTestSucceeded True. The diagnostic changes no configuration, so no rollback is required.

## Prevention, limitations, and lessons
Check the destination port against the service configuration. A server listening on 8000 does not automatically listen on 8001. Ping does not test either TCP port.

Learner correctly predicted that the 8000 listener does not imply a listener on 8001. Whether another program uses 8001 was not established by that prediction. Evidence is learner-provided terminal output; no listener inventory was captured.


## Correct-port verification — November 4, 2026
Learner ran:

```powershell
Test-NetConnection -ComputerName 127.0.0.1 -Port 8000
```

Learner-provided output:

```text
ComputerName     : 127.0.0.1
RemoteAddress    : 127.0.0.1
RemotePort       : 8000
InterfaceAlias  : Loopback Pseudo-Interface 1
SourceAddress   : 127.0.0.1
TcpTestSucceeded : True
```

The sequential checks demonstrate TCP failure on 8001 and success on 8000 on the same host. Correcting the destination port restored the connection to the intended endpoint. No additional browser check was performed in this wrong-port case; TCP success alone is not an application health check.
