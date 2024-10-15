'PARTIE 1 DAO
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
'Question 3
Private Sub MODIFICATION_MouseMove() 
Dim db As Database 
Dim tb_agence As Recordset
Dim tb_ville As Recordset 
Set db = CurrentDb() 
Set tb_agence = db.OpenRecordset("SELECT * FROM AGENCE WHERE VILLE='TOURS'", dbOpenDynaset)
Set tb_ville = db.OpenRecordset("SELECT * FROM VILLE WHERE VILLE='POITIERS'", dbOpenDynaset) 
If Not tb_ville.EOF Then 
    If tb_ville.EOF Then
        tb_ville.AddNew
        tb_ville("VILLE") = "POITIERS"
        tb_ville("XMIN") = 1001
        tb_ville("XMAX") = 2002
        tb_ville("YMIN") = 3003
        tb_ville("YMAX") = 4004
        tb_ville.Update
    End If
    tb_ville.Edit 
    tb_ville("VILLE") = "POITIERS" 
    tb_ville.Update 
End If 
db.Close
End Sub
'Question 4 
Private Sub SUPPRESSION_Click()
Dim db As Database
Dim tb_agence As Recordset
Dim tb_ville As Recordset
Set db = CurrentDb()
Set tb_ville = db.OpenRecordset("SELECT * FROM AGENCE WHERE NOM='POITIERS'", dbOpenDynaset)
If Not tb_agence.EOF Then
    tb_ville.Delete
    tb_ville.MoveNext
End If
db.Close
End Sub
'PARTIE 2 ADO
'Initialiser les données dans la fct de l'ouverture du formulaire
'Question 1
SELECT A.AVNOM AS NOM , A.CAPACITE FROM AVION A
'Question 2
Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Private Sub Form_Load()
Set cn = CurrentProject.Connection
rs.Open"SELECT * FROM AVION A"
End Sub

Private Sub Debut_Click()
If Not rs.Eof Then
    rs.MoveFirst
    etiq.Value = "L'avion " & rs.Field("nom").Value & " a une capacité de " & rs.Field("capacite").Value
End If
End Sub

Private Sub btn_Suivant_Click()
If Not rs.Eof Then
    rs.MoveNext
    etiq.Value = "L'avion " & rs.Field("nom").Value & " a une capacité de " & rs.Field("capacite").Value
End If
End Sub

Private Sub btn_Prec_Click()
If Not rs.Bof Then
    rs.MovePrevious
    If Not rs.Bof Then
        etiq.Value = "L'avion " & rs.Field("nom").Value & " a une capacité de " & rs.Field("capacite").Value
    End If
End If
End Sub

Private Sub btn_Fin_Click()
if Not rs.Eof Then
    rs.MoveLast
    etiq.Value = "L'avion " & rs.Field("nom").Value & " a une capacité de " & rs.Field("capacite").Value
End If
End Sub