# Password Generator
    # Function Supply ASCII Decimal
        function Get-RandomChar {
        $getRandom = Get-Random -Minimum 33 -Maximum 126

        return [char]$getRandom
        }
    # Function Generate Password
        function Get-RandomConc {
        $passed1 = "$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)"
        $passed2 = "$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)"
        $passed3 = "$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)"
        $passed4 = "$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)$(Get-RandomChar)"
    
        $passed = "$passed1$passed2$passed3$passed4"

        $passed | clip

        return [System.Windows.MessageBox]::Show("Copied to clipboard: $passed")
        }