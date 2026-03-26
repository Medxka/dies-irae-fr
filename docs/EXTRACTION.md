# Extraction du texte — Dies Irae

Ce document explique comment extraire le script texte depuis les fichiers du jeu.

---

## Vue d'ensemble

Le moteur **Malie** (utilisé par Dies Irae) stocke les scripts compilés dans des archives `.dat`.
La chaîne d'extraction est :

```
dossier Steam/
└── data4.dat  ──[GARbro]──▶  patch.en.dat  ──[Malie_Script_Tool]──▶  messages_en.txt
```

---

## Étape 1 — Localiser les fichiers du jeu

Sur Steam :
> Clic droit sur Dies Irae → Propriétés → Fichiers locaux → Parcourir les fichiers locaux

Le dossier contient : `DiesIrae.exe`, `data4.dat`, `data5.dat` (si le DLC est installé), etc.

---

## Étape 2 — Extraire patch.en.dat avec GARbro

1. Télécharger GARbro : https://github.com/morkt/GARbro/releases
2. Ouvrir `data4.dat` dans GARbro
3. Chercher `patch.en.dat` (et éventuellement `exec.dat`)
4. Extraire dans un dossier de travail, ex : `C:\dies-irae-extract\`

> **Note** : `data5.dat` (DLC) contient aussi des scripts. Même procédure.

---

## Étape 3 — Compiler Malie_Script_Tool (version patchée)

Le Malie_Script_Tool original plante sur certaines instructions (`TJUMP "WTF"`) lors de l'import.
Il faut utiliser la version patchée ci-dessous.

### Télécharger le tool original

```
git clone https://github.com/AtomCrafty/MaliScriptTool
cd MaliScriptTool
```

### Appliquer le patch

Modifier **`Script.cs`** — remplacer la méthode `Load()` :

```csharp
// AVANT
public void Load(string filePath)
{
    using (var stream = File.OpenRead(filePath))
    using (var reader = new BinaryReader(stream))
    {
        Read(reader);
        Parse();
    }
}

// APRÈS — ignore les erreurs de parse non bloquantes
public void Load(string filePath, bool parseRequired = true)
{
    using (var stream = File.OpenRead(filePath))
    using (var reader = new BinaryReader(stream))
    {
        Read(reader);
        try
        {
            Parse();
        }
        catch
        {
            if (parseRequired)
                throw;
        }
    }
}
```

Modifier **`Program.cs`** — ligne d'appel à `Load()` dans le bloc d'import (`-i`) :

```csharp
// AVANT
script.Load(inputPath);

// APRÈS
script.Load(inputPath, parseRequired: false);
```

### Compiler

```powershell
cd MaliScriptTool
dotnet build -c Release
# DLL produite dans : bin\Release\net8.0\Malie_Script_Tool.dll
```

---

## Étape 4 — Extraire le texte

```powershell
$tool = "chemin\vers\Malie_Script_Tool.dll"
$input = "C:\dies-irae-extract\patch.en.dat"
$output = "C:\dies-irae-extract\messages_en.txt"

dotnet $tool -e -in $input -out $output
```

> **Alternative** : si `-e` plante aussi à cause du parse, utiliser le script PowerShell maison
> fourni dans ce repo (`tools/extract_fallback.ps1`) qui lit les chaînes directement en binaire.

---

## Format de sortie

Le fichier `messages_en.txt` (UTF-8) contient ~60 000 blocs de dialogue :

```
◇00000000◇May 1, 1945. Berlin, Germany.
◆00000000◆May 1, 1945. Berlin, Germany.

◇00000001◇The closing act of the Second World War...
Line 2 of the same entry.
◆00000001◆The closing act of the Second World War...
Line 2 of the same entry.

```

- Lignes `◇index◇` = texte original (ne pas toucher)
- Lignes `◆index◆` = texte à remplacer par la traduction française
- Les entrées multi-lignes sont supportées (les lignes de continuation n'ont pas de marqueur)

---

## Découper pour la traduction collaborative

```powershell
# Découper en 10 chunks
.\tools\split_for_collab.ps1 -NumChunks 10 -InputFile "C:\dies-irae-extract\messages_en.txt"
# Produit : chunks\chunk_01.txt ... chunk_10.txt
```

→ Suite dans [`TRADUCTION.md`](TRADUCTION.md)
