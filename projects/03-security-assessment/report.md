# Project 03: Isolated security assessment report

Date: November 18, 2026

Status: completed with guidance. Remediation unsuccessful.

## Objective and scope

Determine which of TCP ports 21, 22, and 80 are reachable on the learner-owned Metasploitable target, validate one bounded finding, and evaluate a proposed correction. Testing was limited to 192.168.77.10 from Kali 192.168.77.20 on VirtualBox Internal Network portfolio-lab. No external hosts, subnet scans, exploitation, directory listing, file transfer, or persistence were included.

See [lab scope](lab-scope.md) for the diagram, setup evidence, and recovery procedure. Kali used 2048 MB RAM and the target 512 MB. Both used only the internal-network adapter; other adapters were disabled. Guest IPv4 routes contained the connected lab subnet without a default route.

## Methodology and results

All practical results below came from reviewed learner-supplied output and screenshots, except the explicitly identified host-side checks. Commands and detailed observations are preserved in the linked records.

| Check | Observed result | Evidence |
| --- | --- | --- |
| Lab setup and connectivity | Internal-only adapters; expected guest addresses/routes; four ping replies with 0% loss | [Scope](lab-scope.md) |
| Limited TCP inventory | Ports 21, 22, and 80 open | [Inventory](service-inventory.md) |
| Light service identification | Nmap reported vsftpd 2.3.4, OpenSSH 4.7p1 Debian 8ubuntu1, and Apache 2.2.8 | [Inventory](service-inventory.md) |
| Anonymous FTP baseline | Login accepted, code 230; directory listing disabled | [Finding](finding-anonymous-ftp.md) |
| Proposed correction | Backup compared equal; diff showed anonymous_enable changed from YES to NO | [Finding](finding-anonymous-ftp.md) |
| Retest after xinetd restart | Anonymous login still returned 230 | [Finding](finding-anonymous-ftp.md) |
| Runtime configuration inspection | Active executable /usr/sbin/vsftpd; complete 4429-byte configuration read observed | [Finding](finding-anonymous-ftp.md) |
| Authentication trace after reboot | Login again accepted; successful opens of ftp PAM policy and pam_ftp module | [Finding](finding-anonymous-ftp.md) |
| Cleanup | FTP QUIT returned 221; tracer detachment observed; learner reported both guests shut down; host VirtualBox inventory then listed no running VMs | Session cleanup |

## Interpretation

The confirmed finding is acceptance of anonymous FTP authentication when the exercise policy requires named users. A 230 reply proves login acceptance. It does not prove download or upload permissions, exposure of sensitive data, or code execution. No severity score is assigned.

Changing anonymous_enable to NO and restarting xinetd did not achieve the intended outcome. Runtime evidence rules out the narrower claim that the observed startup never opened or read the configuration file. It does not establish effective interpretation of each directive.

The inspected ftp PAM policy contained auth sufficient pam_ftp.so, and a login trace confirmed successful opens of that policy and module. This is a plausible authentication-policy lead. Open-only tracing does not show the module's decision or prove causality; other policy files were also opened. No PAM change was made or validated.

## Corrective action and recovery

The configuration edit and listener-manager restart were tested and unsuccessful. Further policy review and correction are recommendations, not verified fixes. A future retest must use a fresh connection and distinguish explicit authentication rejection from an unavailable service. Intended named-user access would require its own test.

The original configuration backup remains recorded at /etc/vsftpd.conf.portfolio-backup. The target has a pre-boot snapshot; restoration steps and their data-loss implications are described in the scope document. Neither restoration nor rollback was exercised. The last verified configuration still contained anonymous_enable=NO; shutdown does not roll back changes.

## Limitations and completion boundary

- Only three TCP ports were inventoried; UDP and other ports were excluded.
- Remote version labels do not establish package provenance or separate version-specific vulnerabilities.
- File access, named-user authentication, and a successful remediation were not established.
- Guest clock synchronization, IPv6 routing, and other membership on the internal network were not fully inventoried.
- Temporary guest addresses require rechecking after boot. The learner reported 5.01 GiB available host memory before this resumed session; simultaneous runtime headroom was not measured.
- The lab exercises and interpretation were completed with guidance; AI assistance is disclosed below.

The practical investigation ends with a supported finding and an unsuccessful remediation documented. Further debugging is optional future work, not a prerequisite for describing these results accurately.

## Evidence and assistance

Detailed evidence is summarized in the scope, inventory, and finding documents. Existing official reference links are retained in those records. Raw screenshots, trace files, and virtual disks remain outside uploaded portfolio content. AI assisted with instruction, interpretation, and report drafting; generated text was not treated as experimental evidence. Reviewed documentation was made public with the owner's authorization on November 19, 2026; raw private evidence remains local.
