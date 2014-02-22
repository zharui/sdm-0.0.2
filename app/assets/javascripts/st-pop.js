/*!
 * Pop Page Library v2.0
 *
 * Copyright 2013, zhangshaolong
 * QQ: 369669902
 * email: zhangshaolongjj@163.com
 *
 */
;var Pop = (function(doc, win){
	var clientX, clientY, left, top, maxLeft, maxTop, minLeft, minTop, ifm,
		container = null,
		popTitle = null,
		isStrict = doc.compatMode == 'CSS1Compat',
		isIE = win.navigator.userAgent.indexOf('MSIE') >= 0,
		addEvent = function(obj, type, fun){
			if(win.addEventListener){
				obj.addEventListener(type, fun, !1);
			}else if(win.attachEvent){
				obj.attachEvent('on' + type, fun);
			}else{
				obj['on' + type] = fun;
			}
		},
		removeEvent = function(obj, type, fun){
			if(win.removeEventListener){
				obj.removeEventListener(type, fun, !1);
			}else if(win.detachEvent){
				obj.detachEvent('on' + type, fun);
			}else{
				obj['on' + type] = null;
			}
		},
		mdown = function(e){
			var e = e || win.event,
				clientWidth,
				clientHeight;
			clientX = e.clientX;
			clientY = e.clientY;
			minLeft = doc.documentElement.scrollLeft || doc.body.scrollLeft;
			minTop = doc.documentElement.scrollTop || doc.body.scrollTop;
			clientWidth = doc.documentElement.clientWidth || doc.body.clientWidth;
			clientHeight = doc.documentElement.clientHeight || doc.body.clientHeight;
			maxLeft = minLeft + clientWidth - container.offsetWidth;
			maxTop = minTop + clientHeight - container.offsetHeight;
			left = parseInt(container.style.left);
			top = parseInt(container.style.top);
			addEvent(doc, 'mousemove', mmove);
			addEvent(doc, 'mouseup', mup);
			if(popTitle.setCapture){
				popTitle.setCapture();
			}else if(win.captureEvents){
				 win.captureEvents(Event.MOUSEMOVE);
			}
			if(e.preventDefault){
				e.preventDefault();
				e.stopPropagation();
			}
			container.className = container.className.replace(/\bpop\-opacity\b/g, '') + ' pop-opacity ';
		},
		mmove = function(e){
			var e = e || win.event, l, t;
			e.returnValue = !1;
			l = left + (e.clientX - clientX);
			t = top + (e.clientY - clientY);
			if (l < minLeft){
				l = minLeft;
			}else if (l > maxLeft){
				l = maxLeft;
			}
			if (t < minTop){
				t = minTop;
			}else if (t > maxTop){
				t = maxTop;
			}
			setTimeout(function(){
				container.style.left = l + 'px';
				container.style.top = t + 'px';
			}, 0);
		},
		mup = function(){
			if (popTitle.releaseCapture){
				popTitle.releaseCapture();
			}
			if(win.releaseEvents){
				win.releaseEvents(Event.MOUSEMOVE);
			}
			removeEvent(doc, 'mousemove', mmove);
			removeEvent(doc, 'mouseup', mup);
			container.className = container.className.replace(/\s*pop\-opacity\s*/g, ' ');
		},
		show = function(o){
			o.popHolder.style.display = 'block';
			if(o.modal){
				o.mask.style.display = 'block';
			}
		},
		hide = function(o){
			if(o.popHolder){
				o.popHolder.style.display = 'none';
				if(o.modal){
					o.mask.style.display = 'none';
				}
			}
		},
		destroy = function(o){
			if(o.popHolder){
				o.popHolder.parentNode.removeChild(o.popHolder);
				o.popHolder = null;
				if(o.modal){
					o.mask.parentNode.removeChild(o.mask);
					o.mask = null;
				}
			}
		},
		getInfos = function(o, options){
			var bd = doc.body, de = doc.documentElement;
			if(!isStrict){
				o.getWidth = function(){return bd.clientWidth;};
				o.getHeight = function(){return bd.clientHeight;};
				o.getScrollTop = function(){return bd.scrollTop;};
				o.getScrollLeft = function(){return bd.scrollLeft;};
				o.getScrollHeight = function(){return bd.scrollHeight;};
				o.getScrollWidth = function(){return bd.scrollWidth;};
			}else{
				o.getWidth = function(){return de.clientWidth;};
				o.getHeight = function(){return de.clientHeight;};
				o.getScrollTop = function(){return de.scrollTop || bd.scrollTop;};
				o.getScrollLeft = function(){return de.scrollLeft || bd.scrollLeft;};
				o.getScrollHeight = function(){return de.scrollHeight || bd.scrollHeight;};
				o.getScrollWidth = function(){return de.scrollWidth || bd.scrollWidth;};
			}
			for(var p in options){
				o[p] = options[p];
			}
			o.zIndex = options.zIndex || 100;
		},
		init = function(options){
			return new Pop(options);
		};
	var Pop = function(options){
		this.width = 400;
		this.height = 300;
		this.modal = !0;
		this.title = '&nbsp;';
		this.zIndex = 100;
		this.closeMode = 'destroy';//hide or destroy
		this.popHolder = null;
		getInfos(this, options || {});
	};
	Pop.prototype = {
		load : function(url, settings){
			settings = settings || {};
			var width = settings.width || this.width,
				height = settings.height || this.height,
				title = settings.title || this.title,
				zIndex = settings.zIndex || this.zIndex,
				that = this,
				titleTxt,
				closeBtn,
				iframeContainer,
				resetPosition;
			settings.modal && (this.modal = settings.modal);
			settings.closeMode && (this.closeMode = settings.closeMode);
			if(!this.popHolder){
				container = this.popHolder = doc.createElement('div');
				container.className = 'pop-container';
				container.style.zIndex = zIndex;
				popTitle = this.popTitle = doc.createElement('div');
				popTitle.className = 'pop-title';
				titleTxt = this.titleTxt = doc.createElement('span');
				titleTxt.className = 'title-txt';
				titleTxt.innerHTML = title;
				closeBtn = doc.createElement('span');
				closeBtn.className = 'close-btn';
				popTitle.appendChild(titleTxt);
				popTitle.appendChild(closeBtn);
				container.appendChild(popTitle);
				iframeContainer = this.iframeContainer = doc.createElement('div');
				iframeContainer.className = 'iframe-container';
				ifm = this.ifm = doc.createElement('iframe');
				ifm.className = 'pop-iframe';
				ifm.setAttribute('frameborder', 0, 0);
				ifm.setAttribute('border', 0, 0);
				ifm.setAttribute('scrolling', 'no', 0);
				ifm.setAttribute('marginwidth', '0px', 0);
				ifm.setAttribute('marginheight', '0px', 0);
				ifm.setAttribute('allowTransparency', !0, 0);
				ifm.style.zIndex = zIndex;
				iframeContainer.appendChild(ifm);
				container.appendChild(iframeContainer);
				setTimeout(function(){
					doc.body.appendChild(that.popHolder);
				}, 0);
				ifm.onload = function(){
					var w, d, head, body, links, styles,
						i, sheet, rules, j, len, rule, style,
						contentNode, script, src, content, ifmMask;
					if(typeof url !== 'string'){
						if(that.status !== 1 || that.closeMode !== 'hide'){
							that.status = 1;
							w = ifm.contentWindow;
							d = w.document;
							head = d.head || d.getElementsByTagName('head')[0];
							body = d.body;
							links = doc.getElementsByTagName('link');
							styles = doc.getElementsByTagName('style');
							for(i=0;i<links.length;i++){
								head.appendChild(links[i].cloneNode(true));
							}
							var sts = '';
							for(i=0;i<doc.styleSheets.length;i++){
								sheet = doc.styleSheets[i];
								rules = sheet.cssRules || sheet.rules;
								if(rules){
									for(j=0,len=rules.length;j<len;j++){
										rule = rules[j];
										if(rule){
											sts += rule.selectorText + '{' + rule.style.cssText + '} ';
										}
									}
								}
							}
							if(isIE){
								d.createStyleSheet().cssText = sts;
							}else{
								style = d.createElement('style');
								style.innerHTML = sts;
								head.appendChild(style);
							}
							contentNode = (url[0] || url)['cloneNode'](true);
							contentNode.style.display = 'block';
							body.appendChild(contentNode);
							scripts = doc.body.getElementsByTagName('script');
							for(i=0;i<scripts.length;i++){
								script = scripts[i];
								src = script.src;
								if(src){
									script = doc.createElement('script');
									script.src = src;
									body.appendChild(script);
								}else{
									content = script.innerHTML;
									(w.eval || w.execScript)(content);
								}
								body.appendChild(scripts[i].cloneNode(true));
							}
						}
					}
					that.onloaded(that.getPopDoc());
				};
				if(this.modal){
					this.mask = doc.createElement('div');
					this.mask.className = 'pop-mask';
					this.mask.style.zIndex = zIndex - 1;
					if(isIE){
						ifmMask = this.ifmMask = doc.createElement('iframe');
						ifmMask.setAttribute('frameborder', 0, 0);
						ifmMask.setAttribute('border', 0, 0);
						ifmMask.setAttribute('scrolling', 'no', 0);
						ifmMask.setAttribute('marginwidth', '0px', 0);
						ifmMask.setAttribute('marginheight', '0px', 0);
						ifmMask.className = 'pop-ifm-mask';
						this.mask.appendChild(ifmMask);
					}
					doc.body.appendChild(this.mask);
				}
				addEvent(popTitle, 'mousedown', mdown);
				addEvent(doc, 'select', function(){return !1;});
				addEvent(closeBtn, 'click', function(){that.close.call(that);});
			}
			width && (this.width = width);
			height && (this.height = height);
			this.iframeContainer.style.width = this.width + 'px';
			this.popHolder.style.width = this.width + 'px';
			this.iframeContainer.style.height = this.height + 'px';
			this.popHolder.style.height = this.height + 30 + 'px';
			ifm.width = this.width;
			ifm.height = this.height;
			if(typeof url === 'string'){
				if(url.indexOf('?') > -1){
					url += '&poptemp=' + new Date().getTime();
				}else{
					url += '?poptemp=' + new Date().getTime();
				}
				ifm.src = url;
			}
			resetPosition = function(){
				that.popHolder.style.left = that.getScrollLeft() + (that.getWidth() - that.width) / 2 + 'px';
				that.popHolder.style.top = that.getScrollTop() + (that.getHeight() - that.height - 30) / 2 + 'px';
				if(that.modal){
					that.mask.style.width = Math.max(that.getScrollWidth(), that.mask.clientWidth) + 'px';
					that.mask.style.height = Math.max(that.getScrollHeight(), that.mask.clientHeight) + 'px';
				}
			};
			removeEvent(win, 'resize', resetPosition);
			addEvent(win, 'resize', resetPosition);
			resetPosition();
			show(this);
		},
		close : function(){
			eval(this['closeMode'])(this);
			this.onclosed();
		},
		onclosed : function(){
		},
		onloaded : function(doc){
		},
		getPopDoc : function(){
			return this.ifmDoc || (this.ifmDoc = ifm.contentWindow ? ifm.contentWindow.document : ifm.contentDocument ? ifm.contentDocument : ifm.document || ifm.documentElement);
		}
	};
	Pop.init = init;
	return Pop;
})(document, window);
