Table table;
int num_rows;
PImage weather_img;
PImage condition_img;
PImage security_img;

color high_col = color(127,0,0,127);
color med_col = color(255,255,0,127);
color low_col = color(0,0,255,127);
color no_data_col = color(255,127);


void setup(){
  // Window size
  size(1600,1024);  // , SVG, "A4Output.svg"
  background(255);
  // Load data
  table = loadTable("dublin_bike_parking-updated.csv", "header");
  weather_img = loadImage("weather.png");
  condition_img = loadImage("condition.png");
  security_img = loadImage("security.png");
  
  num_rows = table.getRowCount();
  println(table.getRowCount() + " total rows in table"); 
  
  PFont font = createFont("Arial",16,true);  // True for Anti-aliasing
  textFont(font, 30);  // Arg 2 is font size
  textAlign(CENTER, CENTER);
  // Title text
  fill(0);
  text("Dublin Bike Cycle Stand Distribution", 800, 60);
  
  
  fill(0, 255, 0, 127);
  scale(0.08);
  
  for(int i = 0; i < num_rows; i++){
     float easting = table.getRow(i).getFloat("adjusted_easting");
     float northing = table.getRow(i).getFloat("adjusted_northing");
     ellipse(easting + 1000, northing + 1000, 100, 100);
  }
}

void draw(){
  frameRate(20);
  
  // Legend
  
  PFont font = createFont("Arial",16,true);  // True for Anti-aliasing
  textFont(font, 20);  // Arg 2 is font size
  fill(0);
  textAlign(LEFT, CENTER);
  text("Weather Protection", 1200, 320);
  image(weather_img, 1500, 300, 40, 40);
  text("Stand Condition", 1200, 420);
  image(condition_img, 1500, 400, 40, 40);
  text("Security and Safety Rating", 1200, 520);
  image(security_img, 1500, 500, 40, 40);
 
  text("Values", 1300, 620);
  
  fill(high_col);
  text("High", 1200, 660);
  rect(1500, 640, 40, 40);  
  fill(med_col);
  text("Medium", 1200, 700);
  rect(1500, 680, 40, 40);  
  fill(low_col);
  text("Low", 1200, 740);
  rect(1500, 720, 40, 40);
  
  // Weather Protection
  if(mouseX > 1500 && mouseX < 1540 && mouseY > 300 && mouseY < 340){ 
      scale(0.08);
      drawForCategory("protection_weather");
  }
  else if(mouseX > 1500 && mouseX < 1540 && mouseY > 400 && mouseY < 440){ 
      scale(0.08);
      drawForCategory("physical_condition");
  }
  else if(mouseX > 1500 && mouseX < 1540 && mouseY > 500 && mouseY < 540){ 
      scale(0.08);
      drawForCategory("security_safetyrating");
  }
  else{
      fill(0, 0, 0, 127);
      scale(0.08);
      for(int i = 0; i < num_rows; i++){
         float easting = table.getRow(i).getFloat("adjusted_easting");
         float northing = table.getRow(i).getFloat("adjusted_northing");
         ellipse(easting + 1000, northing + 1000, 100, 100);
      }
  }
}

void drawForCategory(String cat){
  for(int i = 0; i < num_rows; i++){
     float easting = table.getRow(i).getFloat("adjusted_easting");
     float northing = table.getRow(i).getFloat("adjusted_northing");
     if(table.getRow(i).getString(cat).equals("High")){
       fill(high_col);
     }
     else if(table.getRow(i).getString(cat).equals("Medium")){
       fill(med_col);
     }
     else if(table.getRow(i).getString(cat).equals("Low")){
       fill(low_col);
     }
     else{
       fill(no_data_col); 
     }
     ellipse(easting + 1000, northing + 1000, 100, 100);
  } 
}
