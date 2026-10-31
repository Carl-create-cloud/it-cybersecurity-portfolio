# Day 1: Know your environment and write your first note

Goal: explain the host/guest distinction, inspect basic information, and write an honest session record. No VM configuration changes or scans today.

## Concepts

Windows is the host OS. VirtualBox runs virtual machines. Kali is a guest OS. Each OS has its own processes, files, and network configuration. `127.0.0.1` means the machine on which the command runs; Kali's loopback address is not Windows's loopback address.

An IP address identifies a network interface; a TCP/UDP port identifies a transport endpoint. A client requests a service and a server provides it. DNS translates names into records such as IP addresses. A successful TCP connection does not prove an application is healthy.

## Windows practice

Run each line separately in PowerShell after reading the explanation:

```powershell
Get-Location
Get-ChildItem -LiteralPath 'C:\Cybersecurity_RedTeam_Learning\portfolio'
$PSVersionTable.PSVersion
```

`Get-Location` shows the current folder. `Get-ChildItem` lists the portfolio files without modifying them. `$PSVersionTable.PSVersion` reports the PowerShell version. Save a brief explanation of the output, not personal paths copied unnecessarily.

Open VirtualBox Manager and inspect Kali's Settings > Network. Record the attachment mode for every enabled adapter, whether Kali is running, and whether Metasploitable appears in the VM list. Do not start Metasploitable yet. Also note the host's RAM and available disk space using Windows Settings/Task Manager/File Explorer. These observations determine the lab plan.

## Documentation exercise

Copy templates/session-note.md to projects/01-network-troubleshooting/notes/day-01.md (create the notes folder). Fill in what you actually did, one confusing term, and your next step. Mark remaining items as pending.

Answer in your own words:
1. What is the difference between Windows, VirtualBox, and Kali?
2. What is the difference between an IP address and a port?
3. Why might a reachable TCP port still serve a broken website?

Finish when you can explain the commands and have a short saved note. Ask for review before moving on if the concepts remain unclear.
