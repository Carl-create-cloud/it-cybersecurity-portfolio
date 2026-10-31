# Project 03: Isolated lab security assessment

Status: planned; VM networking, isolation, and target readiness are unverified. No findings yet.

## Problem and value

A system owner needs a clear inventory of exposed services and an understandable explanation of one security weakness. Practice scoping, observation, validation, impact analysis, and reporting.

## Scope before activity

Record the owned target VM, its lab address, tester VM, allowed actions, time window, and stop conditions. Use an isolated VirtualBox Internal Network for the vulnerable target and test VM during the exercise; confirm every adapter, including additional adapters, and ensure the vulnerable target has no bridged/NAT path to normal networks. Record checks and a network diagram before starting assessment. Plan recovery using a snapshot or known clean copy.

Keep internet research separate from the isolated exercise. Exclude external hosts, credential reuse, persistence, denial of service, and unrelated data access.

## Build in small steps

1. Inspect existing VM configuration and resources with the tutor; establish isolation and recovery.
2. Record tool versions, lab diagram, exact authorized target, and scope.
3. Use a narrowly scoped Nmap service inventory against that single target after learning the chosen options. Save reviewed output and explain open/closed/filtered states.
4. Select one weakness supported by observations. Research the exact service/version or configuration using primary sources; a banner alone is not a confirmed finding.
5. Validate with the least intrusive lab check that establishes the claim. If validation is incomplete, label the finding unconfirmed and explain what is missing.
6. Write impact in terms of what the evidence supports, recommend a specific fix, and describe how to verify it. Only claim remediation was tested if it actually was.

## Definition of done

- [ ] Scope, lab isolation evidence, and recovery procedure.
- [ ] Service inventory with commands and interpretation.
- [ ] One supported finding using the finding template; no invented severity score.
- [ ] Clear remediation and validation instructions, with tested/untested status.
- [ ] Limitations and a five-minute learner explanation.

This historical intentionally vulnerable VM is a learning target; its weaknesses do not establish that modern systems behave the same way.

Reference: [Nmap reference guide](https://nmap.org/book/man.html).
