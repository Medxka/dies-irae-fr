# Réinjection et packaging du patch

Ce document explique comment recompiler les traductions et produire le fichier `data5.dat` à distribuer.

---

## Prérequis

- Malie_Script_Tool compilé (voir [`EXTRACTION.md`](EXTRACTION.md))
- `patch.en.dat` original (extrait du jeu)
- Tous les chunks traduits dans `chunks/`
- GARbro (pour packager l'archive finale)
- .NET 8 SDK installé

---

## Étape 1 — Fusionner les chunks traduits

Placer tous les fichiers `chunk_XX.txt` traduits dans le dossier `chunks/`, puis :

```powershell
.\tools\merge_chunks.ps1
# Produit : C:\dies-irae-extract\messages_fr.txt
```

Vérifier le nombre d'entrées affiché — doit correspondre au total du fichier source.

---

## Étape 2 — Injecter le texte français dans le script

```powershell
$env:PATH += ";C:\Program Files\dotnet"
$tool  = "chemin\vers\Malie_Script_Tool.dll"
$input = "C:\dies-irae-extract\patch.en.dat"
$txt   = "C:\dies-irae-extract\messages_fr.txt"
$out   = "C:\dies-irae-extract\patch.fr.dat"

dotnet $tool -i -in $input -txt $txt -out $out
```

> **Note sur la taille** : le fichier de sortie sera plus petit que l'original (recompaction des chaînes par le tool). C'est normal et attendu.

> **En cas d'erreur** : vérifier que le Malie_Script_Tool est bien la version patchée (avec `parseRequired: false`). Sans ce patch, le tool plante sur certaines instructions TJUMP invalides.

---

## Étape 3 — Packager dans une archive Malie (data5.dat)

Le moteur Malie charge les archives dans l'ordre numérique décroissant.
`data5.dat` a priorité sur `data4.dat` — le patch anglais de base.

### Avec GARbro

1. Ouvrir GARbro
2. Aller dans **Tools → Create Archive**
3. Choisir le format **Malie/libm** (ou le même format que data4.dat)
4. Ajouter `patch.fr.dat` à l'archive
5. Nommer la sortie `data5.dat`
6. Créer l'archive

### Alternative — copier data5.dat existant

Si le jeu a déjà un `data5.dat` (DLC) :
1. Extraire son contenu avec GARbro
2. Remplacer `patch.en.dat` par `patch.fr.dat` dedans (renommer en `patch.en.dat`)
3. Recréer l'archive

---

## Étape 4 — Installer le patch

1. Copier `data5.dat` dans le dossier du jeu (là où se trouve `DiesIrae.exe`)
2. Lancer le jeu — le texte français apparaît immédiatement
3. Aucune autre modification nécessaire

```
Steam/steamapps/common/Dies irae Amantes amentes/
├── DiesIrae.exe
├── data4.dat          ← patch anglais original (ne pas toucher)
├── data5.dat          ← ← ← coller ici
└── ...
```

---

## Vérification

Pour tester sans packager :

```powershell
# Vérifier que la réinjection produit un fichier valide
# (le moteur Malie doit accepter le .dat sans crash au démarrage)
dotnet $tool -d -in $out -out test_disasm.txt
# Si aucune erreur → le fichier est syntaxiquement valide
```

---

## Distribution

Le fichier `data5.dat` final peut être :
- Hébergé directement sur GitHub Releases (si < 2 GB)
- Distribué via un lien externe (Google Drive, Mega, etc.) si trop lourd

Mettre à jour la page `site/index.html` :
- Changer le `href` du bouton de téléchargement
- Mettre à jour le % d'avancement dans le tableau `contributors`

---

## Résumé de la chaîne complète

```
messages_en.txt
      │
      ▼ (traducteurs humains)
messages_fr.txt
      │
      ▼ dotnet Malie_Script_Tool.dll -i
patch.fr.dat
      │
      ▼ GARbro → packager
data5.dat
      │
      ▼ copier dans le dossier du jeu
[jeu en français]
```
