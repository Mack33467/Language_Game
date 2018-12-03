class resultsTable extends gameState {
int[] palette;
HashMap<String, PImage[]> associations;  

  resultsTable(paletteControls p){
    palette = p.palette;
    page = "END";
    associations = new HashMap();
  }
  
}
