/* global $:false, _:false */

$(function() {
    setInterval(function() {
        $('#ghx-detail-view a').each(function() {
            var a = $(this),
                href = a.attr('href');

            if (href && ((href.indexOf('jira.com') === -1) &&
                            (_.startsWith(href, 'http://') || _.startsWith(href, '//') || _.startsWith(href, 'https://')) ||
                        (href.indexOf('/browse/OPSC-') !== -1))) {
                a.attr('target', '_blank');
            }
        });
    }, 1000);

    $('#issue-content a').each(function() {
        var a = $(this),
            href = a.attr('href');

        if (href && (href.indexOf('jira.com') === -1) &&
                (_.startsWith(href, 'http://') || _.startsWith(href, '//') || _.startsWith(href, 'https://'))) {
            a.attr('target', '_blank');
        }
    });

    var story_points_header = $('.navigator-content [data-id=customfield_10013]');
    if (story_points_header) {
        var story_points_header_text = story_points_header.text(),
            total_story_points = $.makeArray($('.customfield_10013'))
                .reduce(function(result, elem) {
                    return result + parseFloat(elem.innerText || 0);
                }, 0);
        story_points_header.text(story_points_header_text + ' (' + total_story_points + ')');
    }
});
