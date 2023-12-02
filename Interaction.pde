


void mousePressed() {//Fonction lorsqu'on clic

  //Selection de case
  if (victorieux == 0 && mouseX > posEchX && mouseX < posEchX+dimEch && mouseY > posEchY && mouseY < posEchY+dimEch) {
    PVector clic = new PVector( int((mouseX-posEchX)/dimCase), int((mouseY-posEchY)/dimCase) );
    caseSelectionner(clic);
  }

  //réinitialisation echiquier
  if (mouseX > w-w/10 && mouseY > h-h/10) {
    reinitialisation();
  }
  if (mouseY > posEchY+dimCase*9.37 && mouseY < posEchY+dimCase*9.37+dimCase) {
    for (int i = -1; i <= nIAMax; i ++) {
      if (mouseX > dimCase/5+dimCase*(i+2) && mouseX < dimCase/5+dimCase*(i+3)) {
        nIA = i;
      }
    }
    
  }
}

void reinitialisation() {
  echiquierAff.initial();
  victorieux = 0;
  caseSelect = new PVector(-1, -1); // case sélectionnée, si x négatif, aucune case sélectionnée
  casesPoss = new int[0][2];//cases où la piece selectionnée peut aller
  float r = random(0, 1);
  if (r<0.5) {
    equipeBlanche = 1;
  } else {
    equipeBlanche = -1;
  }
  tour = equipeBlanche;
}



void caseSelectionner(PVector clic) {//ce qu'il se passe lorsqu'on selectionne une case
  int xTemp = int(clic.x);
  int yTemp = int(clic.y);

  if (!dedans(yTemp, xTemp, casesPoss)) {//si on clic sur une cases qui n'est pas un déplacement possible on selectionne une nouvelle case
    caseSelect = clic;
    if (xTemp >= 0 && yTemp >= 0) {
      casesPoss = echiquierAff.e[yTemp][xTemp].deplacementPossible(yTemp, xTemp, echiquierAff.e, echecs);
    } else {
      casesPoss = new int[0][2];
    }
  } else if ( echiquierAff.e[int(caseSelect.y)][int(caseSelect.x)].equipe == tour ) {//on clic sur une case de déplacement -> on y déplace la piece si c'est notre tour
    if ( (nIA >= 0 && tour == -1) || nIA < 0) {
      echiquierAff.deplacement(int(caseSelect.y), int(caseSelect.x), yTemp, xTemp);
      finTour();
    }
  }
}



boolean dedans(int xd, int yd, int liste[][]) {//dit si xd,yd est dans liste[nombre][2] -> Utile dans caseSelectionner
  boolean rep = false;
  int i = 0;
  while (!rep && i < liste.length) {
    rep = (xd == liste[i][0] && yd == liste[i][1]);
    i ++;
  }
  return rep;
}