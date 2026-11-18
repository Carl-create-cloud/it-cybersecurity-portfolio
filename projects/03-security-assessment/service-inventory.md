# Initial TCP port inventory

## Method

Learner executed from Kali (192.168.77.20) against the single scoped target, Metasploitable (192.168.77.10), and supplied a screenshot for review on November 18, 2026.

```bash
nmap -sT -n -p 21,22,80 192.168.77.10
```

Nmap version: 7.94SVN. TCP connect scan; DNS lookup disabled; only the three listed ports requested.

## Observed results

| TCP port | State | Nmap conventional service label |
| --- | --- | --- |
| 21 | open | ftp |
| 22 | open | ssh |
| 80 | open | http |

Nmap reported one host up, 0.030-second host latency, and a 0.14-second scan duration. The guest scan timestamp was `2026-11-17 23:48 EST`; retained as displayed rather than treated as the host's local date/time. Guest clock synchronization has not been verified.

## Interpretation and limitations

All three tested TCP ports accepted connections at test time. Service labels in this scan are conventional port-name mappings; application identities were not established by this initial scan; subsequent probe-based identification is recorded below. Other ports and UDP were not tested. Open ports alone do not establish a vulnerability, successful authentication, or application health.

Light service/version detection was subsequently performed on these same three ports.

## Light service identification

Learner supplied output for:

```bash
nmap -sT -sV --version-light -n -p 21,22,80 192.168.77.10
```

| TCP port | State | Nmap-reported identification |
| --- | --- | --- |
| 21 | open | vsftpd 2.3.4 |
| 22 | open | OpenSSH 4.7p1 Debian 8ubuntu1 (protocol 2.0) |
| 80 | open | Apache httpd 2.2.8 ((Ubuntu) DAV/2) |

Nmap reported one host up, 0.0055-second latency, and scan duration 7.78 seconds. Displayed guest timestamp: 2026-11-17 23:59 EST. Service Info reports Unix/Linux; this is remote identification, not independent operating-system verification.

These are probe-based identifications, not verified package provenance or vulnerability findings. Subsequent login-only validation confirmed anonymous FTP acceptance; see the [finding](finding-anonymous-ftp.md). The official [ftp-anon documentation](https://nmap.org/nsedoc/scripts/ftp-anon.html) specifies that ftp-anon.maxlist=0 disables listing. File read/write permissions and sensitive-data exposure were not established by that login-only test.
