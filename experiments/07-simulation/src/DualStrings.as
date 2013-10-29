package
{
import Box2D.Common.Math.b2Vec2;
import Box2D.Dynamics.Joints.b2DistanceJoint;

import com.actionsnippet.qbox.QuickBox2D;
import com.actionsnippet.qbox.QuickObject;
import com.bit101.components.HUISlider;
import com.bit101.components.Label;
import com.bit101.components.PushButton;
import com.bit101.components.VBox;

import flash.display.Graphics;
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.StageAlign;
import flash.events.Event;

[SWF(width=465, height=465, frameRate=60, backgroundColor=0xffffff)]
public class DualStrings extends MovieClip
{

    private var sim:QuickBox2D;
    private var _bar:QuickObject;
    private var _leftJoint1:QuickObject;
    private var _leftJoint2:QuickObject;
    private var _rightJoint1:QuickObject;
    private var _rightJoint2:QuickObject;

    public function DualStrings()
    {
        stage.align = StageAlign.TOP_LEFT;

        sim = new QuickBox2D(this);

        var n:int = 0;
        var ceil:QuickObject = sim.addBox({x: 465 / 30 / 2, y: 3, width: 1000 / 30, height: .1, density: 0});
        _bar = sim.addBox({x: 15, y: 15, width: 10.2, height: 0.1, linearDamping: 0.5});
        var d:Number = 2;
        _leftJoint1 = sim.addJoint({a: ceil.body, b: _bar.body, type: 'distance', x1: 2.5 - d, y1: 3, x2: 10, y2: 15, length: 10});
        _leftJoint2 = sim.addJoint({a: ceil.body, b: _bar.body, type: 'distance', x1: 2.5 + d, y1: 3, x2: 10, y2: 15, length: 10});
        _rightJoint1 = sim.addJoint({a: ceil.body, b: _bar.body, type: 'distance', x1: 12.5 - d, y1: 3, x2: 20, y2: 15, length: 5});
        _rightJoint2 = sim.addJoint({a: ceil.body, b: _bar.body, type: 'distance', x1: 12.5 + d, y1: 3, x2: 20, y2: 15, length: 5});

        sim.start();
        sim.mouseDrag();

        var vbox:VBox = new VBox(stage, 10, 10);
        var s:HUISlider = new HUISlider(vbox, 0, 0, 'LEFT JOINT', _handleLeftChange);
        s.width = 300;
        s.minimum = 1;
        s.maximum = 15;
        s.value = 10;
        s.tick = 0.5;
        s.labelPrecision = 1;
        s = new HUISlider(vbox, 0, 0, 'RIGHT JOINT', _handleRightChange);
        s.width = 300;
        s.minimum = 1;
        s.maximum = 15;
        s.value = 5;
        s.tick = 0.5;
        s.labelPrecision = 1;

        y = 30;
    }


    private function _handleLeftChange(e:Event):void
    {
        b2DistanceJoint(_leftJoint1.joint).m_length = HUISlider(e.target).value;
    }


    private function _handleRightChange(e:Event):void
    {
        b2DistanceJoint(_rightJoint1.joint).m_length = HUISlider(e.target).value;
    }
}
}
