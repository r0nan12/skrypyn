// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree



$(document).on("ready", function () {


    $('body').click(function () {
        $('.search_result').css('display', 'none');
    });

    $('.search_form').on('keyup', function (e) {

        $('.search_result').css('display', 'block');

        $('.search_result').html('');
        var val = this.elements.q.value;

        $.ajax({
            type: "GET",
            url: "/search/index",
            data: {q: val},
            dataType: "json",
            success: function (articles) {

                for (var i in articles) {
                    $('.search_result').append("<div><a href=\" /articles/"+articles[i].id+"\">"+ articles[i].title +"</a></div>");
                }
            }
        });
    });


});










