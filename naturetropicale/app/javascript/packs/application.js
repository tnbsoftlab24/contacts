// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

// import "../src/plugins/malihu-custom-scrollbar-plugin-master/jquery.mousewheel.min"
// require.context('../../fonts/', true, /\.(gif|jpg|png|svg|eot|ttf|woff|woff2)$/i)
import "bootstrap"
import "@fortawesome/fontawesome-free/js/all";

import JQuery from 'jquery';

import "../vendors/scripts/fullcalendar.js";
import "../vendors/scripts/jquery-1.10.2.js";
// import "../vendors/scripts/jquery-ui.custom.min.js";
window.$ = window.JQuery = JQuery;

import intlTelInput from 'intl-tel-input'
import telUtils from "../vendors/intl-tel-input/js/utils.js";
window.intlTelInput = intlTelInput






// window.iti = iti;


// // jquery-ui theme
// require.context('file-loader?name=[path][name].[ext]&context=node_modules/jquery-ui-dist!jquery-ui-dist', true, /jquery-ui\.css/);
// require.context('file-loader?name=[path][name].[ext]&context=node_modules/jquery-ui-dist!jquery-ui-dist', true, /jquery-ui\.theme\.css/);




// $(function() {
//         // Plain jquery
//         $('#fadeMe').fadeOut(5000);

//         // jquery-ui
//         const availableCities = ['Baltimore', 'New York'];
//         $('#cityField').autocomplete({ source: availableCities });
//         $('#calendarField').datepicker({ dateFormat: 'yy-mm-dd' });
//     })
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//


const images = require.context('../images', true)
require("packs/custom")
    // $(document).on('turbolinks:before-cache', clearCalendar);
require('./nested-forms/manageFields')

$(document).on("turbolinks:load", () => {

    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();

    /*  className colors

    className: default(transparent), important(red), chill(pink), success(green), info(blue)

    */


    /* initialize the external events
    -----------------------------------------------------------------*/

    $('#external-events div.external-event').each(function() {

        // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
        // it doesn't need to have a start or end
        var eventObject = {
            title: $.trim($(this).text()) // use the element's text as the event title
        };

        // store the Event Object in the DOM element so we can get to it later
        $(this).data('eventObject', eventObject);

        // make the event draggable using jQuery UI
        $(this).draggable({
            zIndex: 999,
            revert: true, // will cause the event to go back to its
            revertDuration: 0 //  original position after the drag
        });

    });


    /* initialize the calendar
    -----------------------------------------------------------------*/

    var calendar = $('#calendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,basicWeek ,basicDay'
        },
        buttonText: {
            prev: 'prec',
            next: 'suiv'
        },
        timeFormat: 'h:mm',
        selectable: true,
        eventClick: function(calEvent, jsEvent, view) {
            // alert('Event: ' + calEvent.title);
            // change the border color just for fun
            $(this).css('border-color', 'red');

        },
        allDaySlot: false,
        selectHelper: true,
        // select: function(start, end, allDay) {
        //   var title = prompt('Event Title:');
        //   if (title) {
        //     calendar.fullCalendar('renderEvent',
        //       {
        //         title: title,
        //         start: start,
        //         end: end,
        //         allDay: allDay
        //       },
        //       true // make the event "stick"
        //     );
        //   }
        //   calendar.fullCalendar('unselect');
        // },
        // droppable: true, // this allows things to be dropped onto the calendar !!!
        drop: function(date, allDay) { // this function is called when something is dropped

            // retrieve the dropped element's stored Event Object
            var originalEventObject = $(this).data('eventObject');

            // we need to copy it, so that multiple events don't have a reference to the same object
            var copiedEventObject = $.extend({}, originalEventObject);

            // assign it the date that was reported
            copiedEventObject.start = date;
            copiedEventObject.allDay = allDay;

            // render the event on the calendar
            // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
            $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

            // is the "remove after drop" checkbox checked?
            if ($('#drop-remove').is(':checked')) {
                // if so, remove the element from the "Draggable Events" list
                $(this).remove();
            }

        },
        eventSources: [{
            url: '/jobs.json', // use the `url` property
            method: 'GET'
        }],

    });

    $(function() {
        $("#jobs th a, #jobs .pagination a").on("click", '#search', function() {
            $.getScript(this.href);
            return false;
        });
        $("#jobs_search input").keyup(function() {
            $.get($("#jobs_search").attr("action"), $("#jobs_search").serialize(), null, "script");
            return false;
        });
    });

});

$(window).on('popstate', function(event) {
    location.reload();
});

require('datatables.net-bs4')($);


import "../stylesheets/application"


$(document).ready(function() {
    $('#sidebarCollapse').on('click', function() {
        $('#sidebar').toggleClass('active');
        $('#content').toggleClass('active');
    });
});