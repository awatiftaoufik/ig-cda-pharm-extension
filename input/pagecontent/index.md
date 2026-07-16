### Présentation

Cet IG de test illustre un scénario de mapping CDA → FHIR non trivial : **deux éléments CDA décrivant le même établissement, à deux endroits distincts du document, doivent être fusionnés en une seule ressource FHIR `Organization`**.

### Problème illustré

Dans un document CDA, un même établissement peut apparaître à plusieurs endroits :

| Emplacement CDA | Contenu disponible |
|---|---|
| `custodian / assignedCustodian / representedCustodianOrganization` | Identifiant FINESS, nom, adresse |
| `author / assignedAuthor / representedOrganization` | Identifiant FINESS, nom, téléphone |

Ces deux objets sont fragmentaires mais complémentaires. Le mapping naïf (un objet CDA → une ressource FHIR) produirait deux ressources `Organization` redondantes. L'objectif est d'en produire **une seule**, consolidée.

### Solution : groupe FML multi-sources

La FHIR Mapping Language (FML) permet de définir un groupe recevant **plusieurs sources distinctes** et les appliquant à la même cible. C'est cette technique qui est démontrée ici.

### Contenu de cet IG

- **[Cas d'usage](use-case.html)** : description détaillée du scénario
- **[Approche FML](mapping-approach.html)** : explication de la technique de fusion
- **StructureMap** : [`CDA2FHIR-Organization-Merge`](StructureMap-CDA2FHIR-Organization-Merge.html)
- **Exemple CDA** : [`ExempleCDA-EtablissementDouble.xml`](Binary-ExempleCDA-EtablissementDouble.html)


test