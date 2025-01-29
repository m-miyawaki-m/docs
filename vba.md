Sub ExpandRowsTo22()
    Dim ws As Worksheet
    Dim lastRow As Long
    Dim i As Long
    Dim j As Integer
    Dim destRow As Long

    ' 現在のシートを取得
    Set ws = ActiveSheet

    ' 最終行を取得（データが入っている最後の行）
    lastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row

    ' 新しいデータを配置する行のカウンタ
    destRow = 1

    ' 画面更新を停止（高速化）
    Application.ScreenUpdating = False

    ' 1行ずつ処理
    For i = 1 To lastRow
        ' その行を22回コピー
        For j = 1 To 22
            ws.Rows(i).Copy
            ws.Rows(destRow).Insert Shift:=xlDown
            destRow = destRow + 1
        Next j
    Next i

    ' 画面更新を有効化
    Application.ScreenUpdating = True

    MsgBox "すべての行を22回ずつコピーしました！"
End Sub