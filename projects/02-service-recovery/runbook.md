# Local HTTP service recovery runbook

Status: reproduced from fresh terminals with assistance on November 11, 2026; see notes/runbook-reproduction.md.

## Scope and prerequisites

Use Windows PowerShell and Python (learner verified Python 3.14.0). The service listens only on 127.0.0.1:8000 and serves sample-site/. Commands below use this workspace location; adapt it if the repository is moved. Run one command at a time. Keep two windows: Server and Check.

## 1. Start from fresh windows

Ensure the previous Python server was stopped with Ctrl+C. Open two new Windows PowerShell windows. In each, change to the project directory; Set-Location changes the current folder:

```powershell
Set-Location "C:\Cybersecurity_RedTeam_Learning\portfolio\projects\02-service-recovery"
```

In Server, start Python's web-server module on local port 8000, serving only the sample folder:

```powershell
python -m http.server 8000 --bind 127.0.0.1 --directory .\sample-site
```

Expect Serving HTTP on 127.0.0.1 port 8000. Leave this window running. If the port is already in use, identify your earlier lab server window and stop that process; do not terminate an unidentified program.

## 2. Enable the local script if needed

In Check, inspect execution policy; this changes nothing:

```powershell
Get-ExecutionPolicy -List
```

If MachinePolicy or UserPolicy specifies a restriction, stop and review it rather than bypassing it. In the observed setup all scopes were Undefined. For that setup, permit local scripts only for this Check session:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
```

Answer Y only if prompted. This setting expires when the window closes. No administrator window or persistent policy change is required for this exercise.

## 3. Verify healthy behavior

In Check, run the script. It makes a fresh request to / and checks HTTP 200 plus the expected heading:

```powershell
& .\scripts\Test-LabHttp.ps1
```

Immediately afterward, display the script's outcome code:

```powershell
$LASTEXITCODE
```

Expect Response received, StatusCode 200, ExpectedContentFound True, Healthy True, exit code 0. Record the output. Exit codes are script outcomes, not HTTP status codes.

## 4. Missing page and correction

The Path option selects a requested resource on the same local server. Request the deliberately absent page:

```powershell
& .\scripts\Test-LabHttp.ps1 -Path '/missing-page.html'
```

Then inspect its exit code:

```powershell
$LASTEXITCODE
```

Expect HTTP error response, status 404, Healthy False, exit code 1. The server responded; the resource was missing. Correct the path by repeating section 3. Expect healthy output and exit 0. No restart is needed for this wrong-path correction.

## 5. Stopped service and recovery

In Server, press Ctrl+C. Expect Keyboard interrupt received, exiting. and a PowerShell prompt.

In Check, repeat section 3. Expect Request failed without HTTP response, blank StatusCode, blank ExpectedContentFound, Healthy False, and exit 1. Read ErrorDetail: request failures can have different causes; this controlled exercise follows a deliberate shutdown.

In Server, rerun the Python startup command from section 1. In Check, repeat section 3 and record the new healthy response and exit 0. Restarting starts the server program listening again; it does not refresh network traffic.

## 6. Shutdown and evidence

In Server, press Ctrl+C and record the shutdown message. Close both windows when finished, removing the Check window's temporary policy setting.

For reproduction, retain the fresh-run output for healthy, missing-page, corrected-path, stopped-service, restarted-service, and final shutdown states. Write one short Goal / Command / Result / Meaning note in your own words. Reading this runbook alone does not complete reproduction.

## Interpretation and limits

An open TCP connection does not establish HTTP success or expected content. This script requires both HTTP 200 and a specific text marker. Blank status means no HTTP status was received; blank content result means the check was not performed on the error path.

The no-response, HTTP-error, and healthy paths have guided runtime evidence in notes/script-validation.md. A successful response with a missing content marker has not been tested. A leading encoding display artifact was observed in raw page output; it did not prevent the tested heading match and remains unresolved. Tests cover a local static service, not production availability. Keep repository visibility private.
