window.addEventListener('message', function(event) {
    if (event.data.type === "playFlashSound") {
        let audio = new Audio("flash.ogg");
        audio.volume = 0.6;
        audio.play();
    }
});
