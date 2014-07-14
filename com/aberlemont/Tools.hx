package com.aberlemont;

/**
 * ...
 * @author A.Berlemont
 */
class Tools
{
  static public function range(x:Float, y:Float):Float {
    return x + ((y - x) * Math.random());
  }
  
  static public function rangeInt(x:Int, y:Int):Int {
    return Math.floor(range(cast(x, Int), cast(y, Int)));
  }
}