'Question 1
Private Sub LECTURE_Click()
Dim db AS Database
Dim tb_agence AS Recordset
Set db = CurrentDb()
Set tb_agence = db.OpenRecordset("SELECT * FROM AGENCE", dbOpenDynaset)
While Not tb_agence.EOF
    MsgBox tb_agence("Ville")
    tb_agence.MoveNext
    
WEND
db.Close
End Sub
'QUestion 2
Private Sub INSERTION_dblClick()
Dim db AS Database
Dim tb_agence AS Recordset
Dim tb_agence_TOURS AS Recordset
Dim tb_ville AS Recordset
Set db = CurrentDb()
Set tb_agence = db.OpenRecordset("SELECT * FROM AGENCE", dbOpenDynaset)
Set tb_agence_TOURS = db.OpenRecordset("SELECT * FROM AGENCE WHERE CODE='AG007'", dbOpenDynaset)
Set tb_ville = db.OpenRecordset("SELECT * FROM VILLE WHERE VILLE='TOURS'", dbOpenDynaset)
If tb_agence_code.EOF Then
    If tb_ville.EOF Then
        'Tours nexiste pas donc on créer Tours
        tb_ville.AddNew
        tb_ville("VILLE") = "TOURS"
        tb_ville("XMIN") = 1000
        tb_ville("XMAX") = 2000
        tb_ville("YMIN") = 3000
        tb_ville("YMAX") = 4000
        tb_ville.Update
    End If
    tb_agence.AddNew
    tb_agence("CODE") = "AG007"
    tb_agence("VILLE") = "TOURS"
    tb_agence.Update
Else 
    MsgBox "Clé primaire prise"
End If
db.Close
End Sub