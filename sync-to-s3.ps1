# sync-to-s3.ps1
$bucket = "mys3stack-myuniquebucketid3bf06e4b-ccywfcuhyuok"
$zipFile = "mywebsite-artifact.zip"

# Удаляем старый ZIP, если он есть
if (Test-Path $zipFile) {
    Remove-Item $zipFile
}

# Упаковываем все файлы (кроме .git)
Get-ChildItem -Exclude ".git" | Compress-Archive -DestinationPath $zipFile

# Загружаем в S3
aws s3 cp $zipFile s3://$bucket/$zipFile

Write-Output "Changes uploaded to S3 bucket $bucket"