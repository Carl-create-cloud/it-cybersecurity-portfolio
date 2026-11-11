# Missing-page HTTP response

This is a chronological learning record; pending statements describe their stage at the time. See [the final report](../report.md) and [November 11 reproduction](runbook-reproduction.md) for the current outcome.

Date: November 9, 2026. Evidence source: learner-supplied PowerShell output during guided practice.

## Request

With the local Python demo server running, the learner ran:

```powershell
Invoke-WebRequest -Uri "http://127.0.0.1:8000/missing-page.html" -UseBasicParsing
```

## Observed result

The supplied output reported:

```text
Error code: 404
Message: File not found.
Error code explanation: 404 - Nothing matches the given URI.
CategoryInfo: InvalidOperation: (System.Net.HttpWebRequest:HttpWebRequest) [Invoke-WebRequest], WebException
FullyQualifiedErrorId: WebCmdletWebResponseException,Microsoft.PowerShell.Commands.InvokeWebRequestCommand
```

This is an excerpt of the learner output; HTML styling and PowerShell source-location formatting are omitted.

## Interpretation and next verification

An HTTP error response was received from the server. The requested resource was not found; this differs from failure to establish a connection. PowerShell reported the HTTP error as a WebException.

Next: issue a fresh request to / and inspect its status and content. Correct-path recovery is pending; earlier saved $response values must not be treated as a new recovery observation. No server restart is needed for the intended wrong-path correction.

## Correct-path recovery verified

The learner issued a fresh request:

```powershell
$recoveryResponse = Invoke-WebRequest -Uri "http://127.0.0.1:8000/" -UseBasicParsing
$recoveryResponse.StatusCode
$recoveryResponse.Content
```

Learner-supplied output showed status 200 and HTML containing "Project 02 service is running" and "Local HTTP health check and recovery practice." Correcting the requested path therefore restored the expected response for this request. The leading encoding artifact remained visible. No server restart was instructed for this correction.
