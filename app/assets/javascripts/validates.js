$(document).ready(function () {
    $('#article_avatar_remote_url').blur(function (e) {
        var patt = /https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,4}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/;
        var url = e.target.value;
         if (url && !patt.test(url)){
            $('[data-disable-with]').prop('disabled', true);
            $(e.target).addClass('error');
            if(!$(e.target).siblings('div.error').length){
                $(e.target).parent().prepend("<div class='error' style='text-align: center;color: red;border: hidden'>Wrong address</div>")
            }
        }
        if((url && patt.test(url)) || !url){
            $('[data-disable-with]').prop('disabled', false);
            $(e.target).removeClass('error');
            $('div.error').detach()
        }
    });
});