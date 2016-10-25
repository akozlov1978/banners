$ ->

    timer = () ->
        numFormat = (num) ->
            if num < 10 then return "0#{num}"
            else return num

        endDate = new Date $('.js-countdown-timer').attr('data-finaldate')
        nowDate = new Date
        totalSecsLeft = endDate.getTime() - nowDate.getTime()
        totalSecsLeft = Math.abs totalSecsLeft / 1e3
        $items = $ '.js-countdown-timer-container .e-timer-item'
        $items.removeClass 'flip'

        offsets =
            seconds: Math.floor totalSecsLeft % 60
            minutes: Math.floor(totalSecsLeft / 60) % 60
            hours:   Math.floor(totalSecsLeft / 60 / 60) % 24
            days:    Math.floor(totalSecsLeft / 60 / 60 / 24) % 7

        for key, value of offsets
            $items.removeClass 'flip'
            $item = $items.filter ".#{key}"
            
            $item
                .find '.curr.top, .curr.bottom'
                .text $item.find('.next.top').text()
            $item
                .find '.next.top, .next.bottom'
                .text numFormat(value)

            if parseInt($item.find('.curr.top').text()) != parseInt($item.find('.next.top').text())
                $item.addClass 'changed'
                setTimeout () =>
                    $items.filter '.changed'
                        .removeClass 'changed'
                        .addClass 'flip'
                , 50

        setTimeout timer, 1000

    timer()
