package com.aberlemont.system;
import com.aberlemont.system.AppTools;
import flash.display.Sprite;
import openfl.Lib;
import openfl.system.Capabilities;
/**
 * ...
 * @author A.Berlemont
 */
class AppTools
{
  
  static public function getStageWidth():Int {
    return Lib.current.stage.stageWidth;
  }
  static public function getStageHeight():Int { 
    return Lib.current.stage.stageHeight;
  }
  
  static public function bottom(app:Sprite):Void {
    var w:Int = Math.floor(app.width);
    var h:Int = Math.floor(app.height);
    var fw:Int = AppTools.getStageWidth();
    var fh:Int = AppTools.getStageHeight();
    app.x = (fw - w) * 0.5;
    app.y = fh - h;
    //trace(w, h, fw, fh, app.x, app.y);
  }
  
  static public function center(app:Sprite):Void {
    var w:Int = Math.floor(app.width);
    var h:Int = Math.floor(app.height);
    var fw:Int = AppTools.getStageWidth();
    var fh:Int = AppTools.getStageHeight();
    app.x = (fw - w) * 0.5;
    app.y = (fh - h) * 0.5;
  }
  
  static public function scale(app:Sprite):Void {
    var stageWidth:Int = AppTools.getStageWidth();
    var stageHeight:Int = AppTools.getStageHeight();
    
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
  
  static public function getSystemInfo():String {
    var c:String = "";
    c += "\nresolution" + getStageWidth() + " x " + getStageHeight();
    c += "\nscreenDPI = " + Capabilities.screenDPI;
    c += "\nscreenXY = " + Capabilities.screenResolutionX + " x " + Capabilities.screenResolutionY;
    return c;
  }
}