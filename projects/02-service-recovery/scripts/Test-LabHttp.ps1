param(
    [ValidateSet('/', '/missing-page.html')]
    [string]$Path = '/'
)
# Learning version: fresh local request, HTTP status, and expected content marker.
$uri = 'http://127.0.0.1:8000' + $Path

# Exit code 0 means the lab health criteria passed; 1 means failure.
$exitCode = 1

try {
    $response = Invoke-WebRequest -Uri $uri -UseBasicParsing -TimeoutSec 5 -ErrorAction Stop
    $http200 = ($response.StatusCode -eq 200)
    $expectedContentFound = $response.Content.Contains('Project 02 service is running')
    if ($http200 -and $expectedContentFound) { $exitCode = 0 }
    [pscustomobject]@{
        Uri = $uri
        RequestResult = 'Response received'
        StatusCode = [int]$response.StatusCode
        Http200 = $http200
        ExpectedContentFound = $expectedContentFound
        Healthy = ($http200 -and $expectedContentFound)
        ErrorDetail = $null
    }
}
catch {
    # An HTTP error can have a response; other request failures may not.
    $errorResponse = $_.Exception.Response
    $statusCode = $null
    $requestResult = 'Request failed without HTTP response'
    if ($null -ne $errorResponse) {
        $statusCode = [int]$errorResponse.StatusCode
        $requestResult = 'HTTP error response'
    }
    [pscustomobject]@{
        Uri = $uri
        RequestResult = $requestResult
        StatusCode = $statusCode
        Http200 = ($statusCode -eq 200)
        ExpectedContentFound = $null
        Healthy = $false
        ErrorDetail = $_.Exception.Message
    }
}

exit $exitCode
