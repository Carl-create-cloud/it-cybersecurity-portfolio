# Stopped-service exercise

This is a chronological learning record; pending statements describe their stage at the time. See [the final report](../report.md) and [November 11 reproduction](runbook-reproduction.md) for the current outcome.

Date: November 9, 2026. Evidence source: learner-supplied terminal output during guided practice.

## Controlled shutdown

After the Ctrl+C instruction, the learner supplied:

```text
Keyboard interrupt received, exiting.
PS C:\>
```

The foreground Python demo process exited and returned control to PowerShell. The preceding server log corroborated the earlier HTTP sequence: GET / returned 200, GET /missing-page.html returned 404, and GET / returned 200.

## Pending verification

A fresh client request after shutdown and subsequent restart/recovery checks remain pending. Saved response objects describe earlier requests, not current service availability.

## Stopped-service client result

The learner ran a fresh request after shutdown:

```powershell
Invoke-WebRequest -Uri "http://127.0.0.1:8000/" -UseBasicParsing -TimeoutSec 5
```

Supplied output reported:

```text
Invoke-WebRequest : Unable to connect to the remote server
CategoryInfo: InvalidOperation: (System.Net.HttpWebRequest:HttpWebRequest) [Invoke-WebRequest], WebException
FullyQualifiedErrorId: WebCmdletWebResponseException,Microsoft.PowerShell.Commands.InvokeWebRequestCommand
```

This establishes a connection failure for the tested request following the controlled shutdown. No HTTP status was received. The earlier 404 was an HTTP response from a running server. Both appeared as PowerShell errors, so the error category alone does not distinguish these cases.

Restart and a fresh HTTP recovery check remain pending.

## Restart observation

The learner reran the same Python command with port 8000, bind address 127.0.0.1, and the dedicated Project 02 sample-site directory. Supplied output:

```text
Serving HTTP on 127.0.0.1 port 8000 (http://127.0.0.1:8000/) ...
```

Restart is supported by startup output. A fresh HTTP status and expected-content check after this restart remain pending; startup alone does not establish application recovery.

## HTTP recovery verified

After restart, the learner issued a fresh request:

```powershell
$restartResponse = Invoke-WebRequest -Uri "http://127.0.0.1:8000/" -UseBasicParsing -TimeoutSec 5
$restartResponse.StatusCode
$restartResponse.Content
```

Supplied output showed status 200 and HTML containing "Project 02 service is running" and "Local HTTP health check and recovery practice." This verifies expected HTTP behavior for the post-restart request. The leading encoding display artifact persisted.

The guided sequence is now supported by learner evidence: healthy response, controlled shutdown, connection failure, restart, and successful HTTP/content check. Independent runbook reproduction and automated health-check implementation remain pending. The restarted server has not yet been shut down at session end.
