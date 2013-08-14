/* Found on http://jsfiddle.net/ThiefMaster/LPh33/4/ */
function distributeFields() {
    var fields = $('.status'), container = $('#status-container'),
        width = container.width(), height = container.height(),
        angle = Math.PI+Math.PI/2, step = (2*Math.PI) / fields.length;

    if (container.position() !== undefined) {
        var basex = container.position().left + container.data('offsetx'),
            basey = container.position().top + container.data('offsety'),
            radius = container.data('radius');
    }

    fields.each(function() {
        var x = Math.round(width/2 + radius * Math.cos(angle) - $(this).width()/2 + basex);
        var y = Math.round(height/2 + radius * Math.sin(angle) - $(this).height()/2 + basey);
        if(window.console) {
            console.log($(this).text(), x, y);
        }
        $(this).css({
            left: x + 'px',
            top: y + 'px',
            position: 'absolute'
        });
        angle += step;
    });
}

$(function(){ distributeFields(); });
