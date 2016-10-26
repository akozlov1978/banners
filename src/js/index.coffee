$ ->

    timer = () ->
        numFormat = (num) -> if num < 10 then return "0#{num}" else return num
        removeClass = ($items, className) ->
            $items.forEach ($item) ->
                $item.className = $item.className.replace /\sflip/ig, ''

        endDate = new Date document.querySelector('.js-countdown-timer').getAttribute 'data-finaldate'
        nowDate = new Date
        totalSecsLeft = endDate.getTime() - nowDate.getTime()
        totalSecsLeft = Math.abs totalSecsLeft / 1e3
        $items = document.querySelectorAll '.js-countdown-timer-container .e-timer-item'
        removeClass $items, 'flip'

        offsets =
            seconds: Math.floor totalSecsLeft % 60
            minutes: Math.floor(totalSecsLeft / 60) % 60
            hours:   Math.floor(totalSecsLeft / 60 / 60) % 24
            days:    Math.floor(totalSecsLeft / 60 / 60 / 24) % 7

        for key, value of offsets
            removeClass $items, 'flip'
            $item = ($item for $item in $items when $item.className.match /#{key}/)[0]
            #$item = $items.querySelector ".#{key}"
            
            $item.querySelector '.curr.top, .curr.bottom'
                .innerText = $item.querySelector('.next.top').innerText
            $item.querySelector '.next.top, .next.bottom'
                .innerText = numFormat(value)

            if parseInt($item.querySelector('.curr.top').innerText) != parseInt($item.querySelector('.next.top').innerText)
                $item.addClass 'changed'
                setTimeout () =>
                    $items.filter '.changed'
                        .removeClass 'changed'
                        .addClass 'flip'
                , 50

        setTimeout timer, 1000

    timer()
