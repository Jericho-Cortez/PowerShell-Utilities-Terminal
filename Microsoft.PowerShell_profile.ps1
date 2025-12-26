#Get-ChildItem "$env:LOCALAPPDATA\Programs\oh-my-posh\themes" -ErrorAction SilentlyContinue
oh-my-posh init pwsh --config "$env:LOCALAPPDATA\Programs\oh-my-posh\themes\devious-diamonds.omp.yaml" | Invoke-Expression
try {
    Import-Module Terminal-Icons -ErrorAction Stop
} catch {
    Write-Host "Terminal-Icons non installé (Install-Module Terminal-Icons)" -ForegroundColor DarkYellow
}


# ========================================
# MENU INTERACTIF - DÉMARRAGE TERMINAL
# ========================================


function Show-StartupMenu {
    Clear-Host
    
    Write-Host "╔═══════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║        Bienvenue Lord Cortez          ║" -ForegroundColor Cyan
    Write-Host "║       MENU PRINCIPAL - TERMINAL       ║" -ForegroundColor Cyan
    Write-Host "╚═══════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  [1] 🛠️ Outils" -ForegroundColor Yellow
    Write-Host "  [2] 🌐 Réseau" -ForegroundColor Green
    Write-Host "  [3] 🎓 Mode École" -ForegroundColor Cyan
    Write-Host "  [4] 💻 Terminal classique" -ForegroundColor White
    Write-Host ""
}


function Show-ToolsMenu {
    Clear-Host
    
    Write-Host "╔═══════════════════════════════════════╗" -ForegroundColor Yellow
    Write-Host "║            🛠️  OUTILS                 ║" -ForegroundColor Yellow
    Write-Host "╚═══════════════════════════════════════╝" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  [1] 📱 Générer un QR Code" -ForegroundColor White
    Write-Host "  [2] 🤖 Ouvrir Perplexity" -ForegroundColor White
    Write-Host "  [3] 🔍 Rechercher un fichier" -ForegroundColor White
    Write-Host "  [4] 📱 Afficher mon téléphone" -ForegroundColor White
    Write-Host "  [0] ⬅️  Retour au menu principal" -ForegroundColor Gray
    Write-Host ""
}


function Show-NetworkMenu {
    Clear-Host
    
    Write-Host "╔═══════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║            🌐 RÉSEAU                  ║" -ForegroundColor Green
    Write-Host "╚═══════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host "  [1] 🔐 Se connecter Chez Rachel" -ForegroundColor White
    Write-Host "  [2] 📊 Infos réseau" -ForegroundColor White
    Write-Host "  [3] 🔍 Scan de ports" -ForegroundColor White
    Write-Host "  [4] 🚀 Test de vitesse" -ForegroundColor White
    Write-Host "  [0] ⬅️  Retour au menu principal" -ForegroundColor Gray
    Write-Host ""
}


# ========================================
# FONCTIONS - OUTILS
# ========================================


function New-QRCodeCustom {
    Write-Host "`n📱 GÉNÉRATEUR DE QR CODE" -ForegroundColor Cyan
    Write-Host "═══════════════════════════" -ForegroundColor Cyan
    
    $pythonScript = "C:\Users\jbcde\Downloads\qrcode_generator.py"
    
    if (-not (Test-Path $pythonScript)) {
        Write-Host "❌ Script Python introuvable: $pythonScript" -ForegroundColor Red
        Write-Host "💡 Crée le fichier à cet emplacement d'abord" -ForegroundColor Yellow
        Read-Host "`nAppuie sur Entrée"
        return
    }
    
    $Text = Read-Host "`nEntre l'URL"
    
    if ([string]::IsNullOrEmpty($Text)) {
        Write-Host "❌ Aucune URL fournie" -ForegroundColor Red
        Read-Host "Appuie sur Entrée"
        return
    }
    
    $customName = Read-Host "`nNom du fichier (laisser vide pour auto-générer)"
    
    $outputPath = ""
    if (-not [string]::IsNullOrEmpty($customName)) {
        $qr_folder = "C:\Users\jbcde\OneDrive\Documents\QR_Code"
        if (-not $customName.EndsWith('.png')) {
            $customName = "$customName.png"
        }
        $outputPath = Join-Path $qr_folder $customName
    }
    
    Write-Host "`n🔄 Génération du QR Code..." -ForegroundColor Yellow
    
    try {
        if ([string]::IsNullOrEmpty($outputPath)) {
            $result = & python "$pythonScript" "$Text" 2>&1
        }
        else {
            $result = & python "$pythonScript" "$Text" "$outputPath" 2>&1
        }
    }
    catch {
        Write-Host "❌ Erreur d'exécution: $_" -ForegroundColor Red
        Read-Host "`nAppuie sur Entrée"
        return
    }
    
    if ($result -match "SUCCESS:(.+)") {
        $outputPath = $Matches[1]
        Write-Host "✅ QR Code créé avec succès !" -ForegroundColor Green
        Write-Host "📁 Emplacement: $outputPath" -ForegroundColor Cyan
        Start-Process $outputPath
    }
    elseif ($result -match "ERROR:(.+)") {
        $erreur = $Matches[1]
        Write-Host "❌ Erreur: $erreur" -ForegroundColor Red
    }
    else {
        Write-Host "❌ Erreur inconnue" -ForegroundColor Red
        Write-Host "Détails: $result" -ForegroundColor Gray
    }
    
    Read-Host "`nAppuie sur Entrée"
}


function Open-Perplexity {
    $appPath = "$env:LOCALAPPDATA\Programs\Perplexity\Perplexity.exe"
    
    if (Test-Path $appPath) {
        Write-Host "`n🚀 Lancement de Perplexity..." -ForegroundColor Cyan
        Start-Process $appPath
        Start-Sleep -Seconds 1
    }
    else {
        Write-Host "`n❌ Perplexity non installé" -ForegroundColor Red
        $install = Read-Host "Ouvrir la page de téléchargement ? (O/N)"
        
        if ($install -eq 'O' -or $install -eq 'o') {
            Start-Process "https://www.perplexity.ai/download"
        }
        Start-Sleep -Seconds 1
    }
}

function Search-Files {
    Write-Host "`n🔍 RECHERCHE AVANCÉE DE FICHIERS" -ForegroundColor Cyan
    Write-Host "═════════════════════════════════" -ForegroundColor Cyan
    
    Write-Host "`n📋 Type de recherche :" -ForegroundColor Yellow
    Write-Host "  [1] Recherche par nom de fichier" -ForegroundColor White
    Write-Host "  [2] Recherche dans le contenu (texte)" -ForegroundColor White
    Write-Host "  [3] Les deux" -ForegroundColor White
    
    $searchType = Read-Host "`nChoix (1-3)"
    
    $fileName = ""
    $contentQuery = ""
    
    if ($searchType -eq '1' -or $searchType -eq '3') {
        $fileName = Read-Host "`nNom du fichier"
    }
    
    if ($searchType -eq '2' -or $searchType -eq '3') {
        $contentQuery = Read-Host "Texte dans le contenu"
    }
    
    Write-Host "`n⚡ Recherche Windows Search Index..." -ForegroundColor Yellow
    
    try {
        $connection = New-Object -ComObject ADODB.Connection
        $recordSet = New-Object -ComObject ADODB.Recordset
        
        $connection.Open("Provider=Search.CollatorDSO;Extended Properties='Application=Windows';")
        
        # Construire la requête SQL selon le type
        $whereClause = @()
        
        if ($fileName) {
            $whereClause += "System.FileName LIKE '%$fileName%'"
        }
        
        if ($contentQuery) {
            $whereClause += "FREETEXT('$contentQuery')"
        }
        
        $sql = @"
            SELECT TOP 50 
                System.ItemName, 
                System.ItemPathDisplay, 
                System.Size,
                System.DateModified,
                System.ItemType
            FROM SYSTEMINDEX 
            WHERE $($whereClause -join ' AND ')
            ORDER BY System.DateModified DESC
"@
        
        $recordSet.Open($sql, $connection)
        
        $results = @()
        
        while (-not $recordSet.EOF) {
            $results += [PSCustomObject]@{
                Name = $recordSet.Fields.Item("System.ItemName").Value
                Path = $recordSet.Fields.Item("System.ItemPathDisplay").Value
                Size = $recordSet.Fields.Item("System.Size").Value
                Modified = $recordSet.Fields.Item("System.DateModified").Value
                Type = $recordSet.Fields.Item("System.ItemType").Value
            }
            $recordSet.MoveNext()
        }
        
        $recordSet.Close()
        $connection.Close()
        
        if ($results.Count -gt 0) {
            Write-Host "`n✅ $($results.Count) résultat(s) trouvé(s) :`n" -ForegroundColor Green
            
            for ($i = 0; $i -lt $results.Count; $i++) {
                $result = $results[$i]
                
                $size = if ($result.Size -gt 1MB) { "$([math]::Round($result.Size / 1MB, 2)) MB" }
                       elseif ($result.Size -gt 1KB) { "$([math]::Round($result.Size / 1KB, 2)) KB" }
                       else { "$($result.Size) B" }
                
                $modified = if ($result.Modified) { $result.Modified.ToString("dd/MM/yyyy HH:mm") } else { "N/A" }
                
                $icon = switch -Wildcard ($result.Type) {
                    "*.txt" { "📝" }
                    "*.pdf" { "📄" }
                    "*.docx" { "📘" }
                    "*.xlsx" { "📊" }
                    "*.ps1" { "⚡" }
                    "*.py" { "🐍" }
                    "*.js" { "🟨" }
                    default { "📄" }
                }
                
                Write-Host "  [$($i+1)] $icon $($result.Name)" -ForegroundColor White
                Write-Host "      $($result.Path)" -ForegroundColor Gray
                Write-Host "      Taille: $size | Modifié: $modified" -ForegroundColor DarkGray
                Write-Host ""
            }
            
            Write-Host "`n📋 Actions :" -ForegroundColor Yellow
            Write-Host "  [N] Ouvrir un résultat par numéro" -ForegroundColor White
            Write-Host "  [F] Ouvrir le dossier d'un résultat" -ForegroundColor White
            Write-Host "  [C] Copier le chemin d'un résultat" -ForegroundColor White
            Write-Host "  [0] Retour" -ForegroundColor Gray
            
            $action = Read-Host "`nAction (N/F/C/0)"
            
            switch ($action) {
                'N' { 
                    $num = Read-Host "Numéro du résultat (1-$($results.Count))"
                    
                    if ($num -match '^\d+$' -and [int]$num -le $results.Count -and [int]$num -gt 0) {
                        $selectedPath = $results[[int]$num - 1].Path
                        
                        try {
                            # Utiliser Invoke-Item qui gère mieux les chemins avec espaces
                            Invoke-Item -LiteralPath $selectedPath
                            Write-Host "`n✅ Fichier ouvert" -ForegroundColor Green
                        }
                        catch {
                            Write-Host "`n❌ Impossible d'ouvrir le fichier" -ForegroundColor Red
                            Write-Host "💡 Le fichier nécessite peut-être une application spécifique" -ForegroundColor Yellow
                            
                            $openFolder = Read-Host "Ouvrir le dossier à la place ? (O/N)"
                            if ($openFolder -eq 'O' -or $openFolder -eq 'o') {
                                $folder = Split-Path -LiteralPath $selectedPath
                                explorer.exe "/select,`"$selectedPath`""
                                Write-Host "✅ Dossier ouvert avec le fichier sélectionné" -ForegroundColor Green
                            }
                        }
                    }
                    else {
                        Write-Host "❌ Numéro invalide" -ForegroundColor Red
                    }
                }
                'F' { 
                    $num = Read-Host "Numéro du résultat (1-$($results.Count))"
                    
                    if ($num -match '^\d+$' -and [int]$num -le $results.Count -and [int]$num -gt 0) {
                        $selectedPath = $results[[int]$num - 1].Path
                        
                        # Ouvrir l'explorateur avec le fichier sélectionné
                        explorer.exe "/select,`"$selectedPath`""
                        Write-Host "`n✅ Dossier ouvert avec le fichier sélectionné" -ForegroundColor Green
                    }
                    else {
                        Write-Host "❌ Numéro invalide" -ForegroundColor Red
                    }
                }
                'C' { 
                    $num = Read-Host "Numéro du résultat (1-$($results.Count))"
                    
                    if ($num -match '^\d+$' -and [int]$num -le $results.Count -and [int]$num -gt 0) {
                        $selectedPath = $results[[int]$num - 1].Path
                        Set-Clipboard -Value $selectedPath
                        Write-Host "`n✅ Chemin copié : $selectedPath" -ForegroundColor Green
                    }
                    else {
                        Write-Host "❌ Numéro invalide" -ForegroundColor Red
                    }
                }
            }
        }
        else {
            Write-Host "`n⚠️  Aucun résultat" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "`n❌ Erreur : $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "💡 Vérifie l'indexation Windows : Paramètres > Recherche" -ForegroundColor Cyan
    }
    
    Read-Host "`nAppuie sur Entrée pour retourner au menu"
}

function Start-PhoneMirror {
    Write-Host "`n📱 MIROIR D'ÉCRAN TÉLÉPHONE" -ForegroundColor Cyan
    Write-Host "═══════════════════════════" -ForegroundColor Cyan
    
    # Vérifier si scrcpy est installé
    if (-not (Get-Command scrcpy -ErrorAction SilentlyContinue)) {
        Write-Host "`n⚠️  scrcpy non installé" -ForegroundColor Yellow
        Write-Host "💡 scrcpy permet d'afficher et contrôler ton téléphone Android via USB" -ForegroundColor Cyan
        
        Write-Host "`n📦 Installation :" -ForegroundColor Yellow
        Write-Host "   winget install Genymobile.scrcpy" -ForegroundColor White
        
        $install = Read-Host "`nInstaller maintenant ? (O/N)"
        
        if ($install -eq 'O' -or $install -eq 'o') {
            Write-Host "`n🔄 Installation en cours..." -ForegroundColor Cyan
            winget install Genymobile.scrcpy --accept-package-agreements --accept-source-agreements
            
            Write-Host "`n✅ Installation terminée !" -ForegroundColor Green
            Write-Host "💡 Relance cette fonction après avoir branché ton téléphone" -ForegroundColor Cyan
        }
        
        Read-Host "`nAppuie sur Entrée"
        return
    }
    
    # Vérifier si un téléphone est connecté
    Write-Host "`n🔍 Recherche de téléphone connecté..." -ForegroundColor Yellow
    
    # Vérifier si adb détecte un appareil
    $adbCheck = adb devices 2>&1
    $devices = $adbCheck | Select-String "device$" | Where-Object { $_ -notmatch "List of devices" }
    
    if (-not $devices) {
        Write-Host "`n⚠️  Aucun téléphone détecté" -ForegroundColor Yellow
        Write-Host "`n📋 Prérequis :" -ForegroundColor Cyan
        Write-Host "   1. Brancher le téléphone en USB-C" -ForegroundColor White
        Write-Host "   2. Activer le débogage USB sur ton téléphone :" -ForegroundColor White
        Write-Host "      • Paramètres > À propos du téléphone" -ForegroundColor Gray
        Write-Host "      • Taper 7x sur 'Numéro de build'" -ForegroundColor Gray
        Write-Host "      • Paramètres > Options développeur" -ForegroundColor Gray
        Write-Host "      • Activer 'Débogage USB'" -ForegroundColor Gray
        Write-Host "   3. Autoriser le PC sur le téléphone" -ForegroundColor White
        
        Read-Host "`nAppuie sur Entrée"
        return
    }
    
    Write-Host "✅ Téléphone détecté !" -ForegroundColor Green
    
    # Options de lancement
    Write-Host "`n📋 Mode d'affichage :" -ForegroundColor Yellow
    Write-Host "  [1] Normal (résolution téléphone)" -ForegroundColor White
    Write-Host "  [2] HD (1920x1080)" -ForegroundColor White
    Write-Host "  [3] Performance (réduction qualité)" -ForegroundColor White
    Write-Host "  [4] Pas de contrôle (affichage seul)" -ForegroundColor White
    Write-Host "  [5] Enregistrer l'écran" -ForegroundColor White
    
    $mode = Read-Host "`nChoix (1-5)"
    
    Write-Host "`n🚀 Lancement du miroir..." -ForegroundColor Cyan
    Write-Host "💡 Raccourcis utiles :" -ForegroundColor Gray
    Write-Host "   • Ctrl+O : Éteindre l'écran du téléphone" -ForegroundColor DarkGray
    Write-Host "   • Ctrl+N : Ouvrir les notifications" -ForegroundColor DarkGray
    Write-Host "   • Ctrl+B : Retour" -ForegroundColor DarkGray
    Write-Host "   • Ctrl+H : Home" -ForegroundColor DarkGray
    Write-Host "   • Ctrl+S : Applications récentes" -ForegroundColor DarkGray
    Write-Host ""
    
    Start-Sleep -Seconds 1
    
    try {
        switch ($mode) {
            '1' {
                # Mode normal
                scrcpy 
            }
            '2' {
                # HD 1080p
                scrcpy --max-size 1920 
            }
            '3' {
                # Performance (bitrate réduit + FPS limité)
                scrcpy --max-size 1280 --max-fps 30 --bit-rate 2M 
            }
            '4' {
                # Affichage seul (pas de contrôle)
                scrcpy --no-control 
            }
            '5' {
                # Enregistrement
                $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
                $recordPath = "$env:USERPROFILE\Videos\phone_$timestamp.mp4"
                
                Write-Host "📹 Enregistrement vers : $recordPath" -ForegroundColor Cyan
                scrcpy --record=$recordPath
                
                Write-Host "`n✅ Enregistrement sauvegardé : $recordPath" -ForegroundColor Green
            }
            default {
                scrcpy
            }
        }
    }
    catch {
        Write-Host "`n❌ Erreur lors du lancement" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Gray
    }
    
    Read-Host "`nAppuie sur Entrée pour retourner au menu"
}




# ========================================
# FONCTIONS - RÉSEAU
# ========================================


function Connect-SSHServer {
    $sshUser = "grizko"
    $sshIP = "54.38.242.167"
    $sshPort = "50000"
    
    Write-Host "`n🔐 Connexion SSH vers ${sshUser}@${sshIP}:${sshPort}..." -ForegroundColor Cyan
    Write-Host "💡 Pour quitter la session SSH, tape 'exit' ou Ctrl+D`n" -ForegroundColor Yellow
    
    ssh -p $sshPort $sshUser@$sshIP
    
    Write-Host "`n✅ Session SSH terminée." -ForegroundColor Green
    Read-Host "Appuie sur Entrée"
}


function Get-NetworkInfo {
    Write-Host "`n🌐 INFORMATIONS RÉSEAU" -ForegroundColor Cyan
    Write-Host "═══════════════════════" -ForegroundColor Cyan
    
    $networkConfig = Get-NetIPConfiguration | Where-Object {
        $_.IPv4DefaultGateway -ne $null -and $_.NetAdapter.Status -eq "Up"
    } | Select-Object -First 1
    
    if (-not $networkConfig) {
        Write-Host "`n❌ Impossible de détecter la configuration réseau" -ForegroundColor Red
        Read-Host "`nAppuie sur Entrée"
        return
    }
    
    $localIP = $networkConfig.IPv4Address.IPAddress
    $gateway = $networkConfig.IPv4DefaultGateway.NextHop
    
    Write-Host "`n📍 IP Locale : $localIP" -ForegroundColor Yellow
    Write-Host "🚪 Passerelle : $gateway" -ForegroundColor Yellow
    
    try {
        $publicIP = (Invoke-RestMethod -Uri "https://api.ipify.org?format=json" -TimeoutSec 3).ip
        Write-Host "🌍 IP Publique : $publicIP" -ForegroundColor Yellow
    } catch {
        Write-Host "🌍 IP Publique : Non disponible" -ForegroundColor Yellow
    }
    
    $dns = $networkConfig.DNSServer.ServerAddresses -join ", "
    Write-Host "🔍 DNS : $dns" -ForegroundColor Yellow
    
    Write-Host "`n📡 Tests de connexion :" -ForegroundColor Yellow
    if (Test-Connection -ComputerName "8.8.8.8" -Count 1 -Quiet) {
        Write-Host "   ✅ Internet actif" -ForegroundColor Green
    } else {
        Write-Host "   ❌ Pas de connexion" -ForegroundColor Red
    }
    
    Write-Host "`n🔍 Scanner le réseau local ?" -ForegroundColor Yellow
    $scan = Read-Host "Cela peut prendre 1-2 minutes (O/N)"
    
    if ($scan -eq 'O' -or $scan -eq 'o') {
        Write-Host "`n🔎 SCAN DU RÉSEAU" -ForegroundColor Cyan
        Write-Host "════════════════" -ForegroundColor Cyan
        
        $ipParts = $localIP.Split('.')
        $networkBase = "$($ipParts[0]).$($ipParts[1]).$($ipParts[2])"
        
        if (Get-Command nmap -ErrorAction SilentlyContinue) {
            Write-Host "`n⚡ Scan avec nmap..." -ForegroundColor Yellow
            $nmapOutput = nmap -sn "$networkBase.0/24" 2>&1
            $lines = $nmapOutput -split "`n"
            $devices = @()
            
            foreach ($line in $lines) {
                if ($line -match "Nmap scan report for (.+) \((\d+\.\d+\.\d+\.\d+)\)") {
                    $devices += [PSCustomObject]@{ IP = $matches[2]; Name = $matches[1]; MAC = "" }
                } elseif ($line -match "Nmap scan report for (\d+\.\d+\.\d+\.\d+)") {
                    $devices += [PSCustomObject]@{ IP = $matches[1]; Name = ""; MAC = "" }
                }
            }
        } else {
            Write-Host "`n⏳ Scan en cours..." -ForegroundColor Yellow
            $devices = @()
            
            1..254 | ForEach-Object -Parallel {
                $ip = "$using:networkBase.$_"
                if (Test-Connection -ComputerName $ip -Count 1 -Quiet -TimeoutSeconds 1) {
                    try { $name = [System.Net.Dns]::GetHostEntry($ip).HostName }
                    catch { $name = "" }
                    [PSCustomObject]@{ IP = $ip; Name = $name; MAC = "" }
                }
            } -ThrottleLimit 50 | ForEach-Object {
                $devices += $_
                Write-Host "." -NoNewline -ForegroundColor Green
            }
            Write-Host ""
        }
        
        $arpTable = arp -a
        foreach ($device in $devices) {
            $arpEntry = $arpTable | Select-String $device.IP
            if ($arpEntry) {
                $parts = $arpEntry -split '\s+'
                if ($parts.Count -ge 3) { $device.MAC = $parts[2] }
            }
        }
        
        if ($devices.Count -gt 0) {
            Write-Host "`n✅ $($devices.Count) appareil(s) trouvé(s)`n" -ForegroundColor Green
            
            Write-Host "╔═══════════════╦════════════════════════════════╦═══════════════════╗" -ForegroundColor Gray
            Write-Host "║ IP            ║ Nom d'hôte                     ║ MAC               ║" -ForegroundColor Gray
            Write-Host "╠═══════════════╬════════════════════════════════╬═══════════════════╣" -ForegroundColor Gray
            
            foreach ($device in $devices | Sort-Object {[System.Version]$_.IP}) {
                $ipF = $device.IP.PadRight(13)
                
                $nameDisplay = if ($device.IP -eq $localIP) { "💻 TON PC" }
                              elseif ($device.IP -eq $gateway) { "🌐 ROUTEUR/BOX" }
                              elseif ($device.Name) { $device.Name }
                              else { "Appareil inconnu" }
                
                $nameF = $nameDisplay.PadRight(30).Substring(0, 30)
                $macF = $device.MAC.PadRight(17)
                
                $color = if ($device.IP -eq $localIP) { "Green" }
                        elseif ($device.IP -eq $gateway) { "Cyan" }
                        else { "White" }
                
                Write-Host "║ $ipF ║ $nameF ║ $macF ║" -ForegroundColor $color
            }
            
            Write-Host "╚═══════════════╩════════════════════════════════╩═══════════════════╝" -ForegroundColor Gray
        } else {
            Write-Host "`n⚠️  Aucun appareil détecté" -ForegroundColor Yellow
        }
    }
    
    Read-Host "`nAppuie sur Entrée"
}


function Test-PortScan {
    Write-Host "`n🔍 SCANNER DE PORTS" -ForegroundColor Cyan
    Write-Host "═══════════════════" -ForegroundColor Cyan
    
    $target = Read-Host "`nCible (IP ou hostname)"
    
    Write-Host "`n📋 Type de scan :" -ForegroundColor Yellow
    Write-Host "  [1] Ports communs (16 ports)" -ForegroundColor White
    Write-Host "  [2] Scan complet (1-1024)" -ForegroundColor White
    Write-Host "  [3] Ports personnalisés" -ForegroundColor White
    
    $choice = Read-Host "`nChoix (1-3)"
    
    $ports = switch ($choice) {
        '1' { @(21,22,23,25,53,80,110,143,443,445,3306,3389,5900,8080,8443,9090) }
        '2' { 1..1024 }
        '3' { 
            $custom = Read-Host "Ports (ex: 80,443,8080)"
            $custom -split ',' | ForEach-Object { [int]$_.Trim() }
        }
        default { @(80,443,22,3389) }
    }
    
    Write-Host "`n🔎 Scan de $target en cours..." -ForegroundColor Cyan
    Write-Host "Ports testés : $($ports.Count)" -ForegroundColor Gray
    Write-Host ""
    
    $openPorts = @()
    
    foreach ($port in $ports) {
        Write-Host "." -NoNewline -ForegroundColor Gray
        
        $tcpClient = New-Object System.Net.Sockets.TcpClient
        $connect = $tcpClient.BeginConnect($target, $port, $null, $null)
        $wait = $connect.AsyncWaitHandle.WaitOne(100, $false)
        
        if ($wait -and $tcpClient.Connected) {
            $service = switch ($port) {
                21 { "FTP" }
                22 { "SSH" }
                23 { "Telnet" }
                25 { "SMTP" }
                53 { "DNS" }
                80 { "HTTP" }
                110 { "POP3" }
                143 { "IMAP" }
                443 { "HTTPS" }
                445 { "SMB" }
                3306 { "MySQL" }
                3389 { "RDP" }
                5900 { "VNC" }
                8080 { "HTTP-Alt" }
                default { "Inconnu" }
            }
            
            $openPorts += [PSCustomObject]@{
                Port = $port
                Service = $service
                Status = "Ouvert"
            }
        }
        
        $tcpClient.Close()
    }
    
    Write-Host "`n"
    
    if ($openPorts.Count -gt 0) {
        Write-Host "✅ $($openPorts.Count) port(s) ouvert(s) :" -ForegroundColor Green
        Write-Host ""
        Write-Host "╔═══════╦══════════════╦═════════╗" -ForegroundColor Gray
        Write-Host "║ Port  ║ Service      ║ Status  ║" -ForegroundColor Gray
        Write-Host "╠═══════╬══════════════╬═════════╣" -ForegroundColor Gray
        
        foreach ($p in $openPorts | Sort-Object Port) {
            $portF = $p.Port.ToString().PadRight(5)
            $serviceF = $p.Service.PadRight(12)
            Write-Host "║ $portF ║ $serviceF ║ ✅ Ouvert ║" -ForegroundColor Green
        }
        
        Write-Host "╚═══════╩══════════════╩═════════╝" -ForegroundColor Gray
    } else {
        Write-Host "⚠️  Aucun port ouvert détecté" -ForegroundColor Yellow
    }
    
    Read-Host "`nAppuie sur Entrée"
}


function Test-InternetSpeed {
    Write-Host "`n🚀 TEST DE VITESSE" -ForegroundColor Cyan
    Write-Host "═══════════════════" -ForegroundColor Cyan
    
    Write-Host "`n📡 Test de latence..." -ForegroundColor Yellow
    try {
        $ping = Test-Connection -ComputerName "8.8.8.8" -Count 4 -ErrorAction Stop
        $avgPing = [math]::Round(($ping.Latency | Measure-Object -Average).Average, 2)
        
        if ($avgPing -gt 0) {
            Write-Host "   ✅ Latence : $avgPing ms" -ForegroundColor Green
            
            if ($avgPing -lt 20) {
                Write-Host "   🟢 Excellent" -ForegroundColor Green
            } elseif ($avgPing -lt 50) {
                Write-Host "   🟡 Bon" -ForegroundColor Yellow
            } else {
                Write-Host "   🔴 Élevé" -ForegroundColor Red
            }
        }
    }
    catch {
        Write-Host "   ❌ Erreur" -ForegroundColor Red
    }
    
    Write-Host "`n⬇️  Test de téléchargement..." -ForegroundColor Yellow
    
    $testUrls = @(
        @{Url="https://proof.ovh.net/files/10Mb.dat"; Size=10},
        @{Url="https://bouygues.testdebit.info/10M.iso"; Size=10}
    )
    
    $output = "$env:TEMP\speedtest_$(Get-Random).tmp"
    $success = $false
    
    foreach ($test in $testUrls) {
        try {
            Write-Host "   Tentative..." -ForegroundColor Gray
            
            $start = Get-Date
            Invoke-WebRequest -Uri $test.Url -OutFile $output -UseBasicParsing -TimeoutSec 15 -ErrorAction Stop
            $end = Get-Date
            
            $duration = ($end - $start).TotalSeconds
            
            if ($duration -gt 0 -and (Test-Path $output)) {
                $fileSizeMB = (Get-Item $output).Length / 1MB
                
                if ($fileSizeMB -gt 0.001) {
                    $speedMbps = [math]::Round(($fileSizeMB * 8) / $duration, 2)
                    
                    Write-Host "   ✅ Vitesse : $speedMbps Mbps" -ForegroundColor Green
                    Write-Host "   📊 $([math]::Round($fileSizeMB, 2)) MB en $([math]::Round($duration, 2)) s" -ForegroundColor Gray
                    
                    if ($speedMbps -gt 100) {
                        Write-Host "   🟢 Très rapide (Fibre)" -ForegroundColor Green
                    } elseif ($speedMbps -gt 30) {
                        Write-Host "   🟡 Bon" -ForegroundColor Yellow
                    } else {
                        Write-Host "   🟠 Moyen" -ForegroundColor Yellow
                    }
                    
                    $success = $true
                }
                
                Remove-Item $output -Force -ErrorAction SilentlyContinue
                break
            }
        }
        catch {
            Write-Host "   ⚠️  Échec, test suivant..." -ForegroundColor Yellow
            continue
        }
    }
    
    if (-not $success) {
        Write-Host "   ⚠️  Test non disponible" -ForegroundColor Yellow
        Write-Host "   💡 Utilise speedtest.net" -ForegroundColor Cyan
    }
    
    Read-Host "`nAppuie sur Entrée"
}


# ========================================
# FONCTION - MODE ÉCOLE
# ========================================


function Start-WorkMode {
    Write-Host "`n🚀 Lancement du Mode École..." -ForegroundColor Cyan
    Start-Process "C:\Users\jbcde\OneDrive\Bureau\Work.lnk"
    Write-Host "✅ Lancé ! 📚💪" -ForegroundColor Green
    Start-Sleep -Seconds 1
}


# ========================================
# BOUCLES DE MENU
# ========================================


function Start-ToolsLoop {
    do {
        Show-ToolsMenu
        $choice = Read-Host "Ton choix"
        
        switch ($choice) {
            '1' { New-QRCodeCustom }
            '2' { Open-Perplexity }
            '3' { Search-Files }
            '4' { Start-PhoneMirror }
            '0' { return }
            default {
                Write-Host "`n❌ Option invalide`n" -ForegroundColor Red
                Start-Sleep -Seconds 1
            }
        }
    } while ($true)
}


function Start-NetworkLoop {
    do {
        Show-NetworkMenu
        $choice = Read-Host "Ton choix"
        
        switch ($choice) {
            '1' { Connect-SSHServer }
            '2' { Get-NetworkInfo }
            '3' { Test-PortScan }
            '4' { Test-InternetSpeed }
            '0' { return }
            default {
                Write-Host "`n❌ Option invalide`n" -ForegroundColor Red
                Start-Sleep -Seconds 1
            }
        }
    } while ($true)
}


function Start-MenuLoop {
    do {
        Show-StartupMenu
        $choice = Read-Host "Ton choix"
        
        switch ($choice) {
            '1' { Start-ToolsLoop }
            '2' { Start-NetworkLoop }
            '3' { Start-WorkMode }
            '4' {
                Write-Host "`n✅ Terminal classique activé. Bonne session ! 🚀`n" -ForegroundColor Green
                return
            }
            default {
                Write-Host "`n❌ Option invalide`n" -ForegroundColor Red
                Start-Sleep -Seconds 1
            }
        }
    } while ($true)
}


# Lancer le menu au démarrage
Start-MenuLoop
