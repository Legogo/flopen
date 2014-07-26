package com.aberlemont;
import openfl.geom.Point;
import openfl.text.TextField;

/**
 * ...
 * @author A.Berlemont
 */
class Tools
{
	
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
	
	static public function moveToward(current:Point, target:Point, step:Float):Point {
		var diff:Point = new Point(target.x - current.x, target.y - current.y);
		
		if (diff.length < step) {
			current.x = target.x;
			current.y = target.y;
		}else {
			diff = Tools.normalize(diff);
			current.x += diff.x * step;
			current.y += diff.y * step;
		}
		
		return current;
	}
	
	// VECTOR
	
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

	static public function destinationPoint(origin:Point, dir:Point, lenght:Float):Point {
		return new Point((origin.x + dir.x * lenght), (origin.y + dir.y * lenght));
	}
	
	// TEXT
	
  static public function getStandardTextfield():TextField {
    var tf:TextField = new TextField();
    tf.selectable = false;
    tf.mouseEnabled = false;
    return tf;
  }
}