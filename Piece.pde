float valPion = 10;//valeur pas réfléchie
float valTour = 50;
float valCavalier = 50; 
float valFou = 50;
float valReine = 120;
float valRoi = 10000;
float valeurPieces[] = {valPion, valTour, valCavalier, valFou, valReine, valRoi};

class Piece {
  int type; //1 : pion | 2 : tour | 3 : cavalier | 4 : fou | 5 : reine | 6 : roi
  float valeur;// valeur de la pièce | pion : | tour : ...
  int equipe;// equipe de la pièce | haut : 1 | bas : -1 | case vide : 0

  Piece(int typei, float valeuri, int equipei) {
    type = typei;
    valeur = valeuri;
    equipe = equipei;
  }

  int[][] deplacementPossible(int ligne, int colonne, Piece[][] echiquier, int miseEchec) {
    int [][] depPosTot = new int[64][2]; // deplacement possible total : un grand tableau du lequel on rentre tout les mouvements possible et qu'on redimensionne ensuite pour ne pas avoir de case vide
    int nPos = 0;//nombre de position possible

    //if (miseEchec == equipe && type != 6) {
    //} else {

    switch(type) {

      case(1)://pion
      //les premières conditions permettent de ne pas sortir de l'echiquier
      if ( (ligne+equipe >= 0 && ligne+equipe < 8 && echiquier[ligne+equipe][colonne].equipe == 0) ) {//avance
        depPosTot[nPos][0] = ligne+equipe;
        depPosTot[nPos][1] = colonne;
        nPos ++;
      }
      if (ligne == (1-equipe)*3+(equipe+1)/2 && echiquier[ligne+2*equipe][colonne].equipe == 0 && echiquier[ligne+equipe][colonne].equipe == 0) {//double avance
        depPosTot[nPos][0] = ligne+2*equipe;
        depPosTot[nPos][1] = colonne;
        nPos ++;
      }
      if ( ligne+equipe >= 0 && ligne+equipe < 8 && colonne+1 >= 0 && colonne+1 < 8 && echiquier[ligne+equipe][colonne+1].equipe != equipe && echiquier[ligne+equipe][colonne+1].type != 0) {
        depPosTot[nPos][0] = ligne+equipe;
        depPosTot[nPos][1] = colonne+1;
        nPos ++;
      }
      if ( ligne+equipe >= 0 && ligne+equipe < 8 && colonne-1 >= 0 && colonne-1 < 8 && echiquier[ligne+equipe][colonne-1].equipe != equipe && echiquier[ligne+equipe][colonne-1].type != 0) {
        depPosTot[nPos][0] = ligne+equipe;
        depPosTot[nPos][1] = colonne-1;
        nPos ++;
      }
      break;

      case(2)://tour
      int k = 1;
      boolean toucher = false;
      while (ligne-k >= 0 && echiquier[ligne-k][colonne].equipe != equipe && !toucher) {//haut
        depPosTot[nPos][0] = ligne-k;
        depPosTot[nPos][1] = colonne;
        if (echiquier[ligne-k][colonne].equipe != equipe && echiquier[ligne-k][colonne].equipe != 0) {
          toucher = true;
        }
        nPos ++;
        k ++;
      }

      k = 1;
      toucher = false;
      while (ligne+k < 8 && echiquier[ligne+k][colonne].equipe != equipe && !toucher) {//bas
        depPosTot[nPos][0] = ligne+k;
        depPosTot[nPos][1] = colonne;
        if (echiquier[ligne+k][colonne].equipe != equipe && echiquier[ligne+k][colonne].equipe != 0) {
          toucher = true;
        }
        nPos ++;
        k ++;
      }

      k = 1;
      toucher = false;
      while (colonne-k >= 0 && echiquier[ligne][colonne-k].equipe != equipe && !toucher) {//gauche
        depPosTot[nPos][0] = ligne;
        depPosTot[nPos][1] = colonne-k;
        if (echiquier[ligne][colonne-k].equipe != equipe && echiquier[ligne][colonne-k].equipe != 0) {
          toucher = true;
        }
        nPos ++;
        k ++;
      }

      k = 1;
      toucher = false;
      while (colonne+k < 8  && echiquier[ligne][colonne+k].equipe != equipe && !toucher) {//gauche
        depPosTot[nPos][0] = ligne;
        depPosTot[nPos][1] = colonne+k;
        if (echiquier[ligne][colonne+k].equipe != equipe && echiquier[ligne][colonne+k].equipe != 0) {
          toucher = true;
        }
        nPos ++;
        k ++;
      }
      break;

      case(3)://cavalier
      //for (int i = 0; i < 8; i ++) {
      //  for (int j = 0; j  < 8; j ++) {
      //    if ( !(i == ligne || j == colonne) && Math.abs(ligne-i)+Math.abs(j-colonne) == 3 ) {
      //      if (echiquier[i][j].equipe != equipe) {
      //        depPosTot[nPos][0] = i;
      //        depPosTot[nPos][1] = j;
      //        nPos ++;
      //      }
      //    }
      //  }
      //}
      int[][] cases = {{-1, -2}, {1, -2}, {2, -1}, {2, 1}, {1, 2}, {-1, 2}, {-2, 1}, {-2, -1}};
      for (int i = 0; i < 8; i ++) {
        if (ligne+cases[i][0] >= 0 && ligne+cases[i][0] < 8 && colonne+cases[i][1] >= 0 && colonne+cases[i][1] < 8 ) {
          if (echiquier[ligne+cases[i][0]][colonne+cases[i][1]].equipe != equipe) {
            depPosTot[nPos][0] = ligne+cases[i][0];
            depPosTot[nPos][1] = colonne+cases[i][1];
            nPos ++;
          }
        }
      }
      break;

      case(4)://fou
      k = 1;
      toucher = false;
      while (ligne-k >= 0 && colonne-k >= 0 && echiquier[ligne-k][colonne-k].equipe != equipe && !toucher) {//haut gauche
        depPosTot[nPos][0] = ligne-k;
        depPosTot[nPos][1] = colonne-k;
        if (echiquier[ligne-k][colonne-k].equipe != equipe && echiquier[ligne-k][colonne-k].equipe != 0) {
          toucher = true;
        }
        nPos ++;
        k ++;
      }

      k = 1;
      toucher = false;
      while (ligne-k >= 0 && colonne+k < 8 && echiquier[ligne-k][colonne+k].equipe != equipe && !toucher) {//haut droite
        depPosTot[nPos][0] = ligne-k;
        depPosTot[nPos][1] = colonne+k;
        if (echiquier[ligne-k][colonne+k].equipe != equipe && echiquier[ligne-k][colonne+k].equipe != 0) {
          toucher = true;
        }
        nPos ++;
        k ++;
      }

      k = 1;
      toucher = false;
      while (ligne+k < 8 && colonne-k >= 0 && echiquier[ligne+k][colonne-k].equipe != equipe && !toucher) {//bas gauche
        depPosTot[nPos][0] = ligne+k;
        depPosTot[nPos][1] = colonne-k;
        if (echiquier[ligne+k][colonne-k].equipe != equipe && echiquier[ligne+k][colonne-k].equipe != 0) {
          toucher = true;
        }
        nPos ++;
        k ++;
      }

      k = 1;
      toucher = false;
      while (ligne+k < 8 && colonne+k < 8  && echiquier[ligne+k][colonne+k].equipe != equipe && !toucher) {//bas droite
        depPosTot[nPos][0] = ligne+k;
        depPosTot[nPos][1] = colonne+k;
        if (echiquier[ligne+k][colonne+k].equipe != equipe && echiquier[ligne+k][colonne+k].equipe != 0) {
          toucher = true;
        }
        nPos ++;
        k ++;
      }

      break;

      case(5): //reine
      k = 1;
      toucher = false;
      while (ligne-k >= 0 && echiquier[ligne-k][colonne].equipe != equipe && !toucher) {//haut
        depPosTot[nPos][0] = ligne-k;
        depPosTot[nPos][1] = colonne;
        if (echiquier[ligne-k][colonne].equipe != equipe && echiquier[ligne-k][colonne].equipe != 0) {
          toucher = true;
        }
        nPos ++;
        k ++;
      }

      k = 1;
      toucher = false;
      while (ligne+k < 8 && echiquier[ligne+k][colonne].equipe != equipe && !toucher) {//bas
        depPosTot[nPos][0] = ligne+k;
        depPosTot[nPos][1] = colonne;

        if (echiquier[ligne+k][colonne].equipe != equipe && echiquier[ligne+k][colonne].equipe != 0) {
          toucher = true;
        }
        nPos ++;
        k ++;
      }

      k = 1;
      toucher = false;
      while (colonne-k >= 0 && echiquier[ligne][colonne-k].equipe != equipe && !toucher) {//gauche
        depPosTot[nPos][0] = ligne;
        depPosTot[nPos][1] = colonne-k;
        if (echiquier[ligne][colonne-k].equipe != equipe && echiquier[ligne][colonne-k].equipe != 0) {
          toucher = true;
        }
        nPos ++;
        k ++;
      }

      k = 1;
      toucher = false;
      while (colonne+k < 8  && echiquier[ligne][colonne+k].equipe != equipe && !toucher) {//gauche
        depPosTot[nPos][0] = ligne;
        depPosTot[nPos][1] = colonne+k;
        if (echiquier[ligne][colonne+k].equipe != equipe && echiquier[ligne][colonne+k].equipe != 0) {
          toucher = true;
        }
        nPos ++;
        k ++;
      }

      k = 1;
      toucher = false;
      while (ligne-k >= 0 && colonne-k >= 0 && echiquier[ligne-k][colonne-k].equipe != equipe && !toucher) {//haut gauche
        depPosTot[nPos][0] = ligne-k;
        depPosTot[nPos][1] = colonne-k;
        if (echiquier[ligne-k][colonne-k].equipe != equipe && echiquier[ligne-k][colonne-k].equipe != 0) {
          toucher = true;
        }
        nPos ++;
        k ++;
      }

      k = 1;
      toucher = false;
      while (ligne-k >= 0 && colonne+k < 8 && echiquier[ligne-k][colonne+k].equipe != equipe && !toucher) {//haut droite
        depPosTot[nPos][0] = ligne-k;
        depPosTot[nPos][1] = colonne+k;
        if (echiquier[ligne-k][colonne+k].equipe != equipe && echiquier[ligne-k][colonne+k].equipe != 0) {
          toucher = true;
        }
        nPos ++;
        k ++;
      }

      k = 1;
      toucher = false;
      while (ligne+k < 8 && colonne-k >= 0 && echiquier[ligne+k][colonne-k].equipe != equipe && !toucher) {//bas gauche
        depPosTot[nPos][0] = ligne+k;
        depPosTot[nPos][1] = colonne-k;
        if (echiquier[ligne+k][colonne-k].equipe != equipe && echiquier[ligne+k][colonne-k].equipe != 0) {
          toucher = true;
        }
        nPos ++;
        k ++;
      }

      k = 1;
      toucher = false;
      while (ligne+k < 8 && colonne+k < 8  && echiquier[ligne+k][colonne+k].equipe != equipe && !toucher) {//bas droite
        depPosTot[nPos][0] = ligne+k;
        depPosTot[nPos][1] = colonne+k;
        if (echiquier[ligne+k][colonne+k].equipe != equipe && echiquier[ligne+k][colonne+k].equipe != 0) {
          toucher = true;
        }
        nPos ++;
        k ++;
      }

      break;

      case(6): // roi
      int[][] cases2 = {{1, 1}, {0, 1}, {-1, 1}, {-1, 0}, {-1, -1}, {0, -1}, {1, -1}, {1, 0}};
      for (int i = 0; i < 8; i ++) {
        if (ligne+cases2[i][0] >= 0 && ligne+cases2[i][0] < 8 && colonne+cases2[i][1] >= 0 && colonne+cases2[i][1] < 8 ) {
          if (echiquier[ligne+cases2[i][0]][colonne+cases2[i][1]].equipe != equipe) {
            depPosTot[nPos][0] = ligne+cases2[i][0];
            depPosTot[nPos][1] = colonne+cases2[i][1];
            nPos ++;
          }
        }
      }

      break;
    }



    int [][] depPosRep = new int[nPos][2]; // on redimensionne le tableau
    if (nPos > 0) {
      for (int i = 0; i < nPos; i ++) {
        depPosRep[i][0] = depPosTot[i][0];
        depPosRep[i][1] = depPosTot[i][1];
      }
    }

    if (equipe != 0 && equipe == miseEchec) {//si l'équipe est en echec
      if (type != 6 && depPosRep.length > 0) {
        boolean sortEchec[] = new boolean [depPosRep.length];
        for (int i = 0; i < depPosRep.length; i ++) {
          Piece echiquierP[][] = new Piece[8][8];
          for (int l = 0; l < 8; l ++) {
            for (int c = 0; c < 8; c ++) {
              echiquierP[l][c] = echiquier[l][c];
            }
          }
          Echiquier echiquierPe = new Echiquier();
          echiquierPe.defEchi(echiquierP);
          echiquierPe.deplacement(ligne, colonne, depPosRep[i][0], depPosRep[i][1]);
          int resEchec = echiquierPe.miseEnEchec();
          if (resEchec != 0) {
            sortEchec[i] = false;
          } else {
            sortEchec[i] = true;
          }
        }
        int nMvt = 0;
        for (int i = 0; i < depPosRep.length; i ++) {
          if (sortEchec[i]) {
            nMvt ++;
          }
        }
        if (nMvt == 0) {
          int vide[][] = new int[0][2];
          depPosRep = vide;
        } else {
          int nouv [][] = new int[nMvt][2];
          int compt = 0;
          for (int i = 0; i < depPosRep.length; i ++) {
            if (sortEchec[i]) {
              nouv[compt] = depPosRep[i];
              compt ++;
            }
          }
          depPosRep = nouv;
        }
      }
    }

    return depPosRep;
  }
}