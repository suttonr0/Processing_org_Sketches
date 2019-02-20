// All sections have same angle = 360/#sections
// #sections = 12 for each month (can just visualize a subset for one year of data)

Table table;
int num_rows;

void setup(){
  // Window size
  size(1600,1000);
  background(255);
  // Load data
  table = loadTable("nightingale-data-1.csv", "header");
  
  num_rows = table.getRowCount();
  println(table.getRowCount() + " total rows in table"); 

  PFont f = createFont("Arial",16,true);  // True for Anti-aliasing
  textFont(f, 30);  // Arg 2 is font size
  textAlign(CENTER, CENTER);
  // Title text
  fill(0);
  text("Florence Nightingale's Rose Diagram", 500, 10);

  int num_of_sections = 12;
  
  for(int i = 0; i < num_of_sections; i++){
    float section_angle = i*2*PI/num_of_sections;
    int disease = table.getRow(i).getInt("Zymotic diseases");
    int wound = table.getRow(i).getInt("Wounds & injuries");
    int others = table.getRow(i).getInt("All other causes");
    
    if(disease >= wound && disease >= others){
      // Disease largest, draw first
      drawDisease(disease, section_angle, num_of_sections);
      if(wound >= others){
        // Draw wound second
        drawWound(wound, section_angle, num_of_sections);
        drawOthers(others, section_angle, num_of_sections);
      }
      else{
        // draw others second
        drawOthers(others, section_angle, num_of_sections);
        drawWound(wound, section_angle, num_of_sections);
      }
    }
    
    else if (others >= wound && others >= disease){
      drawOthers(others, section_angle, num_of_sections);
      if(wound >= disease){
        drawWound(wound, section_angle, num_of_sections);
        drawDisease(disease, section_angle, num_of_sections);
      }
      else{
        drawDisease(disease, section_angle, num_of_sections);
        drawWound(wound, section_angle, num_of_sections);
      }
    }
    
    else{
      drawWound(wound, section_angle, num_of_sections);
      if(others >= disease){
        drawOthers(others, section_angle, num_of_sections);
        drawDisease(disease, section_angle, num_of_sections);
      }
      else{
        drawDisease(disease, section_angle, num_of_sections);
        drawOthers(others, section_angle, num_of_sections);
      }  
    }    
    // Label text on screen for months
    // Note: Text is positioned by the centre of its left border
    fill(0);
    text(table.getRow(i).getString("Month"), 500 + 350*cos(section_angle + PI/num_of_sections), 
      500 + 350*sin(section_angle + PI/num_of_sections));
  }
  
  // Second version to demonstrate transformations. 
  // Must be zoomed, repositioned and rotated differently
  // To get original again, just comment out the following
  
  translate(1400, 20);
  rotate(PI/3);
  scale(0.5);
  
  for(int i = 0; i < num_of_sections; i++){
    float section_angle = i*2*PI/num_of_sections;
    int disease = table.getRow(i).getInt("Zymotic diseases");
    int wound = table.getRow(i).getInt("Wounds & injuries");
    int others = table.getRow(i).getInt("All other causes");
    
    if(disease >= wound && disease >= others){
      // Disease largest, draw first
      drawDisease(disease, section_angle, num_of_sections);
      if(wound >= others){
        // Draw wound second
        drawWound(wound, section_angle, num_of_sections);
        drawOthers(others, section_angle, num_of_sections);
      }
      else{
        // draw others second
        drawOthers(others, section_angle, num_of_sections);
        drawWound(wound, section_angle, num_of_sections);
      }
    }
    
    else if (others >= wound && others >= disease){
      drawOthers(others, section_angle, num_of_sections);
      if(wound >= disease){
        drawWound(wound, section_angle, num_of_sections);
        drawDisease(disease, section_angle, num_of_sections);
      }
      else{
        drawDisease(disease, section_angle, num_of_sections);
        drawWound(wound, section_angle, num_of_sections);
      }
    }
    
    else{
      drawWound(wound, section_angle, num_of_sections);
      if(others >= disease){
        drawOthers(others, section_angle, num_of_sections);
        drawDisease(disease, section_angle, num_of_sections);
      }
      else{
        drawDisease(disease, section_angle, num_of_sections);
        drawOthers(others, section_angle, num_of_sections);
      }  
    }
    // Label text on screen for months
    // Note: Text is positioned by the centre of its left border
    fill(0);
    text(table.getRow(i).getString("Month"), 500 + 350*cos(section_angle + PI/num_of_sections), 
      500 + 350*sin(section_angle + PI/num_of_sections)); 
  } 
}

void drawDisease(int disease, float section_angle, int num_of_sections){
  // --- Blue wedge for deaths by Zymotic diseases ---
  fill(0, 0, 128);
  stroke(125, 125, 255);  // Line color
  strokeWeight(4);  // Line thickness
  // Arc angles in radians. Using sqrt so that low values are displayed.
  arc(500, 500, 20*sqrt(disease), 20*sqrt(disease), section_angle, section_angle + 2*PI/num_of_sections);
}

void drawWound(int wound, float section_angle, int num_of_sections){
  // --- Red -> wound deaths ---
  fill(128, 0, 0);
  stroke(255, 125, 125);  // Line color
  strokeWeight(2);  // Line thickness
  arc(500, 500, 20*sqrt(wound), 20*sqrt(wound), section_angle, section_angle + 2*PI/num_of_sections);
}

void drawOthers(int others, float section_angle, int num_of_sections){
  // --- Black -> other deaths ---
  stroke(125, 125, 125);  // Line color
  strokeWeight(1);  // Line thickness
  fill(0, 0, 0);
  arc(500, 500, 20*sqrt(others), 20*sqrt(others), section_angle, section_angle + 2*PI/num_of_sections);
}
