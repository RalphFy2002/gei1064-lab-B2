# Conception VLSI - Filtre FIR Adaptatif (Algorithme LMS)

Ce projet a été réalisé dans le cadre du cours **GEI1064 : Conception en VLSI** à l'Université du Québec à Trois-Rivières (UQTR).

## Description
L'objectif de ce laboratoire est la conception et l'implémentation matérielle en **VHDL** d'un filtre adaptatif **FIR-LMS**. Le système ajuste dynamiquement ses coefficients pour minimiser l'erreur entre une sortie estimée et un signal de référence.

### Architecture du système :
Le design est composé de deux blocs principaux interconnectés :
1. **Unité LMS :** Comprend deux types de processeurs adaptatifs :
   * **PE_adpt_1 :** Calcule la différence entre la sortie estimée et la référence, puis multiplie l'erreur par le pas d'adaptation ($\mu$).
   * **PE_adpt_2 :** Met à jour les 5 coefficients de pondération ($w_1$ à $w_5$) en utilisant les versions décalées du signal d'entrée.
2. **Filtre FIR :** Une structure à 5 étages utilisant des registres à décalage pour traiter le signal d'entrée avec les coefficients dynamiques fournis par l'unité LMS.

## Validation et Résultats
La validation a été effectuée en comparant l'implémentation matérielle (VHDL/Vivado) avec un modèle de référence algorithmique développé sous **MATLAB**. 

* **Concordance :** Les résultats de simulation montrent une forte concordance entre les valeurs de sortie Vivado et MATLAB.
* **Précision :** Le succès du filtrage valide les choix de quantification et de troncature (passage de 16 bits à 8 bits) effectués lors de la conception des processeurs.

## Outils utilisés
* **VHDL** : Description matérielle structurelle.
* **Vivado** : Synthèse et simulation temporelle.
* **MATLAB** : Modélisation algorithmique et comparaison de signaux.

## Auteur
* **Ralph Futa** - Étudiant en génie électrique (concentration génie informatique), UQTR.
* **Présenté à :** M. Messaoud Ahmed Ouameur.
