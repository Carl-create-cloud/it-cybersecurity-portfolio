# Project 03: Isolated lab security assessment

Status: completed with guidance.

## Objective

Inventory the exposed services of one intentionally vulnerable lab machine and investigate one security weakness. Produce an evidence-based finding with a bounded impact statement, remediation guidance, and explicit validation limits.

## Investigation question

What services are exposed within the isolated lab, and what additional evidence is required to substantiate one suspected weakness?

## Environment and scope

Record the owned target VM, its lab address, tester VM, allowed actions, time window, and stop conditions. Use an isolated VirtualBox Internal Network for the vulnerable target and test VM during the exercise; confirm every adapter, including additional adapters, and ensure the vulnerable target has no bridged/NAT path to normal networks. Record checks and a network diagram before starting assessment. Plan recovery using a snapshot or known clean copy.

Keep internet research separate from the isolated exercise. Exclude external hosts, credential reuse, persistence, denial of service, and unrelated data access.

## Methodology

1. Inspect existing VM configuration and resources with the tutor; establish isolation and recovery.
2. Record tool versions, lab diagram, exact authorized target, and scope.
3. Use a narrowly scoped Nmap service inventory against that single target after learning the chosen options. Save reviewed output and explain open/closed/filtered states.
4. Select one weakness supported by observations. Research the exact service/version or configuration using primary sources; a banner alone is not a confirmed finding.
5. Validate with the least intrusive lab check that establishes the claim. If validation is incomplete, label the finding unconfirmed and explain what is missing.
6. Write impact in terms of what the evidence supports, recommend a specific fix, and describe how to verify it. Only claim remediation was tested if it actually was.

## Acceptance criteria

- [x] Scope, lab isolation evidence, and recovery procedure.
- [x] Service inventory with commands and interpretation.
- [x] One supported finding using the finding template; no invented severity score.
- [x] Clear remediation and validation instructions, with tested/untested status.
- [x] Results, limitations, and assistance documented.

## Results and limitations

The [report](report.md) records three open TCP ports and a confirmed anonymous FTP login. Downloads, uploads, and sensitive-data exposure were not tested. The configuration change did not prevent login; no successful fix is claimed. This historical intentionally vulnerable VM is a learning target; its weaknesses do not establish that modern systems behave the same way.

## References

- [Nmap reference guide](https://nmap.org/book/man.html).
