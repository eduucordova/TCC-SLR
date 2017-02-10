// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-slider

$(document).ready(function () {
    $("a.link_to_add_fields").on("click", function (e) {
        e.preventDefault();
        $("a.link_to_remove_fields").prev("input[type=hidden]").val(false);
        var link = $(this);
        var association = $(this).data("association");
        var content = $(this).data("content");
        add_fields(link, association, content);
    });

    $("a.link_to_remove_fields").on("click", function (e) {
        e.preventDefault();
        var link = $(this);
        remove_fields(link);
    });

    $("#distribute_studies").on('show.bs.modal', function (e) {
        var sliders = $("#modal_table").find('input');

        sliders.slider();
        $.each($(".range-content"), function (key, value) {
            var input = value.children[1];
            $(input).on('slide', function (slideEvt) {
                $(value.children[2]).text(slideEvt.value);
            });
        });
    });

    $('#btnDistribute').bind('click', function(e) {
        var obj = [];
        var distributes = [];

        $.each($("#modal_table tr"), function (key, value) {
            if(key > 0) {
                obj.push({
                    user_id: value.children[0].innerText,
                    range: 100
                });
            }
        });

        $.each($(".range-content"), function (key, value) {
            obj[key]["range"] = value.children[1].value;
        });

        distributes.push({
            users: obj
        });

        $.ajax({
            url: 'distribute',
            data: JSON.stringify(distributes),
            type: "POST",
            dataType: "JSON",
            success: function(response) {
                console.log(response);
                $('#distribute_studies').modal('hide');
                alert(response);
            },
            error: function(xhr, textStatus, errorThrown) {}
        });
    });
});

function remove_fields (link) {
    $(link).prev("input[type=hidden]").val(true);
    $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).parent().before(content.replace(regexp, new_id));

    $("a.link_to_remove_fields").on("click", function (e) {
        e.preventDefault();
        var link = $(this);
        remove_fields(link);
    });
}

