# Finding: Anonymous FTP login accepted

Status: anonymous login confirmed; remediation attempted and unsuccessful. Runtime cause unresolved. Investigation closed for this project scope with limitations documented.

## Scope and affected asset

Owned Metasploitable2-Portfolio at 192.168.77.10, TCP port 21, tested from Kali 192.168.77.20 on Internal Network portfolio-lab. See [scope and setup](lab-scope.md) and [service inventory](service-inventory.md).

## Summary and evidence

Nmap 7.94SVN reported successful anonymous FTP authentication. Learner supplied the command and result in a screenshot reviewed November 18, 2026:

```bash
nmap -sT -n -p 21 --script ftp-anon --script-args ftp-anon.maxlist=0 192.168.77.10
```

```text
21/tcp open ftp
|_ftp-anon: Anonymous FTP login allowed (FTP code 230)
```

Guest scan timestamp: 2026-11-18 00:02 EST. One host up; scan duration 0.33 seconds. Directory listing was disabled explicitly. No file transfers or write tests were requested.

## Impact and confidence

The service accepted an anonymous session without an individually assigned account. This supports a configuration finding if access is intended to be restricted to named users. Anonymous FTP can also be intentional for public distribution; login acceptance alone does not establish inappropriate data exposure.

No sensitive-file access, upload capability, code execution, or external exposure was demonstrated. No severity score is assigned. The earlier vsftpd version identification does not establish any separate version-specific vulnerability.

## Remediation

The tested change was anonymous_enable=NO, followed by an xinetd restart. Fresh anonymous logins remained accepted. No further PAM policy change was performed. Future corrective work should review the effective FTP authentication policy in the isolated lab, preserve backups, and retest both anonymous rejection and any intended named-user access. These follow-up corrections are untested.

## Verification

Repeated fresh logins returned 230 after the edit, restart, and subsequent reboot. A future successful fix must produce explicit authentication rejection on a reachable FTP service; connection failure alone is not a pass. Named-user access was not tested.

## Limitations and references

These were login-only checks against an intentionally vulnerable isolated target. Permissions after login were not tested. Guest clock synchronization is unverified.

- [Nmap ftp-anon documentation](https://nmap.org/nsedoc/scripts/ftp-anon.html): script purpose and maxlist=0 behavior.

## Configuration evidence and proposed correction

Learner ran grep -n anonymous_enable /etc/vsftpd.conf on Metasploitable and supplied 12:anonymous_enable=YES. This uncommented setting is consistent with observed remote anonymous login acceptance; the running process configuration path was not independently inspected.

For this remediation exercise, the intended policy will prohibit anonymous FTP login. The proposed correction is anonymous_enable=NO, followed by applying the configuration through the target service manager and retesting remote login. Preserve the original configuration before editing. Anonymous clients would lose access; disabling anonymous login does not establish that named-user access works or that the historical target is otherwise secure.

The [upstream vsftpd configuration manual](https://security.appspot.com/vsftpd/vsftpd_conf.html) documents anonymous_enable as the control for anonymous login. This was the initial proposal; execution and failed retests are recorded below. A retest must distinguish explicit authentication rejection from an unavailable service or missing script output.

## Remediation execution evidence

Learner created /etc/vsftpd.conf.portfolio-backup with cp -p -i and verified it with cmp, followed immediately by exit status 0. The subsequent edit and comparison were:

```bash
sudo sed -i 's/^anonymous_enable=YES$/anonymous_enable=NO/' /etc/vsftpd.conf
sudo diff -u /etc/vsftpd.conf.portfolio-backup /etc/vsftpd.conf
```

Reviewed diff shows only anonymous_enable=YES changed to anonymous_enable=NO. The on-disk edit is verified. Subsequent restart and remote retests are recorded below; no successful remediation is claimed.

## Post-edit retest: anonymous access remains enabled

The attempted /etc/init.d/vsftpd restart failed with command not found. The inspected /etc/xinetd.d/vsftpd definition enables service ftp and names /usr/sbin/vsftpd, with server_args commented out. This definition alone does not establish which process currently owns the listener.

Learner opened a fresh connection from Kali using nc -nv 192.168.77.10 21 and supplied this exchange:

```text
220 (vsFTPd 2.3.4)
USER anonymous
331 Please specify the password.
PASS portfolio@example.invalid
230 Login successful.
```

The dummy password is a test value, not a personal credential. This retest confirms the proposed fix has not taken effect: anonymous login is still accepted. Effective configuration and running-process control remain under investigation. No file listing or transfer was performed. Finding remains confirmed and unresolved.

## Listener-manager restart

Further learner output identified xinetd as the owner of TCP port 21. The saved anonymous_enable=NO setting was rechecked, and the legacy /etc/inetd.conf FTP entry was commented out. Learner then ran sudo /etc/init.d/xinetd restart: stop and start each reported OK, and immediate exit status was 0. The post-restart authentication result is recorded below; the earlier failed retest remains valid evidence. Root cause of that failed retest has not been established.

## Post-restart retest: unresolved

After the verified xinetd restart, the learner opened a new netcat connection and repeated USER anonymous and PASS portfolio@example.invalid. The server again returned 230 Login successful after its 220 greeting and 331 password request. Anonymous access remains confirmed; the remediation attempt is unsuccessful. Restarting the listener manager alone did not resolve the observed behavior. Runtime process/configuration evidence follows below. No files were listed or transferred.

## Runtime investigation evidence — November 18, 2026

Subsequent learner-supplied evidence established that the active FTP process executable was /usr/sbin/vsftpd with filesystem root /. A startup trace showed a successful open and a complete 4429-byte read of /etc/vsftpd.conf. The inspected anonymous_enable directive contained NO followed by a newline; file metadata showed a regular root-owned file with permissions 0644. These observations do not establish effective interpretation of each setting.

After reboot and re-verification of internal-only lab networking and guest IPv4 addressing/routes, a fresh anonymous login again returned 230 Login successful. QUIT returned 221 Goodbye. No directory listing or file transfer was performed.

An open-only trace during that login showed PID 5082 successfully opening /etc/pam.d/ftp and /lib/security/pam_ftp.so, returning descriptors 5 and 6 respectively. It also accessed shared PAM policy files and /etc/pam.d/other. The previously inspected ftp policy contained auth sufficient pam_ftp.so. This supports an authentication-policy lead; file-open evidence alone does not prove module return values or which rule granted access. All traced processes were observed detached afterward.

Current disposition: anonymous login confirmed; attempted remediation unsuccessful; authentication cause remains unresolved. No PAM policy change has been tested. Further remediation is outside the completed practical investigation.
