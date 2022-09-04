$(document).on('turbolinks:load', function() {
    $('form').on('click', '.remove_record', function(event) {
        $(this).prev('input[type=hidden]').val('1');
        $(this).closest('.nested-fields').hide();
        return event.preventDefault();
    });

    $('form').on('click', '.add_fields', function(event) {
        // console.log("where are you");
        var regexp, time;
        time = new Date().getTime();
        regexp = new RegExp($(this).data('id'), 'g');
        $('.fields').append($(this).data('fields').replace(regexp, time));
        return event.preventDefault();
    });

});

$(document).on('turbolinks:load', function() {
    $('form').on('click', '.remove_record', function(event) {
        $(this).prev('input[type=hidden]').val('1');
        $(this).closest('.nested-experiences-fields').hide();
        return event.preventDefault();
    });

    $('form').on('click', '.add_experience_fields', function(event) {
        var regexp, time;
        time = new Date().getTime();
        regexp = new RegExp($(this).data('id'), 'g');
        $('.experience_fields').append($(this).data('fields').replace(regexp, time));
        return event.preventDefault();
    });
});


$(document).on('turbolinks:load', function() {
    $('form').on('click', '.remove_record', function(event) {
        $(this).prev('input[type=hidden]').val('1');
        $(this).closest('.nested-adresse-fields').hide();
        return event.preventDefault();
    });

    $('form').on('click', '.add_adresse_fields', function(event) {
        var regexp, time;
        time = new Date().getTime();
        regexp = new RegExp($(this).data('id'), 'g');
        $('.adresse_fields').append($(this).data('fields').replace(regexp, time));
        return event.preventDefault();
    });
});

$(document).on('turbolinks:load', function() {
    $('form').on('click', '.remove_record', function(event) {
        $(this).prev('input[type=hidden]').val('1');
        $(this).closest('.nested-tarifs-fields').hide();
        return event.preventDefault();
    });

    $('form').on('click', '.add_tarifs_fields', function(event) {
        var regexp, time;
        time = new Date().getTime();
        regexp = new RegExp($(this).data('id'), 'g');
        $('.tarifs_fields').append($(this).data('fields').replace(regexp, time));
        return event.preventDefault();
    });
});


$(document).on('turbolinks:load', function() {
    $('form').on('click', '.remove_record', function(event) {
        $(this).prev('input[type=hidden]').val('1');
        $(this).closest('.nested-tarifs-fields').hide();
        return event.preventDefault();
    });

    $('form').on('click', '.add_freetime_fields', function(event) {
        var regexp, time;
        time = new Date().getTime();
        regexp = new RegExp($(this).data('id'), 'g');
        $('.freetime_fields').append($(this).data('fields').replace(regexp, time));
        return event.preventDefault();
    });
});