
Table table;

void setup(){
  // Window size
  size(1600,1000);
  background(255);
  // Load data
  table = loadTable("minard-data.csv", "header");
  int city_rows = 20;
  int temp_rows = 9;
  int troop_rows = 48;

  for(int i = 0; i < city_rows; i++){
    ellipse(((table.getRow(i).getFloat("LONC")) - 24)*20 + 100, ((table.getRow(i).getFloat("LATC")) - 53.9) * 20 + 100, 10, 10);
  }

  fill(255,0,0);
  for(int i = 0; i < city_rows; i++){
    ellipse(((table.getRow(i).getFloat("LONP")) - 24)*20 + 100, ((table.getRow(i).get("LATP")) - 53.9) * 20 + 100, 5, 5);
  }

}
