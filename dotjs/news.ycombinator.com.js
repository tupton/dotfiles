/* global $:false, _:false */

$('a').each(function() {
    var a = $(this),
        href = a.attr('href');

    if (href && (href.indexOf('ycombinator.com') === -1) &&
            (_.startsWith(href, 'http://') || _.startsWith(href, '//') || _.startsWith(href, 'https://'))) {
        a.attr('target', '_blank');
    }
});
