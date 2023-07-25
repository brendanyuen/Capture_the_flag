class FBullet extends FBox{
  int timer;
  FBullet(){
  super(10, 10);
  this.setFillColor(#F2822C);
    this.setPosition(player1.getX()+gridsize, player1.getY());
    timer=120;
    world.add(this);
  }
  
  void act(){
 timer--;
 if(timer==0){
  world.remove(this);
  bullet=null;
 }
  this.setVelocity(300,0);
  
  
  }
  
}
