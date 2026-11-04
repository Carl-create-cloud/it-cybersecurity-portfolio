# Ticket 03: Deliberately invalid destination name

Status: expected failure reproduced; learner identified the failed name correctly.

## Problem and expected behavior
Intentional simulation: resolve portfolio-test.invalid, a name under the reserved .invalid domain. Name resolution is expected to fail. This is not an outage requiring DNS configuration changes.

## Environment and authorized scope
Windows PowerShell on the learner's host. One name-resolution query; no target scan or configuration changes. The configured resolver may be contacted. No resolver address or packet capture was collected.

## Hypotheses and tests
Learner ran:

```powershell
Resolve-DnsName -Name portfolio-test.invalid
```

Learner supplied:

```text
Resolve-DnsName : portfolio-test.invalid : DNS name does not exist
CategoryInfo : ResourceUnavailable: (portfolio-test.invalid:String) [Resolve-DnsName], Win32Exception
FullyQualifiedErrorId : DNS_ERROR_RCODE_NAME_ERROR,Microsoft.DnsClient.Commands.ResolveDnsName
```

The requested name was reported nonexistent. This command did not attempt a TCP connection to port 8000 or test the practice web server.

## Root cause
The deliberately invalid destination name caused the expected name-resolution failure. This result is not evidence that the computer's DNS configuration is generally broken. The responding resolver and cache behavior were not independently inspected.

## Fix, rollback, and verification
No repair is needed for this intentional failure. For real troubleshooting, check the intended destination name rather than changing DNS settings based on this result alone. No configuration was changed and no rollback is required. A corrected-name lookup was not performed in this case.

## Prevention, limitations, and lessons
Distinguish lookup failures from TCP connection failures and application failures. Previous loopback-address tests bypassed the need to resolve a destination hostname. This case demonstrates an expected nonexistent-name error only; it does not validate DNS behavior for valid names.

After guided clarification, the learner correctly identified portfolio-test.invalid as the name that failed to resolve. Documentation prepared with AI assistance from learner-provided output.
