float valeurEmplacementIA2 = 2;

int profondeurIA2 = 5;

int transitionMagie[][];
int nMagie;


float evaluationIA2(Piece echiquier[][]) {
  float points = 0;

  for (int ligne = 0; ligne < 8; ligne ++) {
    for (int colonne = 0; colonne < 8; colonne ++) {
      points += echiquier[ligne][colonne].valeur*echiquier[ligne][colonne].equipe;
      points += valeurEmplacementIA2*(ligne-3.5)*echiquier[ligne][colonne].equipe;
      points += valeurEmplacementIA2*( 7-abs(ligne-3.5)+ abs(colonne-3.5))*echiquier[ligne][colonne].equipe;
    }
  }
  return points;
}

void IA2() {

  ArrayList<Echiquier> lesEchiquiers[] = new ArrayList[profondeurIA2+1];//new ArrayList<Piece[][]>() ;
  ArrayList<Integer> parents[] = new ArrayList[profondeurIA2];
  ArrayList<int[]> movInit = new ArrayList<int[]>();

  lesEchiquiers[0] = new ArrayList<Echiquier>();
  for (int i = 0; i < profondeurIA2; i++) {
    lesEchiquiers[i+1] = new ArrayList<Echiquier>();
    parents[i] = new ArrayList<Integer>();
  }
  lesEchiquiers[0].add(echiquierAff);

  for (int p = 0; p<profondeurIA2; p++) {

    for (int e = 0; e < lesEchiquiers[p].size(); e ++) {

      if (p%2 == 1) {//tour de l'ennemi

        Echiquier echiquierFilsM[] = magie(lesEchiquiers[p].get(e), -1);
        Echiquier echiquierFils[] = new Echiquier[nMagie];
        for (int l =0; l<nMagie; l++) {
          echiquierFils[l]=echiquierFilsM[l];
        }
        float min = evaluationIA2(echiquierFils[0].e);
        int iMin = 0;
        for (int i = 0; i < nMagie; i ++) {
          float val = evaluationIA2(echiquierFils[i].e);
          if (val < min) {
            min = val;
            iMin = i;
          } else if (val == min) {
            float r = random(0, 1);
            if (r < 0.5) {
              min = val;
              iMin = i;
            }
          }
        }
        //printlnE(echiquierFils[iMin]);
        lesEchiquiers[p+1].add(echiquierFils[iMin]);
        parents[p].add(e);
      } else {
        Echiquier echiquierFilsM[] = magie(lesEchiquiers[p].get(e), 1);
        Echiquier echiquierFils[] = new Echiquier[nMagie];
        for (int l =0; l<nMagie; l++) {
          echiquierFils[l]=echiquierFilsM[l];
        }
        for (int n = 0; n < echiquierFils.length; n ++) {
          lesEchiquiers[p+1].add(echiquierFils[n]);
          parents[p].add(e);
        }
      }
      if (p == 0) {
        for (int c =0; c<transitionMagie.length; c++) {
          movInit.add(transitionMagie[c]);
        }
      }
    }
  }

  int iMax = 0;
  float max = evaluationIA2(lesEchiquiers[profondeurIA2].get(0).e);
  for (int i = 1; i < lesEchiquiers[profondeurIA2].size(); i ++) {
    float val = evaluationIA2(lesEchiquiers[profondeurIA2].get(i).e);
    if (val > max) {
      max = val;
      iMax = i;
    } else if (val == max) {
      float r = random(0, 1);
      if (r < 0.5) {
        max = val;
        iMax = i;
      }
    }
  }
  //println("----------------------------------------");
  //printlnE(lesEchiquiers[profondeurIA2].get(iMax));

  int iIni = iMax;
  int pp = profondeurIA2-1;
  while (pp > 0) {
    //println(iIni);
    iIni = parents[pp].get(iIni);
    //println("----------------------------------------");
    //printlnE(lesEchiquiers[profondeurIA2].get(iIni));
    pp--;
  }
  //println("----------------------------------------");
  //printlnE(lesEchiquiers[0].get(0));
  //printlnE(echiquierAff);

  echiquierAff.deplacement(movInit.get(iIni)[0], movInit.get(iIni)[1], movInit.get(iIni)[2], movInit.get(iIni)[3]);
  //echiquierAff = lesEchiquiers[1].get(iIni);
  //println(iIni);
  //println("Fin-----------------------#####################################");
  finTour();
}


Echiquier[] magie(Echiquier echiquierBase, int equipe) {
  int mouvements[][] = new int[1024][4];
  Echiquier echiquierR[] = new Echiquier[1024];
  int nEchiquier = 0;


  Piece pieceIA[] = new Piece[64];
  int positionPieceIA[][] = new int[64][2];
  int nPieceIA = 0;

  for (int ligne = 0; ligne < 8; ligne ++) {
    for (int colonne = 0; colonne < 8; colonne ++) {
      if (echiquierBase.e[ligne][colonne].equipe == equipe) {
        pieceIA[nPieceIA] = echiquierBase.e[ligne][colonne];
        positionPieceIA[nPieceIA][0] = ligne;
        positionPieceIA[nPieceIA][1] = colonne;
        nPieceIA ++;
      }
    }
  }

  for (int i = 0; i < nPieceIA; i ++) {
    int[][] mvtPoss = pieceIA[i].deplacementPossible(positionPieceIA[i][0], positionPieceIA[i][1], echiquierBase.e, echecs);
    int tailleMvtPoss = mvtPoss.length;
    //nM[i] = tailleMvtPoss;
    if (tailleMvtPoss > 0) {
      for (int m = 0; m < tailleMvtPoss; m ++) {

        Echiquier echiquierTransition = new Echiquier();
        echiquierTransition.defEchi(echiquierBase.copieEchiquier());
        //for (int l = 0; l < 8; l ++) {
        //  for (int c = 0; c < 8; c  ++ ) {
        //    echiquierTransition[l][c] = echiquierBase[l][c];
        //  }
        //}
        echiquierTransition.deplacement(positionPieceIA[i][0], positionPieceIA[i][1], mvtPoss[m][0], mvtPoss[m][1]);
        //Piece echiquierTest[][] = echiquierTransition.copieEchiquier();
        //valeurMvt[i][m] = evaluation(echiquierTest);

        echiquierR[nEchiquier] = echiquierTransition;
        int move[] = {positionPieceIA[i][0], positionPieceIA[i][1], mvtPoss[m][0], mvtPoss[m][1]};
        mouvements[nEchiquier] = move;
        nEchiquier ++;
      }
    }
  }
  transitionMagie = new int[nEchiquier][4];

  Echiquier echiquierRep[] = new Echiquier[nEchiquier];
  for (int i = 0; i <nEchiquier; i ++) {
    echiquierRep[i] = echiquierR[i];
  }
  for (int i = 0; i < nEchiquier; i ++) {
    transitionMagie[i] = mouvements[i];
  } 
  nMagie = nEchiquier;
  return echiquierRep;
}