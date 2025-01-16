Add-Type -AssemblyName System.Windows.Forms

# Registry Paths and Key
$RegistryPaths = @(
    "HKLM:\SOFTWARE\Policies\Google\Chrome",        # Chrome
    "HKLM:\SOFTWARE\Policies\Microsoft\Edge",       # Edge
    "HKLM:\SOFTWARE\Policies\BraveSoftware\Brave-Browser" # Brave
)
$RegistryKey = "ExtensionManifestV2Availability"

# Check for administrative privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell -ArgumentList "-File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit
}

# Ensure the registry paths exist
foreach ($RegistryPath in $RegistryPaths) {
    if (-not (Test-Path $RegistryPath)) {
        Write-Host "Creating registry path: $RegistryPath"
        New-Item -Path $RegistryPath -Force | Out-Null
    }
}

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Manifest v2"
$form.Size = New-Object System.Drawing.Size(400, 200)
$form.StartPosition = "CenterScreen"
$form.ForeColor = [System.Drawing.Color]::White
$form.BackColor = [System.Drawing.Color]::FromArgb(255, 25, 25, 25)
$form.MaximizeBox = $false
$form.MinimizeBox = $false
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog

# Define a label to display the selected key value
$label = New-Object System.Windows.Forms.Label
$label.Text = "Registry Key Value: None"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(80, 20)
$form.Controls.Add($label)

# Function to update the registry key value
function Set-RegistryKeyValue {
    param ($value)
    foreach ($RegistryPath in $RegistryPaths) {
        try {
            Set-ItemProperty -Path $RegistryPath -Name $RegistryKey -Value $value -Force
            $label.Text = "Registry Key Value: $value"
        } catch {
            $label.Text = "Error: Failed to set the registry key."
        }
    }
}

# Create Button for Value 0
$button0 = New-Object System.Windows.Forms.Button
$button0.Text = "Default browser behavior"
$button0.Size = New-Object System.Drawing.Size(80, 80)
$button0.Location = New-Object System.Drawing.Point(10, 60)
$button0.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$button0.BackColor = [System.Drawing.Color]::SlateGray
$button0.Add_Click({
    Set-RegistryKeyValue -value 0
})
$form.Controls.Add($button0)

# Create Button for Value 1
$button1 = New-Object System.Windows.Forms.Button
$button1.Text = "DISABLE Manifest v2 Extensions"
$button1.Size = New-Object System.Drawing.Size(80, 80)
$button1.Location = New-Object System.Drawing.Point(100, 60)
$button1.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$button1.BackColor = [System.Drawing.Color]::FromArgb(125, 0, 0)
$button1.Add_Click({
    Set-RegistryKeyValue -value 1
})
$form.Controls.Add($button1)

# Create Button for Value 2
$button2 = New-Object System.Windows.Forms.Button
$button2.Text = "ENABLE Manifest v2 Extensions"
$button2.Size = New-Object System.Drawing.Size(80, 80)
$button2.Location = New-Object System.Drawing.Point(200, 60)
$button2.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$button2.BackColor = [System.Drawing.Color]::DarkGreen
$button2.Add_Click({
    Set-RegistryKeyValue -value 2
})
$form.Controls.Add($button2)

# Create Button for Value 3
$button3 = New-Object System.Windows.Forms.Button
$button3.Text = "Manifest v2 is Enabled for forced extensions only"
$button3.Size = New-Object System.Drawing.Size(80, 80)
$button3.Location = New-Object System.Drawing.Point(300, 60)
$button3.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$button3.BackColor = [System.Drawing.Color]::SteelBlue
$button3.Add_Click({
    Set-RegistryKeyValue -value 3
})
$form.Controls.Add($button3)

# Show the form
$form.Add_Shown({ $form.Activate() })
[void]$form.ShowDialog()
