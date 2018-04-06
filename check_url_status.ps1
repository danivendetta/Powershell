# Description: Check if a URL is responding fine
# Autor: danivendetta
# Version: 0.1
# Date: 06/04/2018
# Sometimes the URL is only accesible from intranet or localhost, so this script is util in this cases to check with nagios.
$url= "YOUR URL GOES HERE"
$responseTime = Measure-Command { $response=Invoke-WebRequest $url -UseDefaultCredentials}

$milliseconds = $responseTime.Milliseconds

if ($response.StatusCode -eq 200) {

    #Write-Host "Status code is good"
    #write-host "response time is $milliseconds milliseconds"

    if ($milliseconds -le 5000 ){

        Write-Host "the response time is less than 5 Seconds"
        $status="OK"
        exit 0
    }

    elseif ($milliseconds -ge 5000 -and $milliseconds -le 15000){

        Write-Host "The response time is between 5 and 15 seconds, please check performance"
        $status="WARNING"
        exit 1
    else {

        Write-Host "The response time is so BIG :S, please, can you check performance of this server and the sql server?? ty"
        $status="CRITICAL"
        exit 2
    }

    }

else {

    Write-Host "The status code ($response.StatusCode) is wrong! can you check if service is up?? ty "
    $status="CRITICAL"
    exit 2
    }


    }

    # If we arrive at this point without enter in if, else operator, something is too bad!

    $status="UNKNOWN"
    exit 3
