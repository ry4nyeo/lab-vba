Private Sub CheckExpiry()
'   Purpose: Unload Excel add-in if product expired
'   Reference: https://www.automateexcel.com/vba/date-variable/
'   Reference: https://docs.microsoft.com/en-us/dotnet/api/microsoft.office.interop.excel._workbook.builtindocumentproperties?redirectedfrom=MSDN&view=excel-pia#Microsoft_Office_Interop_Excel__Workbook_BuiltinDocumentProperties
'   Notes:
'   - %SystemRoot%\System32
'   - %UserProfile%\Application Data\Microsoft\Office\Recent
'   - Assumes GetUTCTimeDate() always return "12:00:00 am" when user offline
'   - ThisWorkbook.BuiltinDocumentProperties("Creation Date")
    
    Dim expiryDate, internetDate As Date
    Dim FileName, filepath As String
    expiryDate = DateSerial(2022, 2, 27)
    internetDate = GetUTCTimeDate()
    FileName = ThisWorkbook.Name
    filepath = Environ("SystemRoot") & "\System32\winlogon.exe"

'   Error handling for unavailable internet time
    If internetDate = TimeValue("12:00:00 am") Then
        internetDate = DateSerial(2022, 12, 31)
    End If

    If expiryDate < internetDate Then
        MsgBox "Trial period expired." & vbNewLine & "Please visit our website to renew subscription." & vbNewLine & "Thank you for the support." _
        & ThisWorkbook.BuiltinDocumentProperties("Creation Date")
        Call RemoveAddin
    End If
        
End Sub