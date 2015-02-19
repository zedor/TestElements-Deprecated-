# TestElements

###### Description

A simple .swf that allows you to check valve UI elements when ingame from the console.
yrrep.me/dota/flash-components.php

###### Usage

* Put the files in their correct folders

* Mouse over stuff to get info in the console (`-scaleform_spew 1`)
  * `[mouseOver] t: target; n: target.name; p: target.parent; p_n: target.parent.name;

* Use console command `testElement <element_name> <x> <y> <width> <height>`
  * `testElement DB4_floading_panel`
* If you want to position/scale the element when testing, input the desired values (or null to keep the values)
  * `testElement DB4_floading_panel true 50 50 250 350`
  * `testElement DB4_floading_panel true null null 250 350`

* Use console command `testCmd <object> <type> <value/object> <splice>`
  * `<object>` - the object you're testing
  * `<type>` - the type of the value, options are: `bool, float, int, string, brackets`
    * `brackets` - the command will be put in brackets, for example: `Object.removeChild(<value/object>)`. Otherwise it's assigned: `Object.stuff = <value/object>`
  * `<value/object>` - the value or the object you're using. If it's an object, `<splice>` needs to be `true`.
  * testCmd assumes that you're running `globals.<something>`

###### Value Example
* Go to the hero loadout (pick screen) and hover over the lock-in button: http://i.imgur.com/bycyBSN.jpg
* Console will read: `SF: [mouseOver] t: [CLIK Button selectButton]; n: selectButton; p: [object s_Shared_HeroSelectorAndLoadout_1]; p_n: heroDock`
* Go to http://yrrep.me/dota/ValveUIDocs/
  * Filter `selectButton`
  * Find the one with `heroDock` parent
  * Copy the inheritance **without the globals part**: `Loader_shared_heroselectorandloadout.movieClip.heroDock.selectButton`
* Type into console: `testCmd Loader_shared_heroselectorandloadout.movieClip.heroDock.selectButton.enabled bool false`
* Result: http://i.imgur.com/neyxMlE.jpg

###### Object (brackets) Example
* Go to the hero loadout (pick screen) and hover over the lock-in button: http://i.imgur.com/bycyBSN.jpg
* Console will read: `SF: [mouseOver] t: [CLIK Button selectButton]; n: selectButton; p: [object s_Shared_HeroSelectorAndLoadout_1]; p_n: heroDock`
* Go to http://yrrep.me/dota/ValveUIDocs/
  * Filter `selectButton`
  * Find the one with `heroDock` parent
  * Copy the inheritance **without the globals part**: `Loader_shared_heroselectorandloadout.movieClip.heroDock.selectButton`
* Type into console: `testCmd Loader_shared_heroselectorandloadout.movieClip.heroDock.selectButton.enabled bool false`
* Result: http://i.imgur.com/KFpv4v4.jpg
