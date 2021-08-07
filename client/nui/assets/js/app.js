$(function () {
    var insert_name; var insert_ammo; var insert_price; var insert_buy; var currency; var dealer;

    function display(bool, name) {
        if(bool) {
            $('.app').css({ "display": "flex" });
            $('#shopName').append(name);
            $.post("https://sp-blackmarket/rowItems", JSON.stringify({
				dealer: dealer
			}));
        } else {
            $('.app').hide();
            $('#shopName').empty();
            $('.list').empty();
        }
    }

    display(false);
    window.addEventListener("message", function(event) {
        var item = event.data;
        if(item.display === true) {
            if(item.call === true) {
				dealer = item.dealer;
				$.post("https://sp-blackmarket/fillTypes", JSON.stringify({
					dealer: dealer
				}));
                display(true, item.name);
            } else {
                display(false, '');
            }
        } else if(item.insert_types === true) {
            insert_buy = item.buy;
            insert_name = item.weapon + ":";
            insert_ammo = item.ammo + ":";
            insert_price = item.price + ":";
            currency = item.currency;
        } else if(item.insert_item === true) {
            insertItem(item.Name, item.Price, item.Ammo, item.Image, item.WeaponClass);
        }
    })

    document.onkeyup = function(data) {
        if(data.which == 27) {
            $.post("https://sp-blackmarket/closeui", JSON.stringify({}));
        }
    }

    function insertItem(Name, Price, Ammo, Image, Class) {
        $('.list').append('<div class="item"><div class="pictureBox"><img src="./assets/image/' + Image + '" /></div><div class="info"><div class="information"><a>' + insert_name + '</a><a>' + Name + '</a></div><div class="information"><a>' + insert_ammo + '</a><a>' + Ammo + '</a></div><div class="information"><a>' + insert_price + '</a><a>' + Price + '</a><a>' + currency + '</a></div><a class="buyBtn" data-weapon="' + Class + '" data-price="' + Price + '">' + insert_buy + '</a></div></div>')
    }

    // TriggerEvent to Buy a Weapon
    $('.list').on('click', '.buyBtn', function(e) {
        var weapon = $(this).data('weapon');
        var price = $(this).data('price');
        $.post("https://sp-blackmarket/satinalim", JSON.stringify({
            weapon: weapon,
            price: price,
			dealer: dealer
        }));
        return;
    })
})
