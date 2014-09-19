package com.aberlemont;
import flash.geom.Matrix3D;
import flash.utils.CompressionAlgorithm;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;

/**
 * ...
 * @author A.Berlemont
 */
class Tools
{
	static public var pt:Point = new Point();
	
	//NUMBERS
	public static function threshold(min:Float, max:Float, val:Float):Float {
		if (val < min)	val = min;
		else if (val > max)	val = max;
		return val;
	}

	public static function thresholdInt(min:Int, max:Int, val:Int):Int {
		if (val < min)	val = min;
		else if (val > max)	val = max;
		return val;
	}

	public static function sign(val:Float):Float {
		if (val > 0)	return 1;
		else if (val < 0)	return -1;

		return 0;
	}

	static public function isBetween(x:Float, min:Float, max:Float):Bool {
		if (x < min || x > max)	return false;
		return true;
	}

  static public function range(x:Float, y:Float):Float {
    return x + ((y - x) * Math.random());
  }
  
  static public function rangeInt(x:Int, y:Int):Int {
    return Math.floor(range(cast(x, Int), cast(y, Int)));
  }
  
  static public function roundTo(val:Float, dec:Int):Float {
    var temp:Float = Math.ffloor(val * dec);
    return temp / dec;
  }
  
  static public function moveTowardFloat(current:Float, target:Float, step:Float):Float {
    var dir:Float = sign(target - current);
    if (dir == 0)  return target;
    if (dir > 0) {
      current += step;
      if (current < target)  return current;
    }else if (dir < 0) {
      current -= step;
      if (current > target)  return current;
    }
    return target;
  }
	
	static public function moveTowardPoint(current:Point, target:Point, step:Float):Point {
		//var diff:Point = new Point(target.x - current.x, target.y - current.y);
		pt.x = target.x - current.x;
		pt.y = target.y - current.y;
		
		if (pt.length < step) {
			current.x = target.x;
			current.y = target.y;
		}else{
			pt = Tools.normalize(pt);
			current.x += pt.x * step;
			current.y += pt.y * step;
		}
		
		return current;
	}
	
	// VECTOR
	
	static public function comparePoint(pta:Point, ptb:Point):Bool {
		if (pta.x == ptb.x) {
			if (pta.y == ptb.y)	return true;
		}
		return false;
	}
	static public function compareRect(ra:Rectangle, rb:Rectangle):Bool {
		return (ra.x == rb.x && ra.y == rb.y && ra.width == rb.width && rb.height == ra.height);
	}
	
	static public function distance(xa:Float, ya:Float, xb:Float, yb:Float):Float {
		return Math.sqrt(Math.pow((xb - xa), 2) + Math.pow((yb - ya), 2));
	}
	static public function distancePoint(pta:Point, ptb:Point):Float {
		return Math.sqrt(Math.pow((ptb.x - pta.x), 2) + Math.pow((ptb.y - pta.y), 2));
	}

	static public function normalize(pt:Point):Point {
		var length:Float = Math.sqrt((pt.x * pt.x) + (pt.y * pt.y));
		if (length != 0)	return new Point(pt.x / length, pt.y / length);
		else return new Point();
	}
	
	/* be careful, pta is overrided ! */
	static public function substractPoint(pta:Point, ptb:Point):Point {
		pta.x -= ptb.x;
		pta.y -= ptb.y;
		return pta;
	}
  
  static public function clamp01(val:Float):Float { if (val < 0)  return 0; if(val > 1) return 1; return val; }
  static public function lerp(a:Float,b:Float,amount:Float):Float { return a + amount * (b-a); }
	static public function inverselerp(a:Float, b:Float, amount:Float):Float { return (amount - a) / (b - a); }
  
	static public function destinationPoint(origin:Point, dir:Point, lenght:Float):Point {
		return new Point((origin.x + dir.x * lenght), (origin.y + dir.y * lenght));
	}
	
	// TEXT
	
  static public function getStandardTextfield():TextField {
    var tf:TextField = new TextField();
    tf.selectable = false;
    tf.mouseEnabled = false;
		tf.width = 200;
		tf.height = 100;
    return tf;
  }
}