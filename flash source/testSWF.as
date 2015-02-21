package  {
	
	import flash.display.MovieClip;
	
	//valve imports
	import ValveLib.Globals;
	import ValveLib.ResizeManager;
	
	//import for replaceelement
	import flash.utils.getDefinitionByName;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class testSWF extends MovieClip {
		
		//valve elements
		public var gameAPI:Object;
		public var globals:Object;
		public var elementName:String;
		
		public var holder:MovieClip = new MovieClip;
		
		public function testSWF() {
		}
		
		public function movef(e:MouseEvent) {
			trace('[mouseOver] t: ' + e.target + '; n: ' + e.target.name + '; p: ' + e.target.parent + '; p_n: ' + e.target.parent.name );
		}
		
		public function onLoaded() : void {			
			//make this UI visible
			visible = true;
			
			//let the client rescale the UI
			Globals.instance.resizeManager.AddListener(this);
			
			//events
			stage.addEventListener(MouseEvent.MOUSE_MOVE, movef, false, 0, true);
			this.gameAPI.SubscribeToGameEvent("testswf_test_element", this.testElement);
			this.gameAPI.SubscribeToGameEvent("testswf_test_cmd", this.testCommand);
			
			this.addChild(holder);
		}
		
		public function testCommand(args:Object) {
			var buffArr:Array = splitStr(args._cmd);
			var buffObj = globals[buffArr[0]];
			buffArr.shift();
			
			while( buffArr.length > 1 ) {
				buffObj = buffObj[buffArr[0]];
				buffArr.shift();
			}
						
			if( args._splice == "true" ) {
				var buffArr2:Array = splitStr(args._value);
				var buffObj2 = globals[buffArr2[0]];
				buffArr2.shift();
				
				while( buffArr2.length > 1 ) {
					buffObj2 = buffObj2[buffArr2[0]];
					buffArr2.shift();
				}
				
				if( args._type == "brackets" ) buffObj[buffArr[0]](buffObj2[buffArr2[0]]);
			} else {
				if( args._type == "bool" ) buffObj[buffArr[0]] = Boolean(args._value);
				if( args._type == "float" ) buffObj[buffArr[0]] = Number(args._value);
				if( args._type == "string" ) buffObj[buffArr[0]] = args._value.toString();
				if( args._type == "int" ) buffObj[buffArr[0]] = int(args._value);
			}
		}
		
		public function splitStr(s:String):Array {
			var buff = s.split('.');
			return buff;
		}
		
		public function testElement(args:Object) {
			/*
			args._element = element name
			args._x = desired x
			args._y = desired y
			args._width = desired width
			args._height = desired height
			*/
			
			holder = replaceWithValveComponent(holder, args._element);
			if( args._x!="null" ) holder.x = args._x;
			if( args._y!="null" )  holder.y = args._y;
			if( args._width!="null" ) holder.width = args._width;
			if( args._height!="null" ) holder.height = args._height;
			
		}
		
		public function replaceWithValveComponent(mc:MovieClip, type:String, keepDimensions:Boolean = false) : MovieClip {
    		var parent = mc.parent;
    		var oldx = mc.x;
    		var oldy = mc.y;
    		var oldwidth = mc.width;
    		var oldheight = mc.height;
    		
    		var newObjectClass = getDefinitionByName(type);
    		var newObject = new newObjectClass();
    		newObject.x = oldx;
    		newObject.y = oldy;
    		if (keepDimensions) {
        		newObject.width = oldwidth;
        		newObject.height = oldheight;
    		}
		    
    		parent.removeChild(mc);
    		parent.addChild(newObject);
    
    		return newObject;
		}
		
		public function onResize(re:ResizeManager) : * {
			//scaling goes here
		}
	}
	
}
