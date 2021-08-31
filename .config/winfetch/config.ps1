# ===== WINFETCH CONFIGURATION =====

# $image = "~/winfetch.png"
# $noimage = $true

# Switch the default Windows logo
# $switchlogo = $true

# Make the logo blink
# $blink = $true

# Display all built-in info segments.
# $all = $true

# Add a custom info line
# function info_wheater {
#     return @{
#         title = "Wheater"
#         content = (Invoke-RestMethod https://wttr.in?format=2)
#     }
# }

# Configure which disks are shown
# $ShowDisks = @("C:", "D:")
# Show all available disks
# $ShowDisks = @("*")

# Configure which package managers are shown
# disabling unused ones will improve speed
# $ShowPkgs = @("scoop", "choco")

# Configure how to show info for levels
# Default is for text only.
# 'bar' is for bar only.
# 'textbar' is for text + bar.
# 'bartext' is for bar + text.
# $cpustyle = 'bar'
$memorystyle = 'bartext'
$diskstyle = 'bartext'
# $batterystyle = 'bartext'


# Remove the '#' from any of the lines in
# the following to **enable** their output.

@(
    "title"
    "dashes"
    "os"
    # "computer"
    "kernel"
    # "motherboard"
    # "custom_time"  # use custom info line
    "uptime"
    # "wheater"
    "pkgs"
    "pwsh"
    # "resolution"
    "terminal"
    # "theme"
    "cpu"
    "gpu"
    # "cpu_usage"  # takes some time
    "memory"
    "disk"
    "battery"
    # "locale"
    # "local_ip"
    # "public_ip"
    "blank"
    "colorbar"
)
