abstract class Cell {
  protected color cellColor;

  protected int chanceOfGrass = 0;

  public void setCellColor(color cc) {
    cellColor = cc;
  }
  public color getCellColor() {
    return cellColor;
  }
}
/*
Mulige celler er: sand, land, vand og skov.
 skov kan kun gro på land og ved siden af vand, ikke på sand eller ved siden af sand.
 sand kan blive jord ved at være omgivet af jord.
 jord kan blive sand ved at være omgivet af sand.
 vand kan blive til sand ved at være omgivet af sand.
 sand kan blive til vand ved at være omgivet af vand. 
 */
