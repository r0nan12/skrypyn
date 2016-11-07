
$(document).ready(function() {
    var  str;
    var currentdate = new Date();

    for(i=1;i<=6;i++) {
        $('.calendar table').append('<tr></tr>');
        for(j=1;j<=7;j++) {
            $('.calendar table > tbody > tr:last').append('<td></td>');
        }
    }



    $('#month_select option').each(function(){
       if(this.value==currentdate.getMonth()){
           this.selected=true;
       }

    });

    $('#year_select option').each(function () {
        if(this.value==currentdate.getFullYear()){
            this.selected=true;
        }
    });
    setdate(currentdate.getFullYear(),currentdate.getMonth());

/*****************************************************************************/


    function setdate(year,month) {



        $('.calendar table').find('td').each(function (i,e) {
            e.innerText='';
        });



        startDay = new Date(year,+(month), 1);
        var wd = startDay.getDay();
        if (wd==0){
            wd=7;
        }

               lastDay = new Date(year,+(month) + 1, 0);


        for(i=1;i<=lastDay.getDate();i++){

            $('.calendar table').find('td')[wd-1].innerText = i;
            if(+(month)==currentdate.getMonth() && year == currentdate.getFullYear() && $('.calendar table').find('td')[wd-1].innerText == currentdate.getDate()){
                $('.calendar table').find('td')[wd-1].style.backgroundColor='red';
            }
            else
                $('.calendar table').find('td')[wd-1].style.backgroundColor='white';

            wd++;
        }

       m=month+1;
      str = ''+year+':'+m+':';

    }

/*****************************************************************************************************/




    $('#year_select').on('change',function (e) {


        setdate(e.target.value,    $('#month_select').children(':selected')[0].value);
    });

    $('#month_select').on('change',function (e) {

        setdate($('#year_select').children(':selected')[0].value,   e.target.value);
    });


/*************************************************************************************************/


$('.calendar table').on('mousedown','td',function (e) {
   str2 = str+''+e.target.innerText;
    $('#create_form form textarea')[1].value = str2;

});

    $('#create_form form textarea')[1].style.width='80px';

    $('.calendar table').on('mouseup','td',function (e) {
        $('#create_form form textarea')[1].innerText = '';

    });








});

