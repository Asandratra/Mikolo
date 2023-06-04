! function ($) {
    "use strict";

    var CalendarApp = function () {
        this.$body = $("body")
        this.$calendar = $('#calendar'),
            this.$event = ('#calendar-events div.calendar-events'),
            this.$categoryForm = $('#add-new-event form'),
            this.$extEvents = $('#calendar-events'),
            this.$modal = $('#my-event'),
            this.$saveCategoryBtn = $('.save-category'),
            this.$calendarObj = null
    };


    /* on drop */
    CalendarApp.prototype.onDrop = function (eventObj, date) {
        var $this = this;
        // retrieve the dropped element's stored Event Object
        var originalEventObject = eventObj.data('eventObject');
        var $categoryClass = eventObj.attr('data-class');
        // we need to copy it, so that multiple events don't have a reference to the same object
        var copiedEventObject = $.extend({}, originalEventObject);
        // assign it the date that was reported
        copiedEventObject.start = date;
        if ($categoryClass)
            copiedEventObject['className'] = [$categoryClass];
        // render the event on the calendar
        $this.$calendar.fullCalendar('renderEvent', copiedEventObject, true);
        // is the "remove after drop" checkbox checked?
        if ($('#drop-remove').is(':checked')) {
            // if so, remove the element from the "Draggable Events" list
            eventObj.remove();
        }
    },
        CalendarApp.prototype.enableDrag = function () {
            //init events
            $(this.$event).each(function () {
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
        }
    /* Initializing */
    CalendarApp.prototype.init = function (idfilm, data, holiday) {
        this.enableDrag();
        /*  Initialize the calendar  */
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        var form = '';
        var today = new Date($.now());

        //prendre les events;
       /* $.get('/film/' + idfilm + '/planning', function (data) {
            
        });*/
        var datas =[];
        var holi=[];
        if(data!=null){
             datas=data;
        }   
        if(holiday!=null){
            holi=holiday;
        } 
        console.log(datas); 
            var event = [];
            
            for (let i = 0; i < datas.length; i++) {
                console.log(new Date(datas[i].date_debut))
                event.push(
                    {
                        title: datas[i].scene?.title,
                        start: new Date(datas[i].date_debut),
                        end: new Date(datas[i].date_fin),
                        className: 'bg-info',
                        url: '/film/film/' + idfilm + '/scene/' + datas[i].scene.id
                    }
                );
            }
            
            for (let i = 0; i < holi.length; i++) {
                //console.log(new Date(holi[i].date_debut))
                //console.log(new Date(holi[i].date));
                const date = new Date(holi[i].date);
                date.setHours(date.getHours()+23)

                event.push(
                    {
                        title: 'ferie '+ holi[i].name,
                        start:new Date(holi[i].date) ,
                        end: date ,
                        className: 'bg-success',               
                    }
                );
            }
            console.log(holi);
            console.log(event);
            var $this = this;
            $this.$calendarObj = $this.$calendar.fullCalendar({
                slotDuration: '00:15:00',
                /* If we want to split day time each 15minutes */
                minTime: '08:00:00',
                maxTime: '19:00:00',
                defaultView: 'month',
                handleWindowResize: true,

                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                },
                events: event,
                editable: true,
                droppable: true, // this allows things to be dropped onto the calendar !!!
                eventLimit: true, // allow "more" link when too many events
                selectable: true,
                drop: function (date) { $this.onDrop($(this), date); },
                select: function (start, end, allDay) { $this.onSelect(start, end, allDay); },
                eventClick: function (calEvent, jsEvent, view) { $this.onEventClick(calEvent, jsEvent, view); }

            });
    },
        //init CalendarApp
        $.CalendarApp = new CalendarApp, $.CalendarApp.Constructor = CalendarApp

}(window.jQuery),

    //initializing CalendarApp
    $(window).on('load', function () {
    });
