# Guide traducteur — Dies Irae FR

Tu as reçu un fichier `chunk_XX.txt` à traduire. Voici comment procéder.

---

## Option A — Outil in-browser (recommandé)

Aucune installation requise. Fonctionne dans n'importe quel navigateur moderne.

1. Ouvrir `site/translate.html` dans ton navigateur
   (ou la version hébergée sur GitHub Pages si disponible)

2. Glisser ton fichier `chunk_XX.txt` dans la zone de dépôt

3. L'interface affiche :
   - **Panneau gauche** : liste de toutes les entrées (vert = traduit, gris = à faire)
   - **Panneau droit** : texte source anglais + champ de traduction française

4. Traduire :
   - Taper la traduction dans le champ du bas
   - `Ctrl + Entrée` = sauvegarder et passer à l'entrée suivante
   - Ou cliquer **Sauvegarder & Suivant**

5. Filtrer les entrées non traduites : bouton **"À traduire"** en haut

6. Quand terminé : cliquer **↓ Exporter** → télécharge `chunk_traduit.txt`

7. Envoyer `chunk_traduit.txt` au coordinateur

---

## Option B — Éditeur de texte (Notepad++, VSCode…)

Format du fichier :

```
◇00000042◇The sky is burning red tonight.
◆00000042◆The sky is burning red tonight.

◇00000043◇What does it matter?
◆00000043◆What does it matter?
```

**À faire** : remplacer uniquement le texte après `◆index◆` par la traduction française.

```
◇00000042◇The sky is burning red tonight.
◆00000042◆Le ciel brûle d'un rouge écarlate ce soir.

◇00000043◇What does it matter?
◆00000043◆Quelle importance ?
```

**Règles importantes :**
- Ne jamais modifier les lignes `◇` (original)
- Ne jamais modifier les indices (`◆00000042◆`)
- Conserver les sauts de ligne internes (entrées multi-lignes)
- Ne pas supprimer les lignes vides entre les blocs
- Encoding du fichier : **UTF-8** (pas UTF-8 BOM, pas ANSI)

---

## Bonnes pratiques de traduction

### Noms propres
Utiliser les noms japonais/anglais officiels. Dies Irae a une localisation anglaise officielle — s'en inspirer pour le registre.

| Anglais | Français recommandé |
|---------|-------------------|
| Reinhard | Reinhard (inchangé) |
| the Holy Reich | le Saint-Reich |
| Longinus | Longinus (inchangé) |
| Briah | Briah (inchangé) |
| Ahnenherbe | Ahnenherbe (inchangé) |

### Registre
- Fujii Ren parle de façon décontractée → tutoiement, langage familier
- Les personnages du Longinus Dreizehn Orden sont solennels → vouvoiement ou registre soutenu approprié
- Les monologues philosophiques → registre soutenu, phrase longues acceptables

### Honorifiques
Les honorifiques japonais (`-san`, `-kun`, `-chan`) peuvent être omis ou remplacés par un équivalent français selon le contexte.

---

## Questions ?

Ouvrir une issue sur le repo GitHub ou contacter le coordinateur.
