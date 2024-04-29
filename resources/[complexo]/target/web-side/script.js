window.addEventListener("message", function(event) {
    let item = event["data"];

    if (item.Action == "openTarget") {

        $(".target-label").html("");
        $(".target").css("display", "flex");
        $(".target-eye").css("color", "#fff");

    } else if (item.Action == "closeTarget") {

        $(".target-label").html("");
        $(".target").css("display", "none");
        $(".target-eye").css("color", "#fff");

    } else if (item.Action == "validTarget") {
        $(".target-label").html("");

        $.each(item["data"], function(index, item) {
            $(".target-label").append("<div class='target-text' id='target-" + index + "'<li>" + item["label"] + "</li></div>");

            $("#target-" + index).hover((e) => {
                if (item["overrideColor"]) {
                    $("#target-" + index).css("color", e["type"] === "mouseenter" ? item["overrideColor"] : "#fff")
                } else {
                    $("#target-" + index).css("color", e["type"] === "mouseenter" ? "#fff" : "#d6d9df")
                }
            });

            $("#target-" + index).css("padding-top", "10px");
            $("#target-" + index).data("TargetData", item["event"]);
            $("#target-" + index).data("TunnelData", item["tunnel"]);
            $("#target-" + index).data("ServiceData", item["service"]);
        });

        $(".target-eye").css("color", "#f50a46");

    } else if (item.Action == "leftTarget") {

        $(".target-label").html("");
        $(".target").css("display", "none");
        $(".target-eye").css("color", "#fff");

        $.post("https://target/closeTarget");

    }

    document.onkeyup = data => {
        if (data["key"] === "Escape") {
            $(".target-label").html("");
            $(".target").css("display", "none");
            $(".target-eye").css("color", "#fff");

            $.post("https://target/closeTarget");
        }
    };
});

$(document).on("mousedown", (event) => {
    let element = event["target"];

    if (element["id"].split("-")[0] === "target") {
        let targetData = $("#" + element["id"]).data("TargetData");
        let tunnelData = $("#" + element["id"]).data("TunnelData");
        let serviceData = $("#" + element["id"]).data("ServiceData");

        $.post("https://target/selectTarget", JSON.stringify({ event: targetData, tunnel: tunnelData, service: serviceData }));

        $(".target-label").html("");
        $(".target").css("display", "none");
        $(".target-eye").css("color", "#fff");
    }
});