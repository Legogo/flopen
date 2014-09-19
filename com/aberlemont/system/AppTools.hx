package com.aberlemont.system;
import com.aberlemont.display.GraphicTools;
import flash.display.Sprite;

/**
 * ...
 * @author A.Berlemont
 */
class AppTools
{
  static public function center(app:Sprite):Void {
    var w:Int = Math.floor(app.width);
    var h:Int = Math.floor(app.height);
    var fw:Int = GraphicTools.getStageWidth();
    var fh:Int = GraphicTools.getStageHeight();
    app.x = (fw - w) * 0.5;
    app.y = (fh - h) * 0.5;
  }
  
  static public function scale(app:Sprite):Void {
    var stageWidth:Int = GraphicTools.getStageWidth();
    var stageHeight:Int = GraphicTools.getStageHeight();
    
    var baseGameWidth:Int = 320;
    var baseGameHeight:Int = 480;
    
    var solvedWidth:Int = baseGameWidth;
    var solvedHeight:Int = baseGameHeight;
    
    while (solvedWidth <= stageWidth) { solvedWidth *= 2; }
    solvedWidth = Math.floor(solvedWidth / 2);
    
    while (solvedHeight <= stageHeight) { solvedHeight *= 2; }
    solvedHeight = Math.floor(solvedHeight / 2);
    
    //trace(solvedWidth + "," + solvedHeight);
    //trace(baseGameWidth + "," + baseGameHeight);
    
    app.scaleX = (solvedWidth / baseGameWidth);
    app.scaleY = (solvedHeight / baseGameHeight);
    
    //trace(scaleX + "," + scaleY);
    
    app.x = (stageWidth - solvedWidth) * 0.5;
    app.y = (stageHeight - solvedHeight) * 0.5;
  }
}