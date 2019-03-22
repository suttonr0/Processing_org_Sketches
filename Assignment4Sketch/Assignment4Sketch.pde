

Table table;
int num_rows;

void setup(){
  // Window size
  size(1600,1024);  // , SVG, "A4Output.svg"
  background(255);
  // Load data
  table = loadTable("dublin_bike_parking-updated.csv", "header");
  
  num_rows = table.getRowCount();
  println(table.getRowCount() + " total rows in table"); 
  
  fill(0, 255, 0, 127);
  scale(0.08);
  
  for(int i = 0; i < num_rows; i++){
     float easting = table.getRow(i).getFloat("adjusted_easting");
     float northing = table.getRow(i).getFloat("adjusted_northing");
     ellipse(easting + 1000, northing + 1000, 100, 100);
  }
}

void draw(){
  frameRate(12);
  if(mouseX > 1000 && mouseY > 512){
    scale(0.08);
    fill(255, 0, 0);
    for(int i = 0; i < num_rows; i++){
       float easting = table.getRow(i).getFloat("adjusted_easting");
       float northing = table.getRow(i).getFloat("adjusted_northing");
       ellipse(easting + 1000, northing + 1000, 100, 100);
    }
  }
  else if (mouseX > 1000 && mouseY < 512){
    scale(0.08);
    fill(0, 0, 255);
    for(int i = 0; i < num_rows; i++){
       float easting = table.getRow(i).getFloat("adjusted_easting");
       float northing = table.getRow(i).getFloat("adjusted_northing");
       ellipse(easting + 1000, northing + 1000, 100, 100);
    }
  }
}
