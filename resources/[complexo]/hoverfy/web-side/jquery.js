window.addEventListener("message", function (event) {
    switch (event["data"]["Action"]) {
        case "Show":
            var key = event["data"]["key"] !== undefined ? "<div id='key'>" + event["data"]["key"] + "</div>" : "";

            $("#displayNotify").html("<div class='container'>" + key + "<div id='text'><b>" + event["data"]["title"] + "</b>" + event["data"]["legend"] + "</div></div>");
            $("#displayNotify").fadeIn(); // Adiciona efeito de fade ao mostrar
            break;

        case "Hide":
            $("#displayNotify").fadeOut(); // Adiciona efeito de fade ao ocultar
            break;
    }
});