
    $(document).ready(function () {

        $('.container a').before('<div id=\"create_form\"></div>');
        $('#create_form').append($('form')[1]);
        $('#create_form').append('<div class=\"calendar\"></div>');
        $('.calendar').append('<div></div>');
        $('.calendar div').append('<select id =\"month_select\" name=\"month\"></select>');
        $('.calendar div').append(' <select  id=\"year_select\" name=\"year\"></select>');
        $('.calendar').append('<table></table>');
        $('.calendar table').append('<tr></tr>')

        var days_arr = ['Mon','Tue','Wed','Th','Fr','Sat','Sun'];

        for(i=0;i<7;i++){
            $('.calendar table tr').append('<th>'+days_arr[i]+'</th>');
        }

        var years_arr = [
            {val : 2010, text: '2010'},
            {val : 2011, text: '2011'},
            {val : 2012, text: '2012'},
            {val : 2013, text: '2013'},
            {val : 2014, text: '2014'},
            {val : 2015, text: '2015'},
            {val : 2016, text: '2016'},
            {val : 2017, text: '2017'},
            {val : 2018, text: '2018'}
        ];

        var month_arr = [
            {val : 0, text: 'Jenuary'},
            {val : 1, text: 'Fabruary'},
            {val : 2, text: 'March'},
            {val : 3, text: 'April'},
            {val : 4, text: 'May'},
            {val : 5, text: 'June'},
            {val : 6, text: 'July'},
            {val : 7, text: 'August'},
            {val : 8, text: 'September'},
            {val : 9, text: 'October'},
            {val : 10, text: 'November'},
            {val : 11, text: 'December'}
        ];


        $(years_arr).each(function() {
            $('#year_select').append($("<option>").attr('value',this.val).text(this.text));
        });

        $(month_arr).each(function() {
            $('#month_select').append($("<option>").attr('value',this.val).text(this.text));
        });


        /***************************************************************/


        var str;
        var currentdate = new Date();

        for (i = 1; i <= 6; i++) {
            $('.calendar table').append('<tr></tr>');
            for (j = 1; j <= 7; j++) {
                $('.calendar table > tbody > tr:last').append('<td></td>');
            }
        }


        $('#month_select option').each(function () {
            if (this.value == currentdate.getMonth()) {
                this.selected = true;
            }
        });

        $('#year_select option').each(function () {
            if (this.value == currentdate.getFullYear()) {
                this.selected = true;
            }
        });


        setdate(currentdate.getFullYear(), currentdate.getMonth());


        /*****************************************************************************/


        function setdate(year, month) {


            $('.calendar table').find('td').each(function (i, e) {
                e.innerText = '';
            });


            startDay = new Date(year, +(month), 1);
            var wd = startDay.getDay();
            if (wd == 0) {
                wd = 7;
            }

            lastDay = new Date(year, +(month) + 1, 0);


            for (i = 1; i <= lastDay.getDate(); i++) {

                $('.calendar table').find('td')[wd - 1].innerText = i;
                if (+(month) == currentdate.getMonth() && year == currentdate.getFullYear() && $('.calendar table').find('td')[wd - 1].innerText == currentdate.getDate()) {
                    $('.calendar table').find('td')[wd - 1].style.backgroundColor = 'red';
                }
                else
                    $('.calendar table').find('td')[wd - 1].style.backgroundColor = 'white';

                wd++;
            }

            m = month + 1;
            str = '' + year + '-' + m + '-';

        }

        /*****************************************************************************************************/


        $('#year_select').on('change', function (e) {


            setdate(e.target.value, $('#month_select').children(':selected')[0].value);
        });

        $('#month_select').on('change', function (e) {

            setdate($('#year_select').children(':selected')[0].value, e.target.value);
        });


        /*************************************************************************************************/


        $('.calendar table').on('mousedown', 'td', function (e) {
            str2 = str + '' + e.target.innerText;
            $('#create_form form input')[3  ].value = str2;

        });

        $('#create_form form input')[3].style.width = '80px';

        $('.calendar table').on('mouseup', 'td', function (e) {
            $('#create_form form input')[3].innerText = '';

        });


    });
