var users;

window.addEventListener('message', function(event) {
    var data = event.data
    switch (data.type) {
        case 'refresh':
            refreshAll(data);
            break;
        case 'close':
            close();
            break;
    }
})

function refreshAll(data) {
    $('.scoreboard-container').fadeToggle();
    users = data.users
    $('.player-counter-text').html(data.plycount + "/64"); 
    $('.staff-counter-text').html(data.staffcount + "/11"); 

    $(".player-list-container").empty()
    for (const [key, value] of Object.entries(users)) {
        addPlayers(value)
    }
}

function close() {
    $.post("https://ys-scoreboard/close")
}

function addPlayers(value) {

    $('.player-list-container').append(`
        <div class="player-card">
            <img src="${value.image}" alt="" class="player-image">
            <p class="player-discord info">${value.name}</p>
            <p class="player-ping">${value.ping} MS</p>
        </div>
    `)
}

function removePlayers() {
    $('.player-list-container').html(`
        <div class="player-card">
            <img class="player-image">
            <p class="player-discord"></p>
            <p class="player-ping">ms</p>
        </div>
    `)
}

window.addEventListener("keyup", function (key) {
    if (key.which === 27) {
        $('.scoreboard-container').fadeToggle();
        close()
    }
})