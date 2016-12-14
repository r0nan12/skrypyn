$(document).on('turbolinks:load', function () {
    $('body').click(function () {
        $('.search_result').css('display', 'none');
    });
    $('.search_form').on('keyup', function (e) {
        $('.search_result').css('display', 'block');
        $('.search_result').html('');
        var val = this.elements.q.value;
        $.ajax({
            type: "GET",
            url: '/articles/search',
            data: {q: val},
            dataType: 'json',
            success: function (articles) {
                for (var i in articles) {
                    $('.search_result').append("<div><a href=\" /articles/" + articles[i].id + "\">" + articles[i].title + "</a></div>");
                }
            }
        });
    });
});