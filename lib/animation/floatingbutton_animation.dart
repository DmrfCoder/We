import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/callback/floatingbutton_iconclickcallback_callback.dart';

class AnimatedFab extends StatefulWidget {
  final FloatButtonIconClickCallBack floatButtonIconClickCallBack;

  const AnimatedFab({Key key, this.floatButtonIconClickCallBack})
      : super(key: key);

  @override
  _AnimatedFabState createState() => new _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorAnimation;

  final double expandedSize = 180.0;
  final double hiddenSize = 20.0;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    _colorAnimation = new ColorTween(begin: Colors.pink, end: Colors.pink[800])
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> child = [];

    return new SizedBox(
      width: expandedSize,
      height: expandedSize,
      child: new AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          if (_animationController.value > 0.5) {
            return new Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _buildExpandedBackground(),
                _buildOption(
                    new Container(
                      width: 40.0,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new ExactAssetImage(
                              'images/black_heart_alone.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    -math.pi / 5,
                    MessageType.bad),
                _buildOption(
                    new Container(
                      width: 40.0,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new ExactAssetImage('images/heart_alone.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    math.pi / 5,
                    MessageType.nice),
                _buildFabCore(),
              ],
            );
          } else {
            return new Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _buildExpandedBackground(),
                _buildFabCore(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildOption(Widget icon, double angle, MessageType messageType) {
    double iconSize = 0.0;
    if (_animationController.value > 0.8) {
      iconSize = 26.0 * (_animationController.value - 0.8) * 5;
    }
    iconSize = iconSize * 2.3;
    return new Transform.rotate(
      angle: angle,
      child: new Align(
        alignment: Alignment.topCenter,
        child: new Padding(
          padding: new EdgeInsets.only(top: 8.0),
          child: new IconButton(
            onPressed: () => _onIconClick(messageType),
            icon: new Transform.rotate(angle: -angle, child: icon),
            iconSize: iconSize,
            alignment: Alignment.center,
            padding: new EdgeInsets.all(0.0),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedBackground() {
    double size =
        hiddenSize + (expandedSize - hiddenSize) * _animationController.value;
    return new Container(
      height: size,
      width: size,
      decoration: new BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
    );
  }

  Widget _buildFabCore() {
    double scaleFactor = 2 * (_animationController.value - 0.5).abs();
    return new FloatingActionButton(
      onPressed: _onFabTap,
      child: new Transform(
        alignment: Alignment.center,
        transform: new Matrix4.identity()..scale(1.0, scaleFactor),
        child: new Icon(
          _animationController.value > 0.5 ? Icons.close : Icons.add,
          color: Colors.white,
          size: 26.0,
        ),
      ),
      backgroundColor: _colorAnimation.value,
    );
  }

  open() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    }
  }

  close() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    }
  }

  _onFabTap() {
    if (_animationController.isDismissed) {
      open();
    } else {
      close();
    }
  }

  _onIconClick(MessageType messageType) {
    widget.floatButtonIconClickCallBack.floatIconOnClick(messageType);
    close();
  }
}
