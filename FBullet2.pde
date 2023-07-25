class FBullet2 extends FBox{
  int timer;
  FBullet2(){
  super(10, 10);
  this.setFillColor(#F2822C);
    this.setPosition(player2.getX()-gridsize, player2.getY());
    timer=120;
    world.add(this);
  }
  
  void act(){
 timer--;
 if(timer==0){
  world.remove(this);
  bullet2=null;
 }
    this.setVelocity(-300,0);
  }
  
}
