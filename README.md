# 🧠 PowerShell Utilities Terminal — by *Lord Cortez*

## ⚙️ Introduction

Ce projet propose un **menu interactif PowerShell complet**, combinant des **outils système**, des **fonctions réseau**, un **miroir Android**, un **générateur de QR Codes**, et un **mode de travail automatisé**.  
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
| 🧠 Outils | Perplexity Launcher | Lance Perplexity.ai localement s’il est installé. |
| 🔍 Outils | Recherche de fichiers | Recherche rapide via Windows Search (nom + contenu). |
| 📱 Outils | Miroir d’écran Android | Affiche et contrôle ton téléphone avec `scrcpy`. |
| 🌐 Réseau | SSH Quick Connect | Connexion directe à un serveur distant personnalisé. |
| 🌍 Réseau | Infos réseau | IP locale/publique, DNS, gateway et scan local. |
| 🔎 Réseau | Port Scanner | Scanner TCP intelligent (rapide et lisible). |
| 🚀 Réseau | Test de vitesse | Test intégré (latence + débit) sans speedtest.net. |
| 🎓 Travail | Mode École | Lance ton espace de travail complet automatiquement. |

***

## ⚡ Installation

### 1️⃣ Prérequis système

Assure-toi que ces outils sont installés avant d’exécuter le script :

| Outil | Commande d'installation (PowerShell) | Rôle |
|--------|--------------------------------------|------|
| **Windows Terminal** | Via Microsoft Store | Logique d’affichage et rendu UTF8 |
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

> 💡 Il est recommandé d’ajouter ce fichier à ton `$PROFILE` PowerShell pour lancer automatiquement ton **menu personnalisé** à chaque ouverture de terminal.

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
Outils d’administration réseau :
- 🔐 Connexion SSH simplifiée (préconfigurée).
- 📊 Informations réseau (IP, DNS, passerelle, IP publique, scan LAN).
- 🧭 Port scanner intelligent (détection des services communs).
- 🚀 Test de débit (latence moyenne et vitesse de téléchargement).

***

### 🎓 Mode École
Mode productif automatisé :
- Lance ton espace de travail (bureau, raccourcis, applis synchronisées).
- Message de motivation affiché ✅

---

### 📱 Miroir Android (scrcpy)

Une fois le débogage USB activé sur ton téléphone :
```bash
Paramètres > Options développeur > Débogage USB
```

Tu peux alors :
- **Afficher l’écran Android sur PC**
- **Utiliser la souris/clavier**
- **Glisser-déposer** fichiers et vidéos dans les deux sens  
  *(Fonctionne en USB ou Wi-Fi si `adb tcpip` activé)*

Commandes disponibles :
```bash
Ctrl+O   # Éteindre l’écran du téléphone
Ctrl+H   # Aller à l’accueil
Ctrl+N   # Voir notifications
Ctrl+S   # Afficher applis récentes
```

Si besoin, une fonction intégrée gère l’installation automatique de `scrcpy`.

***

## 🪄 Customisation du thème PowerShell

Ce terminal utilise le thème **devious-diamonds** d’Oh My Posh pour un rendu professionnel.

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
[1] Outils
[2] Réseau
[3] Mode École
[4] Terminal classique
```

> 🧩 Astuce : ajoute `Start-MenuLoop` à ton fichier `$PROFILE` pour que ton menu personnalisé s’exécute automatiquement à chaque ouverture de PowerShell.

***

## 🧩 Améliorations prévues

- 🌈 Interface dynamique avec curseur interactif.
- 📤 Envoi automatique de logs d’activité.
- ☁️ Version cloud pour synchronisation sur plusieurs machines.
- 🐍 Intégration Python plus poussée (analyse réseau, QR avancé).

***

## 🤝 Contribuer

Tu peux contribuer en :

- Proposant une **amélioration** via **issue**
- Soumettant une **pull request**
- Partageant de nouvelles **idées d'outils PowerShell**

> 🧊 N’hésite pas à taguer ton commit avec `[tools]`, `[network]`, `[UI]`, etc. pour une meilleure lisibilité.

***

## 📜 Licence

Ce projet est sous licence **MIT**.  
Tu es libre de le cloner, modifier et redistribuer librement tant que la mention "by Lord Cortez" est conservée.

***

**Auteur :** Lord Cortez 💻  
**Version :** 1.0  
**Date :** Décembre 2025  
**Contact :** (GitHub ou e-mail selon profil)

***
