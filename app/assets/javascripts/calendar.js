$(document).ready(function () {
    var currentdate = new Date();
    var month = currentdate.getMonth();
    var year = currentdate.getFullYear();
    var month_arr = ['Jenuary','Fabruary','March','April','May','June','July','August','September','October','November','December']
    var days_arr = ['Mon','Tue','Wed','Th','Fr','Sat','Sun'];
    var str;

    $('#create_date input').on('focus',function () {
       $('.calendar').css('display','block');
    });
    $('.main_container').append('<div class="calendar"></div>');
    $('.calendar').append('<div><span class="fa fa-angle-left" id = "year_dec"></span><span class = "fa fa-angle-double-left" id = "month_dec"></span><span id = "date"></span><span <i class = "fa fa-angle-double-right" id = "month_inc"></span><span class="fa fa-angle-right" id = "year_inc"></span></div>');
    $('.calendar').append('<table><tr></tr></table>');
    $('.calendar').append('<div class="close"  id="close_calendar">x</div>');
    $('#close_calendar').click(function (e) {
        $(e.target).parent().css('display','none');
    });

    for(i=0;i<7;i++){
        $('.calendar table tr').append('<th>'+days_arr[i]+'</th>');
    }

    for (i = 1; i <= 6; i++) {
        $('.calendar table').append('<tr></tr>');
        for (j = 1; j <= 7; j++) {
            $('.calendar table > tbody > tr:last').append('<td></td>');
        }
    }

    insert_dates_in_table(year, month);

    $('.calendar div').click(function (e) {
        if($(e.target).attr('id')=='year_inc'){
            year++;
        }
        if($(e.target).attr('id')=='year_dec'){
            year--;
        }
        if($(e.target).attr('id')=='month_inc'){
           ++month;
        }
        if($(e.target).attr('id')=='month_dec'){
           --month;
        }
        if(month<0){
            month=11;
            year--;
        }
        if(month>11){
            month=0;
            year++;
        }

        insert_dates_in_table(year, month);
    });

    $('.calendar table td').on('click', function (e) {
        if(e.target.innerText != '-') {
            $('.calendar table td').attr('style', '');
            e.target.style.backgroundColor = 'red';
            var mmm = month + 1;
            var yyy = year;
            var ddd = e.target.innerText;
            if (mmm < 10)
                mmm = '0' + mmm;
            if (ddd < 10)
                ddd = '0' + ddd;
            $('#create_date input')[0].value = yyy+'-'+mmm+'-'+ddd;
        }
    });
    function insert_dates_in_table(year, month) {
        $('#date').html('');
        $('#date').append(month_arr[month]+' '+year);


        $('.calendar table').find('td').each(function (i, e) {
            e.innerText = '';
        });

        startDay = new Date(year, +(month), 1);
        var wd = startDay.getDay();
        if (wd == 0) {
            wd = 7;
        }
        lastDay = new Date(year,month + 1, 0);
        for (i = 1; i <= lastDay.getDate(); i++) {
            $('.calendar table').find('td')[wd - 1].innerText = i;
            wd++;
        }
        for(i=0;i< $('.calendar table').find('td').length;i++){
            if ($('.calendar table').find('td')[i].innerText==''){
                $('.calendar table').find('td')[i].innerText = '-';
            }
        }

           if ( year == currentdate.getFullYear() && month == currentdate.getMonth()) {
                $('.calendar table').find('td')[currentdate.getDate()+startDay.getDay()-2].style.backgroundColor = 'red';
            }
            else
               $('.calendar table').find('td').attr('style', '');
    }

});
