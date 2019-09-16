# FROM https://foxdeploy.com/2015/04/16/part-ii-deploying-powershell-guis-in-minutes-using-visual-studio/

function Initialize-XAMLGUI {
    #===========================================================================
    # Shows the form
    #===========================================================================
    #write-host "To show the form, run the following" -ForegroundColor Cyan
    $Global:Form.ShowDialog() | out-null
}

#Export-ModuleMember -Function Initialize-XAMLGUI