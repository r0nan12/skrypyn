$(document).ready(function () {
    $('#new_order select').change(function () {
        this.form.submit();
    });
});
