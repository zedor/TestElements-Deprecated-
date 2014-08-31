package  {
	
	import flash.display.MovieClip;
	
	//valve imports
	import ValveLib.Globals;
	import ValveLib.ResizeManager;
	
	//import for replaceelement
	import flash.utils.getDefinitionByName;
	
	public class testSWF extends MovieClip {
		
		//valve elements
		public var gameAPI:Object;
		public var globals:Object;
		public var elementName:String;
		
		public var holder:MovieClip = new MovieClip;
		
		public function testSWF() {
		}
		
		public function onLoaded() : void {			
			//make this UI visible
			visible = true;
			
			//let the client rescale the UI
			Globals.instance.resizeManager.AddListener(this);
			this.gameAPI.SubscribeToGameEvent("testswf_test_element", this.testElement);
			
			this.addChild(holder);
		}
		
		public function testElement(args:Object) {
			/*
			args._element = element name
			args._bool = reposition / scale if true
			args._x = desired x
			args._y = desired y
			args._width = desired width
			args._height = desired height
			*/
			
			holder = replaceWithValveComponent(holder, args._element);
			if( args._bool == "true" ) {
				holder.x = args._x;
				holder.y = args._y;
				holder.width = args._width;
				holder.height = args._height;
			}
			
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
