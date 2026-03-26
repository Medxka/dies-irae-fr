# Dies Irae ~Amantes amentes~ — Patch Français

Projet communautaire de traduction française de **Dies Irae ~Amantes amentes~** (VN, Light/Âge).
Ce repo contient les outils pour extraire, traduire et réinjecter le texte du jeu.

**👾 Rejoins le Discord pour participer à la traduction : [discord.gg/76MkXzs9UX](https://discord.gg/76MkXzs9UX)**

---

## Structure du repo

```
├── tools/
│   ├── split_for_collab.ps1   # Découpe messages_en.txt en chunks pour les traducteurs
│   └── merge_chunks.ps1       # Recolle les chunks traduits en messages_fr.txt
├── site/
│   ├── index.html             # Site de distribution du patch
│   └── translate.html         # Outil de traduction in-browser (aucun serveur requis)
├── docs/
│   ├── EXTRACTION.md          # Comment extraire le texte du jeu
│   ├── TRADUCTION.md          # Guide pour les traducteurs
│   └── REINJECTION.md         # Comment réinjecter et packager le patch
└── README.md
```

---

## Prérequis

- **Dies Irae ~Amantes amentes~** (version Steam EN)
- **GARbro** — pour extraire/packager les archives `.dat` → [lien GitHub](https://github.com/morkt/GARbro)
- **.NET 8 SDK** — pour compiler et utiliser Malie_Script_Tool → [dotnet.microsoft.com](https://dotnet.microsoft.com/download)
- **Malie_Script_Tool** (fork patché) — voir [`docs/EXTRACTION.md`](docs/EXTRACTION.md)

---

## Démarrage rapide

### Tu veux traduire un chunk ?
→ Voir [`docs/TRADUCTION.md`](docs/TRADUCTION.md)

### Tu veux reconstruire le patch ?
→ Voir [`docs/REINJECTION.md`](docs/REINJECTION.md)

### Tu veux tout refaire depuis zéro ?
→ Voir [`docs/EXTRACTION.md`](docs/EXTRACTION.md)

---

## Avancement

| Chunk | Traducteur | Statut |
|-------|-----------|--------|
| 01    | —         | Disponible |
| 02    | —         | Disponible |
| 03    | —         | Disponible |
| 04    | —         | Disponible |
| 05    | —         | Disponible |
| 06    | —         | Disponible |
| 07    | —         | Disponible |
| 08    | —         | Disponible |
| 09    | —         | Disponible |
| 10    | —         | Disponible |

Pour prendre en charge un chunk, ouvrir une issue ou rejoindre le [Discord](https://discord.gg/76MkXzs9UX).

---

*Fan project non officiel. Dies Irae ~Amantes amentes~ © Light/Âge.*
