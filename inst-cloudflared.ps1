

	# Set the download URL and file name
	$downloadUrl = "https://example.com/application.msi"
	$fileName = "application.msi"

	# Set the installation arguments
	# for .msi
	$installArgs = "/i $fileName /quiet"
	# for .exe
	#$installArgs = "/S /v`"/qn`""
	
	# Download the MSI file
	Try {
	    $client = New-Object System.Net.WebClient
	    $client.DownloadFile($downloadUrl, $fileName)
	}
	Catch {
	    Write-Host "Failed to download MSI file from $downloadUrl"
	    exit 1
	}
	
	# Install the MSI file
	# for .exe file replace msi.exe with "$fileName" ..
	Try {
	    $process = Start-Process msiexec.exe -ArgumentList $installArgs -Wait -Passthru
	    If ($process.ExitCode -ne 0) {
	        Write-Host "Failed to install MSI file"
	        exit 1
	    }
	}
	Catch {
	    Write-Host "Failed to install MSI file"
	    exit 1
	}

	Write-Host "Installation complete."