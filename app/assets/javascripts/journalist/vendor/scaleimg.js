$(document).ready(function(){function b(){var b=a.width(),c=a.height(),d=$(window).width(),e=$(window).height(),f=d/b,g=e/c,h=g*b,i=f*c;if(i>e){a.css({width:d+"px",height:i+"px"})}else{a.css({width:h+"px",height:e+"px"})}$(".scaleimg").show()}var a=$(".scaleimg");b();$(window).resize(function(){b()})})