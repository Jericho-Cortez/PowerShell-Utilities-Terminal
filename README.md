Ce projet propose un **menu interactif PowerShell complet**, combinant des **outils système**, des **fonctions réseau avancées**, un **miroir Android**, un **générateur de QR Codes**, et un **mode de travail automatisé**.  
Chaque menu est ergonomique, coloré et pensé pour gagner du temps au quotidien.

> 💡 Idéal pour les administrateurs système, les étudiants en cybersécurité, ou toute personne souhaitant centraliser ses outils PowerShell dans un hub unique.

***

## 📚 Table des matières

- [✨ Fonctionnalités](#-fonctionnalités)
- [⚡ Installation](#-installation)
  - [1️⃣ Prérequis système](#1️⃣-prérequis-système)
  - [2️⃣ Installation automatique](#2️⃣-installation-automatique)
- [🧰 Menus et fonctions principales](#-menus-et-fonctions-principales)
  - [🛠️ Outils](#️-outils)
  - [🌐 Réseau](#-réseau)
  - [🎓 Mode École](#-mode-école)
  - [📱 Miroir Android (scrcpy)](#-miroir-android-scrcpy)
- [🪄 Customisation du thème PowerShell](#-customisation-du-thème-powershell)
- [🚀 Lancer le menu principal](#-lancer-le-menu-principal)
- [🧩 Améliorations prévues](#-améliorations-prévues)
- [🤝 Contribuer](#-contribuer)
- [📜 Licence](#-licence)

***

## ✨ Fonctionnalités

| Catégorie | Fonction | Description |
|------------|-----------|-------------|
| 🛠️ Outils | QR Code Generator | Génère un QR Code en local via un script Python. |
| 🧠 Outils | Perplexity Launcher | Lance Perplexity.ai localement s'il est installé. |
| 🔍 Outils | Recherche de fichiers | Recherche rapide via Windows Search (nom + contenu). |
| 📱 Outils | Miroir d'écran Android | Affiche et contrôle ton téléphone avec `scrcpy`. |
| 🌐 Réseau | SSH Quick Connect | Connexion directe à un serveur distant personnalisé. |
| 🌍 Réseau | Infos réseau | IP locale/publique, DNS, gateway et scan local. |
| 🔎 Réseau | Port Scanner | Scanner TCP intelligent (rapide et lisible). |
| 🚀 Réseau | Test de vitesse | Test intégré (latence + débit) sans speedtest.net. |
| 🩺 Réseau | **Diagnostic complet** | **Ping + DNS + Trace + Ports critiques + Suggestions de sécurité** |
| 🎓 Travail | Mode École | Lance ton espace de travail complet automatiquement. |

***

## ⚡ Installation

### 1️⃣ Prérequis système

Assure-toi que ces outils sont installés avant d'exécuter le script :

| Outil | Commande d'installation (PowerShell) | Rôle |
|--------|--------------------------------------|------|
| **Windows Terminal** | Via Microsoft Store | Logique d'affichage et rendu UTF8 |
| **PowerShell 7+** | `winget install Microsoft.PowerShell` | Environnement requis |
| **OhMyPosh** | `winget install JanDeDobbeleer.OhMyPosh` | Thème du terminal |
| **Terminal-Icons** | `Install-Module Terminal-Icons` | Icônes colorées dans les listes |
| **scrcpy (Android)** | `winget install Genymobile.scrcpy` | Miroir et contrôle du téléphone |
| **Python 3+** | `winget install Python.Python.3.12` | Générateur de QR Codes |
| **adb (Android Debug Bridge)** | Installé avec scrcpy | Communication USB Android |
| **nmap (facultatif)** | `winget install Insecure.Nmap` | Scan réseau avancé |

### 2️⃣ Installation automatique

Clone ou télécharge le projet :

```bash
git clone https://github.com/ton-pseudo/PowerShell-Utilities.git
cd PowerShell-Utilities
```

Puis exécute dans PowerShell :

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\startup.ps1
```

> 💡 Il est recommandé d'ajouter ce fichier à ton `$PROFILE` PowerShell pour lancer automatiquement ton **menu personnalisé** à chaque ouverture de terminal.

***

## 🧰 Menus et fonctions principales

### 🛠️ Outils
Fonctions disponibles :
- 💡 Générateur de QR Code via Python.
- 🤖 Lancement direct de **Perplexity.ai**.
- 🔍 Recherche de fichiers (nom et/ou contenu, avec filtrage par extension).
- 📱 **Miroir Android** interactif (`scrcpy`).

***

### 🌐 Réseau
Outils d'administration réseau :
- 🔐 Connexion SSH simplifiée (préconfigurée).
- 📊 Informations réseau (IP, DNS, passerelle, IP publique, scan LAN).
- 🧭 Port scanner intelligent (détection des services communs).
- 🚀 Test de débit (latence moyenne et vitesse de téléchargement).
- 🩺 **Diagnostic complet** : analyse multi-couches (ping, DNS, traceroute, ports critiques) avec **suggestions de sécurité automatiques**.

#### 🩺 Diagnostic Réseau Complet

Cette fonction effectue une **analyse complète** de n'importe quelle cible (IP ou hostname) :

**Tests effectués :**
```
✅ Ping (4 paquets) avec latence moyenne
✅ Résolution DNS (toutes les IPs)
✅ Test de routabilité (traceroute simplifié)
✅ Scan de ports critiques (22, 80, 443, 3389, 445, 3306)
```

**Scoring de santé :**
- 🟢 **Parfait (90-100%)** : Tous les tests OK
- 🟡 **Bon (70-89%)** : Petits problèmes
- 🟠 **Moyen (40-69%)** : Problèmes réseau
- 🔴 **Problème (<40%)** : Configuration critique
- ⚫ **Hors ligne** : Aucune connexion

**Suggestions de sécurité automatiques :**

| Port détecté | Niveau de risque | Action suggérée |
|--------------|------------------|-----------------|
| **3389 (RDP)** | 🔴 CRITIQUE | Désactiver ou VPN obligatoire + commande PowerShell |
| **445 (SMB)** | 🔴 CRITIQUE | Bloquer pare-feu ou whitelist IP interne |
| **22 (SSH)** | 🟡 MOYEN | Changer port par défaut + clé SSH |
| **80 (HTTP)** | 🟡 MOYEN | Redirection HTTPS obligatoire |
| **3306 (MySQL)** | 🟡 MOYEN | Bind localhost uniquement |
| **443 (HTTPS)** | ✅ OK | Vérifier certificat SSL |

**Exemple de suggestion :**
```
⚠️  Ports critiques détectés :
   • 🖥️  RDP (3389) ouvert - RISQUE ÉLEVÉ
      → Désactiver : Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Value 1
      → Ou utiliser un VPN

🛡️  Commande rapide pare-feu :
   New-NetFirewallRule -DisplayName 'Bloquer port X' -Direction Inbound -LocalPort <PORT> -Protocol TCP -Action Block
```

***

### 🎓 Mode École
Mode productif automatisé :
- Lance ton espace de travail (bureau, raccourcis, applis synchronisées).
- Message de motivation affiché ✅

***

### 📱 Miroir Android (scrcpy)

Une fois le débogage USB activé sur ton téléphone :
```bash
Paramètres > Options développeur > Débogage USB
```

Tu peux alors :
- **Afficher l'écran Android sur PC**
- **Utiliser la souris/clavier**
- **Glisser-déposer** fichiers et vidéos dans les deux sens  
  *(PC → Téléphone et Téléphone → PC)*

Commandes disponibles :
```bash
Ctrl+O   # Éteindre l'écran du téléphone
Ctrl+H   # Aller à l'accueil
Ctrl+N   # Voir notifications
Ctrl+S   # Afficher applis récentes
```

**Modes disponibles :**
1. Normal (résolution native)
2. HD 1080p (qualité optimale)
3. Performance (débit réduit)
4. Affichage seul (sans contrôle)
5. Enregistrement vidéo

Si besoin, une fonction intégrée gère l'installation automatique de `scrcpy`.

***

## 🪄 Customisation du thème PowerShell

Ce terminal utilise le thème **devious-diamonds** d'Oh My Posh pour un rendu professionnel.

Pour modifier :
```powershell
oh-my-posh init pwsh --config "$env:LOCALAPPDATA\Programs\oh-my-posh\themes\<autre_theme>.omp.yaml" | Invoke-Expression
```

Ajoute aussi de la couleur et des icônes avec :
```powershell
Import-Module Terminal-Icons
```

***

## 🚀 Lancer le menu principal

Une fois tout prêt :

```powershell
Start-MenuLoop
```

**Menus interactifs** disponibles :
```
[1] 🛠️ Outils
[2] 🌐 Réseau
[3] 🎓 Mode École
[4] 💻 Terminal classique
```

**Menu Réseau :**
```
[1] 🔐 Se connecter Chez Rachel (SSH)
[2] 📊 Infos réseau
[3] 🔍 Scan de ports
[4] 🚀 Test de vitesse
[5] 🩺 Diagnostic complet        ← NOUVEAU
[0] ⬅️  Retour
```

> 🧩 Astuce : ajoute `Start-MenuLoop` à ton fichier `$PROFILE` pour que ton menu personnalisé s'exécute automatiquement à chaque ouverture de PowerShell.

***

## 🧩 Améliorations prévues

- 🌈 Interface dynamique avec curseur interactif.
- 📤 Envoi automatique de logs d'activité.
- ☁️ Version cloud pour synchronisation sur plusieurs machines.
- 🐍 Intégration Python plus poussée (analyse réseau, QR avancé).
- 🔐 Module de hardening Windows automatisé.
- 📊 Dashboard temps réel (monitoring réseau + système).

***

## 🤝 Contribuer

Tu peux contribuer en :

- Proposant une **amélioration** via **issue**
- Soumettant une **pull request**
- Partageant de nouvelles **idées d'outils PowerShell**

> 🧊 N'hésite pas à taguer ton commit avec `[tools]`, `[network]`, `[UI]`, etc. pour une meilleure lisibilité.

***

## 📜 Licence

Ce projet est sous licence **MIT**.  
Tu es libre de le cloner, modifier et redistribuer librement tant que la mention "by Lord Cortez" est conservée.

***

**Auteur :** Lord Cortez 💻  
**Version :** 1.1  
**Date :** Décembre 2025  
**Contact :** [GitHub](https://github.com/ton-pseudo) ou [email]

***

## 📸 Captures d'écran

### Menu Principal
```
╔═══════════════════════════════════════╗
║        Bienvenue Lord Cortez          ║
║       MENU PRINCIPAL - TERMINAL       ║
╚═══════════════════════════════════════╝

  [1] 🛠️ Outils
  [2] 🌐 Réseau
  [3] 🎓 Mode École
  [4] 💻 Terminal classique
```

### Diagnostic Réseau Complet
```
📊 [5/5] RÉSUMÉ DIAGNOSTIC
╔═══════════════════════╦══════════════════════════════════╗
║ Test                  ║ Statut                           ║
╠═══════════════════════╬══════════════════════════════════╣
║ 📡 Ping               ║ ✅ OK (15.2 ms)                 ║
║ 🔍 DNS                ║ ✅ Résolu                       ║
║ 🛤️ Traceroute         ║ ✅ Accessible                   ║
║ 🔓 Ports critiques    ║ 🔓 80(HTTP) 443(HTTPS)          ║
╚═══════════════════════╩══════════════════════════════════╝

🏥 État général : 🟡 Bon (90%)
```

***

[2](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/images/142158843/58eeb04a-4d1d-47f2-8b93-364934c96736/image.jpg)
[3](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/images/142158843/ded079d0-62a6-445c-913e-5045c661bb1e/image.jpg)
[4](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/images/142158843/17ceb6f0-9f75-4c7a-bdac-fb1f6a78c41b/Screenshot_20251226_172415_Settings.jpg)
