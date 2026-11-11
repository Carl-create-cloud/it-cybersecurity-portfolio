# Healthy HTTP baseline

This is a chronological learning record; pending statements describe their stage at the time. See [the final report](../report.md) and [November 11 reproduction](runbook-reproduction.md) for the current outcome.

Date: November 9, 2026. Evidence source: learner-supplied PowerShell output during guided practice.

## Setup and observations

- Initial Test-NetConnection to 127.0.0.1:8000: TcpTestSucceeded False, PingSucceeded True, RTT 0 ms.
- python --version: Python 3.14.0.
- Started the following command with the dedicated demo directory (absolute directory path is specific to this workspace):

```powershell
python -m http.server 8000 --bind 127.0.0.1 --directory "C:\Cybersecurity_RedTeam_Learning\portfolio\projects\02-service-recovery\sample-site"
```

Startup output: Serving HTTP on 127.0.0.1 port 8000 (http://127.0.0.1:8000/) ...

In a second PowerShell window:

```powershell
$response = Invoke-WebRequest -Uri "http://127.0.0.1:8000/" -UseBasicParsing
$response.StatusCode
$response.Content
```

Learner supplied status code 200 and HTML containing the heading "Project 02 service is running" and paragraph "Local HTTP health check and recovery practice."

## Interpretation and limitations

The recorded request returned HTTP success and expected content. This is one healthy observation, not continuous availability monitoring. Displayed content had a leading ï»¿ encoding artifact; investigation remains pending. The status and content properties inspect the saved response rather than issue new requests.

Stopped-server and missing-page cases, automated health check, recovery runbook, learner-authored interpretation, and shutdown confirmation remain pending.

## Learner documentation review

The learner correctly identified the HTTP request command and HTML content returned. Their result summary omitted status 200, and the property name needed correction from statuscontent to Content. Independent explanation of TCP availability versus HTTP success remains pending.

Reviewed observation based on the supplied evidence:

- Goal: Check whether the local web server returns the expected page successfully.
- Command: Invoke-WebRequest, storing its response in $response; inspect $response.StatusCode and $response.Content.
- Result: HTTP 200 and HTML containing "Project 02 service is running".
- Meaning: The server accepted an HTTP request and returned the expected page for this request. An open TCP port alone does not establish this.

This wording is an assistant-reviewed explanation, not evidence of independent learner mastery.

The learner subsequently correctly answered that TCP success does not guarantee the correct webpage. Their description of TCP as checking whether the web server is online/offline was refined: it checks connection establishment to the selected address and port, not overall HTTP health. The key distinction is demonstrated; precise terminology is still developing.
