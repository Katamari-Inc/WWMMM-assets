/**
 * Created with IntelliJ IDEA.
 * User: Saqoosha
 * Date: 2013/10/27
 * Time: 3:42
 * To change this template use File | Settings | File Templates.
 */
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
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.engine.GraphicElement;

[SWF(width=465, height=465, frameRate=60, backgroundColor=0xffffff)]
public class ObjectCenter extends MovieClip
{

    private var sim:QuickBox2D;
    private var bar:QuickObject;
    private var joint1:QuickObject;
    private var joint2:QuickObject;
    private var _canvas:Shape;
    private var _info:Label;

    public function ObjectCenter()
    {
//        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        sim = new QuickBox2D(this);
//        sim.iterations = 200;
//        sim.grid();
//        sim.createStageWalls();

        var n:int = 0;
        var ceil:QuickObject = sim.addBox({x: 465/30/2, y: 3, width: 465/30, height: .1, density: 0});
        bar = sim.addBox({x: 15, y: 15, width: 10.2, height: 0.1, linearDamping: 0.99});
        joint1 = sim.addJoint({a: ceil.body, b: bar.body, type: 'distance', x1: 2.5, y1: 3, x2: 10, y2: 15, length: 10});
        joint2 = sim.addJoint({a: ceil.body, b: bar.body, type: 'distance', x1: 12.5, y1: 3, x2: 20, y2: 15, length: 5});

        sim.start();
        sim.mouseDrag();

        _canvas = new Shape();
        _canvas.scaleX = _canvas.scaleY = 30;
        addChild(_canvas);

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
        new PushButton(vbox, 0, 0, 'PLOT', _handleClickPlot);
        _info = new Label(vbox);

        y = 30;

        addEventListener(Event.ENTER_FRAME, _handleEnterFrame);
    }


    private function _handleLeftChange(e:Event):void
    {
        b2DistanceJoint(joint1.joint).m_length = HUISlider(e.target).value;
    }


    private function _handleRightChange(e:Event):void
    {
        b2DistanceJoint(joint2.joint).m_length = HUISlider(e.target).value;
    }


    private function _handleClickPlot(e:Event):void
    {
        var p:b2Vec2 = bar.body.GetWorldPoint(new b2Vec2(0, 0));
        var g:Graphics = _canvas.graphics;
        g.beginFill(0xff0000);
        g.drawCircle(p.x, p.y, 3/30);
        g.endFill();
    }


    private function _handleEnterFrame(e:Event):void
    {
        var p:b2Vec2 = bar.body.GetWorldPoint(new b2Vec2(0, 0));
        var a:Number = bar.body.GetAngle();
        _info.text = "X: " + (int(p.x * 1000) / 1000) + ", Y: " + (int(p.y * 1000) / 1000) + ", Angle: " + (int(a * (180 / Math.PI) * 1000) / 1000);
    }
}
}
