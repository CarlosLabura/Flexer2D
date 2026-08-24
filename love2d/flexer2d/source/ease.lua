local Ease = {}

local pow, sin, cos, pi, sqrt = math.pow, math.sin, math.cos, math.pi, math.sqrt

Ease.linear = function(t) return t end
Ease.quadIn = function(t) return t*t end
Ease.quadOut = function(t) return -t*(t-2) end
Ease.quadInOut = function(t) return t<0.5 and 2*t*t or -1+(4-2*t)*t end
Ease.cubicIn = function(t) return t*t*t end
Ease.cubicOut = function(t) t=t-1 return t*t*t+1 end
Ease.cubicInOut = function(t) t=t*2 return t<1 and 0.5*t*t*t or 0.5*((t-2)^3+2) end
Ease.quartIn = function(t) return t^4 end
Ease.quartOut = function(t) t=t-1 return 1 - t^4 end
Ease.quartInOut = function(t) t=t*2 return t<1 and 0.5*t^4 or -0.5*((t-2)^4 - 2) end
Ease.quintIn = function(t) return t^5 end
Ease.quintOut = function(t) t=t-1 return t^5+1 end
Ease.quintInOut = function(t) t=t*2 return t<1 and 0.5*t^5 or 0.5*((t-2)^5+2) end
Ease.sineIn = function(t) return -cos(t*pi/2)+1 end
Ease.sineOut = function(t) return sin(t*pi/2) end
Ease.sineInOut = function(t) return -0.5*(cos(pi*t)-1) end
Ease.expoIn = function(t) return t==0 and 0 or 2^(10*(t-1)) end
Ease.expoOut = function(t) return t==1 and 1 or 1-2^(-10*t) end
Ease.expoInOut = function(t) return t==0 and 0 or t==1 and 1 or t<0.5 and 0.5*2^(20*t-10) or 1-0.5*2^(-20*t+10) end
Ease.circIn = function(t) return -(sqrt(1-t*t)-1) end
Ease.circOut = function(t) t=t-1 return sqrt(1-t*t) end
Ease.circInOut = function(t) t=t*2 return t<1 and -0.5*(sqrt(1-t*t)-1) or 0.5*(sqrt(1-(t-2)^2)+1) end
Ease.bounceOut = function(t) return t<1/2.75 and 7.5625*t*t or t<2/2.75 and 7.5625*(t-1.5/2.75)^2+0.75 or t<2.5/2.75 and 7.5625*(t-2.25/2.75)^2+0.9375 or 7.5625*(t-2.625/2.75)^2+0.984375 end
Ease.bounceIn = function(t) return 1-Ease.bounceOut(1-t) end
Ease.bounceInOut = function(t) return t<0.5 and 0.5*Ease.bounceIn(t*2) or 0.5*Ease.bounceOut(t*2-1)+0.5 end
Ease.backIn = function(t) local s=1.70158 return t*t*((s+1)*t-s) end
Ease.backOut = function(t) local s=1.70158 t=t-1 return t*t*((s+1)*t+s)+1 end
Ease.backInOut = function(t) local s=1.70158*1.525 t=t*2 return t<1 and 0.5*t*t*((s+1)*t-s) or 0.5*((t-2)^2*((s+1)*(t-2)+s)+2) end
Ease.elasticIn = function(t) return t==0 and 0 or t==1 and 1 or -2^(10*(t-1))*sin((t-1.075)*2*pi/0.3) end
Ease.elasticOut = function(t) return t==0 and 0 or t==1 and 1 or 2^(-10*t)*sin((t-0.075)*2*pi/0.3)+1 end
Ease.elasticInOut = function(t) return t==0 and 0 or t==1 and 1 or t<0.5 and -0.5*2^(20*t-10)*sin((20*t-11.125)*pi/0.45) or 0.5*2^(-20*t+10)*sin((20*t-11.125)*pi/0.45)+1 end

return Ease