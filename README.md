# Cartes Duel University

Ce dépôt contient les cartes custom utilisées par le serveur Duel University pour le simulateur Edopro.
Les cartes ont déjà été testées et devraient fonctionner normalement, merci de créer un post dans "Issues" au moindres problème, avec autant de détails que possible et accompagné des codes d'erreur s'il y en a.

Je ne possède aucun artwork utilisé pour les cartes.

## Installation des cartes custom

Pour obtenir les cartes, il faut d'abord installer le fichier de configuration.
Ce fichier se nomme ``user_configs.json`` et se trouvera dans ``` .../ProjectIgnis/config```

### 1er cas : Pas de fichier déjà installé

Si vous ne possédez pas encore le ichier, vous pouvez le télécharger [**ICI**], ou bien le créer vous même.
Pour ce faire, copiez-coller le contenue suivant à l'intérieur :
```json
{
   "repos": [
      {
         "url": "https://github.com/Este98/Cartes-DU",
         "repo_name": "Duel University Custom Card",
         "repo_path": "./repositories/Duel University",
         "should_update": true,
         "should_read": true
      }
	]
}
```

Et voilà. Si tout est bien fait, cette étape est terminée. Vous pouvez passer directement à l'étape suivante.

<details>
<summary>

### 2e cas : Fichier déjà installé
</summary>
<p>

TODO

</p>

## Utiliser les cartes custom