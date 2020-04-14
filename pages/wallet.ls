require! {
    \react
    \../tools.ls : { money }
    \prelude-ls : { each, find }
    \react-copy-to-clipboard : { CopyToClipboard }
    \../copied-inform.ls
    \../copy.ls
    \../address-link.ls : { get-address-link, get-address-title }
    \../wallet-funcs.ls
    \../get-lang.ls
    \./icon.ls
    \../get-primary-info.ls
    \../../web3t/providers/superagent.ls : { get }
    \../icons.ls
    \../round-human.ls
}
#
.wallet
    @import scheme
    $cards-height: 324px
    $pad: 20px
    $radius: 15px 
    position: relative
    cursor: pointer
    $card-height: 60px
    height: $card-height
    &.last
        height: 60px
    $mt: 20px
    box-sizing: border-box
    overflow: hidden
    transition: height .5s
    border: 0px
    &:first-child
        margin-top: 0
        box-shadow: none
    .pending
        color: orange
    &.over
        background: #CCC
    &.big
        height: 120px
    &.active
        >.wallet-middle
            display: inline-block
    >.wallet-top
        padding: 0 12px
        box-sizing: border-box
        $card-top-height: 50px
        width: 100%
        color: #677897
        font-size: 14px
        text-align: center
        overflow: hidden
        >*
            display: inline-block
            box-sizing: border-box
            vertical-align: top
            padding-top: 12px
            height: $card-top-height
        >.top-left
            width: 30%
            text-align: left
            overflow: hidden
            text-overflow: ellipsis
            >*
                display: inline-block
            >.img
                line-height: $card-top-height
                vertical-align: top
                margin-right: 5px
                >img
                    vertical-align: top
                    max-width: 50px
                    $s: 35px
                    border-radius: $s
                    width: $s
                    height: $s
            >.info
                text-align: left
                margin-left: 0px
                text-overflow: ellipsis
                overflow: hidden
                width: 65px
                @media screen and (max-width: 390px)
                    display: none
                >.name
                    padding-left: 3px
                >.price
                    padding-left: 3px
                    font-size: 12px
                    font-weight: bold
                    overflow: hidden
                    text-overflow: ellipsis
        >.top-middle
            width: 30%
            text-align: center
            .label-coin
                height: 16px
                top: 3px
                padding-left: 4px
                position: relative
            @media screen and (max-width: 800px)
                width: 35%
            >.balance
                &:last-child
                    font-weight: bold
                    font-size: 13px
                &.title
                    @media screen and (max-width: 220px)
                        display: none
                .title-balance
                    display: none
        >.top-right
            width: 40%
            text-align: right
            @media screen and (max-width: 800px)
                width: 35%
            >button
                outline: none
                margin-bottom: 5px
                margin-left: 5px
                cursor: pointer
                border: 1px solid
                $round: 36px
                padding: 0
                box-sizing: border-box
                border-radius: $border
                font-size: 10px
                width: auto
                padding: 0 6px
                height: $round
                color: #6CA7ED
                text-transform: uppercase
                font-weight: bold
                background: transparent
                transition: all .5s
                text-overflow: ellipsis
                overflow: hidden
                width: 80px
                .icon
                    position: relative
                    height: 16px
                    top: 2px
                @media screen and (max-width: 800px)
                    width: 40px
                &:hover
                    background: #7aa7f3
                    color: white
    >.wallet-middle
        $card-top-height: 50px
        width: 100%
        padding: 0 12px
        box-sizing: border-box
        color: #A8BACB
        font-size: 14px
        margin-top: 10px
        text-align: center
        position: relative
        .browse
            display: none
        &:last-child
            display: none
        >.uninstall
            text-align: left
            font-size: 10px
            padding-top: 5px
        >img
            position: absolute
            right: 3%
            margin: 10px
            margin-left: 50px
            z-index: 2
        >span
            width: 100%
            z-index: 1
            position: relative
            border-radius: $border
            border: 0
            background: #E6F0FF
            box-sizing: border-box
            vertical-align: top
            text-align: center
            padding-left: 20px
            padding-right: 25px
            height: $card-top-height - 14px
            color: #677897
            font-size: 14px
            line-height: $card-top-height - 14px
            display: inline-block
            text-overflow: ellipsis
            overflow: hidden
            user-select: text !important
            cursor: auto
            @media screen and (max-width: 390px)
                padding-right: 25px
            a
                width: auto
                z-index: 1
                position: relative
                border-radius: $border
                border: 0
                background: transparent
                box-sizing: border-box
                vertical-align: top
                text-align: center
                height: $card-top-height - 14px
                color: rgb(204, 204, 204)
                font-size: 14px
                line-height: $card-top-height - 14px
                display: inline-block
                text-overflow: ellipsis
                overflow: hidden
                cursor: pointer
                user-select: text !important
                @media screen and (max-width: 390px)
                    width: 90%
module.exports = (store, web3t, wallets, wallet)-->
    { button-style, uninstall, wallet, active, big, balance, balance-usd, pending, send, receive, expand, usd-rate, last } = wallet-funcs store, web3t, wallets, wallet
    lang = get-lang store
    style = get-primary-info store
    icons-browse =
        browse: "data:image/png;base64,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"
    label-uninstall =
        | store.current.refreshing => \...
        | _ => \ "#{lang.hide}"
    wallet-style=
        color: style.app.text3
    border-style =
        border-bottom: "1px solid #{style.app.border}"
        background: style.app.wallet
    button-primary1-style=
        border: "1px solid #{style.app.primary1}"
        color: style.app.text
        background: style.app.primary1
    button-primary1-style-m=
        border: "1px solid rgb(195, 92, 95)"
        color: style.app.text
        background: "rgb(195, 92, 95)"
    button-primary3-style=
        border: "1px solid #{style.app.primary3}"
        color: style.app.text2
        background: style.app.primary3
    address-input=
        color: style.app.addressText
        background: style.app.addressBg
    filter-icon=
        filter: style.app.filterIcon
    btn-icon =
        filter: style.app.btn-icon
    placeholder = 
        | store.current.refreshing => "placeholder"
        | _ => ""
    placeholder-coin = 
        | store.current.refreshing => "placeholder-coin"
        | _ => ""
    name = wallet.coin.name ? wallet.coin.token
    load-terms = (cb)->
        #return cb null if store.current.content-migrate?
        err, res <- get \https://raw.githubusercontent.com/okhrimenkoalexey/Velas/master/terms.md .end
        return cb err if err?
        store.terms2 = res.text
        cb null
    migrate = (wallet)-> ->
        #return alert "disabled" if window.location.href.index-of('internal') is -1
        err <- load-terms
        address = 
            store.current.account.wallets 
                |> find (-> it.coin.token is \vlx2) 
                |> (.address)
        return alert "addres #{address} is wrong" if typeof! address isnt \String
        err, data <- get "https://mainnet-v2.velas.com/migration/topup-velas-address/#{address}" .end
        return alert "#{err}" if err?
        return alert "cannot create address" if not data.body?address?
        store.current.token-migration = data.body.address
        #store.current.token-migration = "V123"
    .wallet.pug(on-click=expand class="#{last + ' ' + active + ' ' + big}" key="#{wallet.coin.token}" style=border-style)
        .wallet-top.pug
            .top-left.pug(style=wallet-style)
                .img.pug(class="#{placeholder-coin}")
                    img.pug(src="#{wallet.coin.image}")
                .info.pug
                    .name.pug(class="#{placeholder}" title="#{usd-rate}") $#{ round-human usd-rate}
                    .price.pug(class="#{placeholder}" title="#{balance-usd}") $#{ round-human balance-usd}
            .top-middle.pug(style=wallet-style)
                if +wallet.pending-sent is 0
                    .balance.pug.title(class="#{placeholder}") #{name}
                .balance.pug(class="#{placeholder}")
                    span.pug(title="#{wallet.balance}") #{ round-human wallet.balance }
                        img.label-coin.pug(class="#{placeholder-coin}" src="#{wallet.coin.image}")
                        span.pug #{ wallet.coin.token.to-upper-case! }
                    if +wallet.pending-sent >0
                        .pug.pending 
                            span.pug -#{ pending }
                .price.pug(class="#{placeholder}" title="#{balance-usd}") $#{ round-human balance-usd }
            .top-right.pug
                if store.current.device is \desktop
                    button.btn-open.pug(on-click=expand style=button-primary3-style)
                        img.icon.pug(src="#{icons.open}" style=btn-icon)
                button.pug(on-click=send(wallet) style=button-primary3-style)
                    if store.current.device is \mobile
                        icon "ArrowSmallUp", 25
                    if store.current.device is \desktop
                        span.pug
                            img.icon-svg.pug(src="#{icons.send}" style=btn-icon)
                            | #{lang.send}
                if wallet.coin.token isnt \vlx or store.current.device isnt \desktop
                    button.pug(on-click=receive(wallet) style=button-primary1-style)
                        if store.current.device is \mobile
                            icon "ArrowSmallDown", 25
                        if store.current.device is \desktop
                            span.pug
                                img.icon-svg.pug(src="#{icons.get}")
                                | #{lang.receive}
                else
                    button.pug(on-click=migrate(wallet) style=button-primary1-style-m)
                        span.pug 
                            img.icon-svg.pug(src="#{icons.migrate}")
                            | #{lang.btn-migrate}
        .wallet-middle.pug
            span.pug(style=address-input)
                a.browse.pug(target="_blank" href="#{get-address-link wallet}")
                    img.pug(src="#{icons.browse-open}")
                a.pug(target="_blank" href="#{get-address-link wallet}") #{get-address-title wallet}
            CopyToClipboard.pug(text="#{get-address-title wallet}" on-copy=copied-inform(store) style=filter-icon)
                copy store
            if wallet.coin.token not in <[ btc vlx vlx2 ]>
                .pug.uninstall(on-click=uninstall style=wallet-style) #{label-uninstall}
        .wallet-middle.title-balance.pug
            .name.pug(class="#{placeholder}" title="#{usd-rate}") $#{ round-human(usd-rate)}
            .name.per.pug(class="#{placeholder}") Per 1 #{ wallet.coin.token.to-upper-case! }