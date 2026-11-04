# Diagnostic script validation

## First learner runtime check — November 4, 2026
Initial attempt was blocked by PowerShell execution policy. Learner ran Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned; no confirmation prompt appeared. A subsequent standalone Y command produced CommandNotFoundException and was not needed. The script then ran successfully in that window. No persistent policy change was requested.

Command:

```powershell
& "C:\Cybersecurity_RedTeam_Learning\portfolio\projects\01-network-troubleshooting\scripts\Test-LabConnection.ps1" -Port 8000
```

Learner-provided output:

```text
Timestamp        : 2026-11-04T17:39:04.8587047+08:00
Target           : 127.0.0.1
Port             : 8000
TcpTestSucceeded : True
HttpCheck        : Not performed; TCP success does not verify the webpage.
```

The first script version executes and reports successful TCP connectivity, a timestamp, destination, and explicit HTTP-check limitation. This invocation did not verify webpage content or DNS behavior.

Next check: invoke with -Port 70000. Expected: parameter validation rejects a port outside 1–65535 before executing the diagnostic. Actual outcome pending.

## Out-of-range port rejected — November 4, 2026
Learner invoked Test-LabConnection.ps1 -Port 70000 and supplied:

```text
Cannot validate argument on parameter 'Port'. The 70000 argument is greater than the maximum allowed range of 65535. Supply an argument that is less than or equal to 65535 and then try the command again.
CategoryInfo : InvalidData: (:) [Test-LabConnection.ps1], ParameterBindingValidationException
FullyQualifiedErrorId : ParameterArgumentValidationError,Test-LabConnection.ps1
```

Result: passed this invalid-input check. PowerShell parameter validation rejected the argument before the diagnostic body executed. This verifies the tested upper-bound rejection only, not every possible invalid input.

Next runtime check: run the script with -Port 8001. This is a valid port number, so validation should allow it and the diagnostic should report the actual connection outcome. The earlier manual test failed on this port; current script result remains pending.

## Valid port with failed connection — November 4, 2026
Learner ran the first script version with -Port 8001 and supplied:

```text
Timestamp        : 2026-11-04T17:40:59.2165006+08:00
Target           : 127.0.0.1
Port             : 8001
TcpTestSucceeded : False
HttpCheck        : Not performed; TCP success does not verify the webpage.
```

The script accepted the valid port number and reported a failed TCP connection, distinct from the parameter-validation error for 70000. These runtime observations apply to the initial TCP-only version. The following DNS-capable revision requires learner runtime verification.

## DNS-capable revision: failed name — November 4, 2026
Learner ran the updated script with -Target portfolio-test.invalid -Port 8000 and supplied:

```text
Timestamp        : 2026-11-04T17:42:55.5633532+08:00
Target           : portfolio-test.invalid
Port             : 8000
NameResolution   : Failed
ResolvedAddress  :
TcpCheck         : Not performed
TcpTestSucceeded :
Detail           : portfolio-test.invalid : DNS name does not exist
HttpCheck        : Not performed; TCP success does not verify the webpage.
```

The revised script reported the lookup error and skipped TCP. The empty TCP result represents an unperformed check, not a failed connection. This verifies the expected invalid-name runtime path.

Next check: -Target localhost -Port 8000 while the practice server runs. Expected: IPv4 loopback resolution and successful TCP connection. Localhost resolution may be handled locally and does not establish that an external DNS server is healthy. Actual result pending.

## DNS-capable revision: localhost success — November 4, 2026
Learner ran the revised script with -Target localhost -Port 8000 and supplied:

```text
Timestamp        : 2026-11-04T17:43:57.5629612+08:00
Target           : localhost
Port             : 8000
NameResolution   : Succeeded
ResolvedAddress  : 127.0.0.1
TcpCheck         : Performed
TcpTestSucceeded : True
Detail           : TCP connection opened.
HttpCheck        : Not performed; TCP success does not verify the webpage.
```

The successful local name-resolution and TCP paths are verified by learner-provided output. This does not establish external DNS health or HTTP content. Next check: -Target localhost -Port 8001 to verify that the revised script preserves name-resolution success while reporting a failed connection. Actual result pending.

## DNS-capable revision: successful lookup, failed TCP — November 4, 2026
Learner ran the revised script with -Target localhost -Port 8001 and supplied:

```text
Timestamp        : 2026-11-04T17:44:52.4998312+08:00
Target           : localhost
Port             : 8001
NameResolution   : Succeeded
ResolvedAddress  : 127.0.0.1
TcpCheck         : Performed
TcpTestSucceeded : False
Detail           : TCP connection failed; this alone does not identify the cause.
HttpCheck        : Not performed; TCP success does not verify the webpage.
```

The revised script successfully distinguishes name resolution from connection success. Runtime evidence now covers invalid name with skipped TCP, localhost with TCP success, and localhost with TCP failure. Upper-bound port validation was exercised on the initial version; the same ValidateRange declaration remains in the revision. IP-literal runtime checks were performed on the initial version only. Final learner explanation is recorded in the project README.
