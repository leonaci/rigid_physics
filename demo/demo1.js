var gl;
var width = 800, height = 800;
var FPS = 60;
var params = {
	backgroundColor : 0xFFFFFF
};
var trace = console.log;
(function() {
	var ctx = PIXI.autoDetectRenderer(width, height, params);
	document.body.appendChild(ctx.view);

	function resize() {
		var aspectWidth = window.innerWidth / width;
		var aspectHeight = window.innerHeight / height;
		var aspect = (aspectWidth > aspectHeight)? aspectHeight : aspectWidth;
		var style = ctx.view.style;
		style.position = 'absolute';
		style.margin = 'auto';
		style.width  = `${width * aspect}px`;
		style.height = `${height * aspect}px`;
		style.top = '0px';
		style.left = '0px';
		style.bottom = '0px';
		style.right = '0px';
	}

	resize();
	window.onresize =  resize;

	var stage = new PIXI.Container();

	var g = new PIXI.Graphics();
	g.x = width / 2;
	g.y = height / 2;
	stage.addChild(g);
	
	var text = new PIXI.Text('', {
		font: '2px Arial',
		fill: 'black',
	});
	text.position.x = 0;
	text.position.y = 0;
	stage.addChild(text);

	var world = new RHEI.World();
	world.underGravity = false;
	for(let i = 0; i<1000; i++) {
		var r = (RHEI.MathUtil.rnd() + RHEI.MathUtil.rnd() + RHEI.MathUtil.rnd()) + 1;
		var b = new RHEI.Body(new RHEI.SphereShape(r));
		const mass = 1e-05 * r * r * RHEI.MathUtil.PI;
		b.setMass(mass);
		b.setPosition({x:(RHEI.MathUtil.rnd() - 0.5) * ctx.width, y:(RHEI.MathUtil.rnd() - 0.5) * ctx.height});
		b.setVelocity({x:(RHEI.MathUtil.rnd() - 0.5) * 2e2, y:(RHEI.MathUtil.rnd() - 0.5) * 2e2});
		world.addBody(b);
	}

	function update() {
		var body = world.bodies;
		while(body != null) {
			var x = body.getPosition().x, y = body.getPosition().y;

			x = (x>ctx.width/1.2)? -ctx.width/1.2 : (x<-ctx.width/1.2)? ctx.width/1.2 : x;
			y = (y>ctx.height/1.2)? -ctx.height/1.2 : (y<-ctx.height/1.2)? ctx.height/1.2 : y;
			
			body.setPosition({x:x, y:y});

			body = body.next;
		}
	}

	function draw() {
		g.clear();

		var body = world.bodies;
		while(body != null) {
			drawBody(body);
			body = body.next;
		}

		var body = world.bodies;
		while(body != null) {
			drawAABB(body);
			body = body.next;
		}

		for(let i=0; i<world.constraints.length; i++) {
			var c = world.constraints[i];
			if(c instanceof RHEI.ContactConstraint) {
				drawContact(c);
			}
			else {
				drawConstraint(c);
			}
		}
		
		drawDebugTrace();
	}

	function drawBody(b) {
		switch(b.getKind()) {
			case 'Sphere':
				var q = b.getPosition();
				var r = b.getShape().radius;
				g.beginFill(0xFFAAAA);
				g.lineStyle(0, 0x000000);
				g.drawCircle(q.x, -q.y, r);
		}
	}

	function drawAABB(b) {
		var aabb = b.getAABB();
		var maxX = aabb.getMaxX(),
			minX = aabb.getMinX(),
			maxY = aabb.getMaxY(),
			minY = aabb.getMinY();

		g.beginFill(0x000000, 0.0);
		g.lineStyle(1.0, 0x888888);
		g.drawRect(minX, -maxY, maxX - minX, maxY - minY);
		g.endFill();
	}

	function drawContact(c) {
		const c1x = c.rq1.x + c.p1.q.x,
		      c1y = c.rq1.y + c.p1.q.y,
		      c2x = c.rq2.x + c.p2.q.x,
		      c2y = c.rq2.y + c.p2.q.y;
		
		g.beginFill(0x0000FF);
		g.drawCircle(c1x, -c1y, 2);
		g.drawCircle(c2x, -c2y, 2);
		g.endFill();
	}

	function drawConstraint(c) {
		const c1x = c.p1.q.x,
		      c1y = c.p1.q.y,
		      c2x = c.p2.q.x,
		      c2y = c.p2.q.y;
		
		g.lineStyle(2.5, 0xFF0000);
		g.moveTo(c1x, -c1y);
		g.lineTo(c2x, -c2y);
	}
	
	function drawDebugTrace() {
		var str =
			  `************************************\n`
			+ `Broadphase : ${Math.round(RHEI.Statistics.broadphaseProcessElapsedTime)}ms\n`
			+ `Narrowphase : ${Math.round(RHEI.Statistics.narrowphaseProcessElapsedTime)}ms\n`
			+ `Resolution : ${Math.round(RHEI.Statistics.resolutionProcessElapsedTime)}ms\n`
			+ `Integration : ${Math.round(RHEI.Statistics.integrationProcessElapsedTime)}ms\n`
			+ `LogicTotal : ${Math.round(RHEI.Statistics.totalElapsedTime)}ms\n`
			+ `Rendering : ${Math.round(RHEI.Statistics.renderingElapsedTime)}ms\n`
			+ `************************************`;
		text.setText(str);
		console.log(str);
	}

	function frameHandler() {
		requestAnimationFrame(frameHandler);

		world.step(1 / FPS);
		update();
		
		const a = window.performance.now() / 1000;
		draw();
		const b = window.performance.now() / 1000;
		RHEI.Statistics.renderingElapsedTime = (b - a) * 1000;

		ctx.render(stage);
	}

	requestAnimationFrame(frameHandler);

})();