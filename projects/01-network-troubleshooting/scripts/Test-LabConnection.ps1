<#
Small Windows PowerShell lab diagnostic. TCP probes are restricted to 127.0.0.1.
Examples:
  .\Test-LabConnection.ps1 -Port 8000
  .\Test-LabConnection.ps1 -Port 8001
  .\Test-LabConnection.ps1 -Target portfolio-test.invalid -Port 8000
  .\Test-LabConnection.ps1 -Target localhost -Port 8000
Name lookups may contact the configured DNS resolver. No settings are changed.
No HTTP request is made. IPv6 and arbitrary remote targets are out of scope.
#>
[CmdletBinding()]
param(
    [ValidateSet('127.0.0.1', 'localhost', 'portfolio-test.invalid')]
    [string]$Target = '127.0.0.1',

    [ValidateRange(1, 65535)]
    [int]$Port = 8000
)

$result = [ordered]@{
    Timestamp        = (Get-Date).ToString('o')
    Target           = $Target
    Port             = $Port
    NameResolution   = 'Not needed: IP address supplied'
    ResolvedAddress  = $null
    TcpCheck         = 'Not performed'
    TcpTestSucceeded = $null
    Detail           = ''
    HttpCheck        = 'Not performed; TCP success does not verify the webpage.'
}

$address = '127.0.0.1'
if ($Target -ne '127.0.0.1') {
    try {
        # A records contain IPv4 addresses. Stop lets catch report lookup errors.
        $records = @(Resolve-DnsName -Name $Target -Type A -DnsOnly -ErrorAction Stop)
        $addresses = @($records | Where-Object { $_.Type -eq 'A' } | Select-Object -ExpandProperty IPAddress)
        if ($addresses.Count -eq 0) {
            throw 'No IPv4 address was returned.'
        }
        $result.NameResolution = 'Succeeded'
        $result.ResolvedAddress = $addresses -join ', '
    }
    catch {
        $result.NameResolution = 'Failed'
        $result.Detail = $_.Exception.Message
        [pscustomobject]$result
        return
    }

    # Never probe an address outside the intended loopback exercise.
    if ($Target -ne 'localhost' -or $addresses -notcontains '127.0.0.1') {
        $result.Detail = 'Lookup returned an address, but this target is outside the allowed TCP scope.'
        [pscustomobject]$result
        return
    }
}

$result.ResolvedAddress = $address
try {
    $connection = Test-NetConnection -ComputerName $address -Port $Port -WarningAction SilentlyContinue -ErrorAction Stop
    $result.TcpCheck = 'Performed'
    $result.TcpTestSucceeded = $connection.TcpTestSucceeded
    if ($connection.TcpTestSucceeded) {
        $result.Detail = 'TCP connection opened.'
    }
    else {
        $result.Detail = 'TCP connection failed; this alone does not identify the cause.'
    }
}
catch {
    $result.TcpCheck = 'Error'
    $result.Detail = $_.Exception.Message
}
[pscustomobject]$result
