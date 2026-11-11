# HTTP health-check script validation

This is a chronological learning record; pending statements describe their stage at the time. See [the final report](../report.md) and [November 11 reproduction](runbook-reproduction.md) for the current outcome.

## First version: healthy request — November 9, 2026

Evidence source: learner-supplied PowerShell output.

After setting RemoteSigned at Process scope in the testing window, the learner ran scripts/Test-LabHttp.ps1 and supplied:

```text
Uri                    StatusCode Http200 ContentCheck
---                    ---------- ------- ------------
http://127.0.0.1:8000/        200    True Not performed
```

This verifies the first version's fresh-request success path. It does not verify expected content, failure handling, or process exit codes. Process-scoped execution policy expires when that PowerShell session closes; no persistent change was requested.

## Status-and-content version: healthy request — November 9, 2026

The learner reran scripts/Test-LabHttp.ps1 and supplied:

```text
Uri                  : http://127.0.0.1:8000/
StatusCode           : 200
Http200              : True
ExpectedContentFound : True
Healthy              : True
```

This verifies the revised fresh-request success path, including the expected heading check and combined Healthy result. Healthy is limited to the defined criteria: HTTP 200 and the expected text marker. Revised failure behavior and explicit exit codes remain unverified or unimplemented.

## Status-and-content version: failed request — November 9, 2026

After the instruction to stop Python, the learner supplied script output reporting Unable to connect to the remote server, with WriteErrorException from Write-Error. This verifies the previous script version's error path. Shutdown output was not supplied for this particular test; the connection failure does not independently identify process state.

The script was then revised to emit structured failure fields, preserving the original error message and distinguishing an HTTP error response from a request failure without an HTTP response. Revised runtime is pending. Empty StatusCode means no HTTP status received; empty ExpectedContentFound means the content check was not performed.

## Structured failure version: unavailable service — November 9, 2026

Learner-supplied output from the revised script:

```text
Uri                  : http://127.0.0.1:8000/
RequestResult        : Request failed without HTTP response
StatusCode           :
Http200              : False
ExpectedContentFound :
Healthy              : False
ErrorDetail          : Unable to connect to the remote server
```

The structured no-response path is verified. Empty StatusCode means no HTTP status was received; empty ExpectedContentFound means the marker was not checked. Http200 False does not imply a received non-200 response in this case. Structured success, HTTP-error response handling, and process exit codes remain pending.

## Structured success and recovery — November 9, 2026

Learner-supplied script output:

```text
Uri                  : http://127.0.0.1:8000/
RequestResult        : Response received
StatusCode           : 200
Http200              : True
ExpectedContentFound : True
Healthy              : True
ErrorDetail          :
```

This verifies the structured success path and fresh HTTP/content recovery after the earlier failed request. A separate startup message was requested but not supplied for this restart; client-side recovery is supported by the output above.

The script was subsequently extended with a Path parameter restricted to / and /missing-page.html, retaining the fixed loopback address and port. Syntax check passed; the new parameter and HTTP-error path await learner runtime verification.

## Missing-page script path verified — November 9, 2026

Learner ran Test-LabHttp.ps1 -Path /missing-page.html and supplied:

```text
Uri                  : http://127.0.0.1:8000/missing-page.html
RequestResult        : HTTP error response
StatusCode           : 404
Http200              : False
ExpectedContentFound :
Healthy              : False
ErrorDetail          : The remote server returned an error: (404) Not Found.
```

The Path option and HTTP-error classification are verified. Content was not checked on this error path. Together with prior observations, the script distinguishes a received HTTP error from a request failure without an HTTP response.

Explicit exit codes were then added: 0 when HTTP 200 and the expected marker are both present; 1 otherwise. Syntax check passed; exit-code runtime verification remains pending.

## HTTP-error exit code verified — November 9, 2026

Learner supplied the updated script invocation with -Path /missing-page.html, showing HTTP error response, StatusCode 404, Http200 False, empty ExpectedContentFound, Healthy False, and (404) Not Found error detail. Immediately afterward, the learner supplied:

```powershell
$LASTEXITCODE
```

```text
1
```

This verifies exit code 1 for the updated script's HTTP-error path. It supersedes the earlier exit-code observation whose preceding invocation was uncertain. Healthy exit code 0 and unavailable-service exit code 1 remain pending.

## Healthy exit code verified — November 9, 2026

The learner ran the updated script with its default / path and supplied HTTP 200, RequestResult Response received, Http200 True, ExpectedContentFound True, Healthy True, and empty ErrorDetail. The next supplied command was $LASTEXITCODE, with output 0.

This verifies the healthy path's explicit success exit code. The HTTP-error path has separately returned exit code 1. The no-response path's exit code and a content-mismatch case remain pending.

## No-response exit code verified — November 9, 2026

Learner supplied Keyboard interrupt received, exiting, then ran the updated script. Output showed Request failed without HTTP response, blank StatusCode, Http200 False, blank ExpectedContentFound, Healthy False, and Unable to connect to the remote server. The next supplied $LASTEXITCODE result was 1.

This verifies the no-response failure exit code. Guided runtime evidence now covers healthy (0), HTTP 404 (1), and unavailable service (1). A content-marker mismatch under HTTP 200 remains untested. Last observed demo state: stopped.
