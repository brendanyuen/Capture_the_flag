import fisica.*;
color black=#000000;
PImage flagpic;
boolean upkey,downkey,leftkey,rightkey,spacekey,rkey;
boolean akey,dkey,skey,wkey,ekey;
boolean flagcaptured,flagcaptured2;
PImage map;
FBullet bullet=null;
FBullet2 bullet2=null;
int x=0;
int y=0;
float zoomfactor;
int score1,score2;
int vx;
int vx2;
int count;
int gridsize =50;
ArrayList <FBox> boxes=new ArrayList <FBox>();

ArrayList<PImage>idle;
ArrayList<PImage>run;
ArrayList<PImage>runleft;
ArrayList<PImage>jump;
ArrayList<PImage>shoot;
ArrayList<PImage>idle2;
ArrayList<PImage> currentAction;
int spriteNum;
int frame=0;
FBox player1;
FBox player2;
FBox flag;
FBox flag2;
FWorld world;

void setup(){
  size(950,700);
  imageMode(CENTER);
  flagpic=loadImage("flag.png");
  flagpic.resize(50,50);
 Fisica.init(this);
 world=new FWorld(-100000,-1000000,10000,100000);
 world.setGravity(0,0);
 world.setEdges(10,10,width-10,height-10);
 
 flag=new FBox(50,50);
 flag.setStatic(true);
 flag.setName("red flag");
 flag.setFill(0,0);
 flag.setStroke(255);
 flag.setPosition(100,height/2);
 flag.attachImage(flagpic);
 flag.setSensor(true);
 flag.setGrabbable(false);
 world.add(flag);
  flag2=new FBox(50,50);
 flag2.setStatic(true);
 flag2.setName("red flag");
 flag2.setFill(0,0);
 flag2.setStroke(255);
 flag2.setPosition(900,height/2);
 flag2.attachImage(flagpic);
 flag2.setSensor(true);
 flag2.setGrabbable(false);
 world.add(flag2);
 player1=new FBox(30,30); 
 player1.setPosition(50,0);
 player1.setNoFill();
 player1.setNoStroke();
 world.add(player1);
 
  player2=new FBox(30,30); 
 player2.setPosition(900,0);
 player2.setFill(0,200,0);
 player2.setNoStroke();
 world.add(player2);
 map= loadImage("map.png");
 
 idle=new ArrayList<PImage>();
 idle2=new ArrayList<PImage>();
 run=new ArrayList<PImage>();
 runleft=new ArrayList<PImage>();
 jump=new ArrayList<PImage>();
 shoot=new ArrayList<PImage>();
 //int i=0;
 //for(int y=0;y<500; y=y+50){
 // for(int x=0;x<350;x=x+50){
 //  megamanSprites[i] 
    
 // }
   
 //}
 run.add(loadImage("megaman1.png"));
  run.add(loadImage("megaman2.png"));
  run.add(loadImage("megaman3.png"));
 runleft.add(loadImage("megaman1.5.png"));
 runleft.add(loadImage("megaman2.5.png"));
 runleft.add(loadImage("megaman3.5.png"));
 idle.add(loadImage("megaman0.png"));
 shoot.add(loadImage("megaman24.png"));
  shoot.add(loadImage("megaman25.png"));
   shoot.add(loadImage("megaman26.png"));
    shoot.add(loadImage("megaman27.png"));
 
 
 currentAction=idle;
 
 //image(run[frame],50,50);
 //if(frameCount %10==0){
 //  frame++;
 //  if(frame==3){
 //   frame=0; 
 //  }
   
   
 //}
 
 
 //load world
 
 while(y<map.height){//keep going until we get to thr end of the map image
   
   color c=map.get(x,y);  //get a pixel's color from the math 
   println(c);            //process it
   
   if (c==black){
    FBox b= new FBox(gridsize,gridsize);
    b.setFillColor(black);
    b.setPosition(x*gridsize,y*gridsize);
    b.setStatic(true);
    world.add(b);
    boxes.add(b);
    
   }
   
   
   x++;  //move down the row
   
   if(x==map.width){ //if we get to the end of the row  
    x=0;             //then go back to the beginning
    y++;             //and down to the next row
   }
 }
  
}



void draw(){
  background(255);
  
  pushMatrix();

  
  
  vx=0;
  if(leftkey) {vx=-500;
   player2.setVelocity(vx,player2.getVelocityY());

  
  }
  if(akey){vx2=-500;
  player1.setVelocity(vx2,player1.getVelocityY()); currentAction=runleft;}
  
  if (rightkey){ vx=500;
  player2.setVelocity(vx,player2.getVelocityY());


}

if(!akey&&!dkey){
 currentAction=idle;
 
  
}

if(dkey){
 vx2=500;
 player1.setVelocity(vx2,player1.getVelocityY());currentAction=run;
}
if (downkey) player2.setVelocity (player2.getVelocityX(),500);
if(skey)player1.setVelocity (player1.getVelocityX(),500);



    



 
  if(upkey)player2.setVelocity (player2.getVelocityX(),-500);
  
  if(wkey)player1.setVelocity (player1.getVelocityX(),-500);
  
  if(ekey&&bullet==null){
   bullet =new FBullet(); currentAction=shoot;
  }
  
  if(spacekey&&bullet2==null){
   bullet2=new FBullet2();
   
  }
  
  if(bullet!=null) bullet.act();

if(bullet2!=null) bullet2.act();

 count++;
    if (count==THRESHOLD) {
      count=0;
      spriteNum++;
     
    }
    
   if (spriteNum>=currentAction.size()) {
      spriteNum=0;
    }
    imageMode(CENTER);
    image(currentAction.get(spriteNum), player1.getX(), player1.getY(), 50, 50);
       

  world.step();
  world.draw();
  //if(flagcaptured==true){
  //  image(flagpic,player2.getX(),player2.getY()); if(player2.getX()>500){
  //  score2++;
  //  flag.attachImage(flagpic);
  // flagcaptured=false; 
  //}
  //}
 //   if(flagcaptured2==true){
 //   image(flagpic,player1.getX(),player1.getY());
  
 //if(player1.getX()<500){
 //   score1++;
 //   flag2.attachImage(flagpic);
 //  flagcaptured2=false; 
 //}}
 
 ArrayList<FContact> contactsplayer22=player2.getContacts();
 for(FContact bu: contactsplayer22){
  if(bu.contains(bullet)){world.remove(bullet);
     player2.setPosition(900,height/2);
    flag.setPosition(100,height/2);
    if(flagcaptured==true){
    flag.attachImage(flagpic);
   flagcaptured=false;
  }}
 }
  ArrayList<FContact> contactsplayer11=player1.getContacts();
 for(FContact bu2: contactsplayer11){
  if(bu2.contains(bullet2)){world.remove(bullet2);
     player1.setPosition(100,height/2);
    flag2.setPosition(900,height/2);
    if(flagcaptured2==true){
    flag2.attachImage(flagpic);
   flagcaptured2=false;
  }}
 }
 

 
ArrayList<FContact> contactsflag=flag.getContacts();
for (FContact f : contactsflag) {
    if (f.contains(player2)) {
flag.dettachImage();
flagcaptured=true;}//player1.attachImage(flagpic);}
}ArrayList<FContact> contactsflag2=flag2.getContacts();
for (FContact f2 : contactsflag2) {
    if (f2.contains(player1)) {
flag2.dettachImage();
flagcaptured2=true;}}
ArrayList<FContact> containsplayer1=player1.getContacts();
for (FContact p1 : containsplayer1) {
    if (p1.contains(player2)&&player1.getX()<500) {
    player2.setPosition(900,height/2);
    flag.setPosition(100,height/2);
    if(flagcaptured==true){
    flag.attachImage(flagpic);
   flagcaptured=false;
     
    }
    }
    }ArrayList<FContact> containsplayer2=player2.getContacts();
for (FContact p2 : containsplayer2) {
  
    if (p2.contains(player1)&&player2.getX()>500) {
    player1.setPosition(100,height/2);
    flag2.setPosition(900,height/2);
    if(flagcaptured2==true){
     flag2.attachImage(flagpic);
   flagcaptured2=false; 

    
    }}
    }
     if(flagcaptured==true){
    image(flagpic,player2.getX(),player2.getY()); if(player2.getX()>908){
    score2++;
    flag.attachImage(flagpic);
   flagcaptured=false; 
 
  }}  if(flagcaptured2==true){
    image(flagpic,player1.getX(),player1.getY());
  
 if(player1.getX()<41){
    score1++;
    flag2.attachImage(flagpic);
   flagcaptured2=false; 
 }}println(player2.getX());
textSize(20);fill(0);
fill(0);
  text(score1,100,100);
  text(score2,700,100);
  
  if (score1>=3) {

    text("Player 1 Wins Press r to restart", width/2-100, height/2);
  if(rkey){
  score1=0;score2=0;player1.setPosition(50,height/2);player1.setVelocity(0,0);
  player2.setVelocity(0,0);
player2.setPosition(900,height/2);}}

 if (score2>=3) {

    text("Player 2 Wins Press r to restart", width/2-100, height/2);
  if(rkey){
  score1=0;score2=0;player1.setPosition(50,height/2);player1.setVelocity(0,0);
  player2.setVelocity(0,0);
player2.setPosition(900,height/2);}}
  popMatrix();
}


void keyPressed(){
  if(keyCode==UP) upkey=true;
  if(keyCode==DOWN) downkey=true;
  if(keyCode==LEFT) leftkey=true;
  if(keyCode==RIGHT) rightkey=true;
  if(key==' ')spacekey=true;
  
 
  if (key=='a') akey=true;
  if (key=='d') dkey=true;
  if (key=='s') skey=true;
  if (key=='w') wkey=true;
  if(key=='e') ekey=true;
   if (key=='r'||key=='R')rkey=true;
}



void keyReleased(){
  
    if(keyCode==UP) upkey=false;
  if(keyCode==DOWN) downkey=false;
  if(keyCode==LEFT) leftkey=false;
  if(keyCode==RIGHT) rightkey=false;
  if(key==' ')spacekey=false;
  
  if (key=='a') akey=false;
  if (key=='d') dkey=false;
  if (key=='s') skey=false;
  if (key=='w') wkey=false;
  if(key=='e') ekey=false;
  if (key=='r'||key=='R')rkey=false;
}
