window.onload = () ->

    timer = () ->
        numFormat = (num) -> if num < 10 then return "0#{num}" else return String(num)
        removeClass = ($items, className) ->
            $items.forEach ($item) -> $item.classList.remove className
        addClass = ($items, className) ->
            $items.forEach ($item) -> $item.classList.add className

        $timer  = document.querySelector '.js-timer'
        endDate = new Date $timer.dataset.finaldate
        nowDate = new Date

        totalSecsLeft = endDate.getTime() - nowDate.getTime()
        totalSecsLeft = Math.abs totalSecsLeft / 1e3

        $items = document.querySelectorAll '.js-timer-count'
        removeClass $items, 'flip'

        offsets =
            seconds: Math.floor totalSecsLeft % 60
            minutes: Math.floor(totalSecsLeft / 60) % 60
            hours:   Math.floor(totalSecsLeft / 60 / 60) % 24
            days:    Math.floor(totalSecsLeft / 60 / 60 / 24) % 7

        for key, value of offsets
            $item = $timer.querySelector ".js-timer-count--#{key}"
            $parts = $item.querySelectorAll ".js-timer-count__part"
            removeClass $parts, 'flip'

            newValue = numFormat(value)
            $parts[0].children[0].dataset.current = $parts[0].children[0].dataset.next
            $parts[0].children[1].dataset.current = $parts[0].children[0].dataset.next
            $parts[1].children[0].dataset.current = $parts[1].children[0].dataset.next
            $parts[1].children[1].dataset.current = $parts[1].children[0].dataset.next
            $parts[0].children[0].dataset.next = newValue[0]
            $parts[0].children[1].dataset.next = newValue[0]
            $parts[1].children[0].dataset.next = newValue[1]
            $parts[1].children[1].dataset.next = newValue[1]

            if parseInt($parts[0].children[0].dataset.current) != parseInt($parts[0].children[0].dataset.next)
                $parts[0].className += ' js-changed'

            if parseInt($parts[1].children[0].dataset.current) != parseInt($parts[1].children[0].dataset.next)
                $parts[1].className += ' js-changed'

            setTimeout () =>
                $changed = $timer.querySelectorAll '.js-changed'
                removeClass $changed, 'js-changed'
                addClass $changed, 'flip'
            , 50

        setTimeout timer, 1000

    timer()
