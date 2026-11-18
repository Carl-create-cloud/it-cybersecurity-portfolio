# Lab scope and setup evidence

## Scope

This learner-owned lab assessment is limited to Metasploitable2-Portfolio at 192.168.77.10, tested from Kali at 192.168.77.20 during supervised learning sessions beginning November 18, 2026. Recheck addressing and isolation after reboot or configuration changes.

Permitted initial activity: ICMP connectivity checks and a limited TCP port inventory. Subsequent guided activity included service identification, login-only anonymous FTP checks, a backed-up configuration edit, xinetd restart, and brief local tracing. No listing or file transfer was performed. Excluded: external hosts, subnet-wide scans, credential reuse, persistence, denial of service, and unrelated data access. Stop if the target identity or isolation is uncertain, unexpected systems respond, or either VM or host becomes unstable.

## Network diagram

```text
Kali eth0                         Metasploitable eth0
192.168.77.20/24                  192.168.77.10/24
       |                                 |
       +--- Internal Network: portfolio-lab ---+
       No NAT or bridged adapter on either VM
```

## Verified setup

Evidence below is based on learner-supplied terminal output and screenshots reviewed on November 18, 2026.

- Both VMs: saved Adapter 1 internal network portfolio-lab, cable connected; adapters 2-8 disabled. Checked while powered off before startup.
- Kali: 2048 MB RAM; target: 512 MB RAM. Pre-start host available memory was 4.58 GiB; simultaneous runtime headroom has not been measured.
- Both guests reached interactive sessions. Temporary IPv4 addresses match the diagram; both displayed only a directly connected IPv4 lab-subnet route, with no default route.
- Kali ping to 192.168.77.10: four transmitted, four received, 0% loss. This establishes ICMP reachability, not TCP service availability.
- Nmap reports 7.94SVN on x86_64-pc-linux-gnu. Results are recorded in the [service inventory](service-inventory.md).

## Recovery

The target has a verified snapshot named `01 - Isolated pre-boot baseline`, created before first lab boot. Its original virtual disk was preserved separately; the working copy matched the original SHA256 before attachment.

If recovery is needed, preserve any needed evidence, shut down the target, then restore the named target snapshot in VirtualBox. Restoration discards subsequent changes to the restored state; review what must be kept before confirming. Recheck all network adapters before booting and reapply temporary addressing afterward. Snapshot restoration has not been tested. Do not restore Kali's older snapshot without rechecking its network and memory configuration.

## Limitations

Addresses are temporary, not configured to persist across reboot. IPv6 routing and unrelated membership on the named internal network have not been inventoried. Saved adapter settings and guest IPv4 routing checks support the intended isolation; ping alone does not prove isolation. Service and authentication results are documented separately in the [finding](finding-anonymous-ftp.md). Raw screenshots and VM disks remain outside the repository.

## Resumed session and cleanup

On November 18, saved internal-only adapters were rechecked before boot. Learner-reported available host memory reached 5.01 GiB. Both temporary guest IPv4 addresses were restored and verified, with connected lab routes and no default IPv4 route. Kali received four replies from the target with 0% loss. After the login-only trace, FTP session closure and tracer detachment were observed. The learner reported shutting down both guests; a subsequent host-side VirtualBox inventory listed no running VMs. Configuration changes and evidence were preserved; no snapshot restoration occurred.
