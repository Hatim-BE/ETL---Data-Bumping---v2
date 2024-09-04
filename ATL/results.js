$(document).ready(function() {    
    $('.record-form').on('submit', function(event) {
        event.preventDefault(); // Prevent the default form submission


        // Find the clicked button and get its name and value
        var $clickedButton = $(document.activeElement);
        var actionValue = $clickedButton.val();
        var actionName = $clickedButton.attr('name');
        
        // Serialize the form data including action and name as inputss
        var formData = $(this).serializeArray();

        // Add additional parameters for action and name arrays
        formData.push({ name: actionName , value: actionValue });

        $.ajax({
            url: 'process.php', // URL of the PHP file that handles the form submission
            type: 'POST', // HTTP method
            data: formData, 
            success: function(response) {
                $('#response').html(response); // Display the response from the PHP file
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('Error:', textStatus, errorThrown);
                $('#response').html('An error occurred. Please try again.');
            }
        });
    });
});


document.addEventListener("DOMContentLoaded", function(){
    var buttons = document.querySelectorAll(".addButton");
    var inputs = document.querySelectorAll("input");

    buttons.forEach(function(button) {
        button.addEventListener("mouseover", function() {
            var clickedButton = this;
            var nextInput = clickedButton.nextElementSibling;

            inputs.forEach(input => {
                if (input !== nextInput && input.tagName.toLowerCase() === 'input') {
                    input.disabled = true;
                }
            });
        });

        button.addEventListener("mouseout", function() {
            inputs.forEach(input => {
                if (input.tagName.toLowerCase() === 'input') {
                    input.disabled = false;
                }
            });
        });
    });
});


document.addEventListener("DOMContentLoaded", function(){
    var th = document.querySelectorAll("th");
    th.forEach(function(th) {
        if(th.offsetWidth > 100){
            th.style.width = "100px";
        }
    })
});

$(document).ready(function() {
$("th:contains('id')").css({
    "width": "20px"
});
});

$(window).on("load",function(){
    $(".loader-wrapper").fadeOut("slow");
});

document.addEventListener("DOMContentLoaded", function() {
    var buttons = document.querySelectorAll(".addButton");
    buttons.forEach(button => {
        button.addEventListener("click", function() {
            setTimeout(function() {
                button.disabled = true;
                button.classList.add("disabled-button");
            }, 10);
        });
    });

    var addAll = document.querySelector(".addAll");
    addAll.addEventListener("click", function(){
        buttons.forEach(button => {
            setTimeout(function() {
                button.disabled = true;
                button.classList.add("disabled-button");
            }, 10);
        });
    });
});

document.addEventListener("DOMContentLoaded", function() {

     // T7 = surface

    regex = /(m|M)(²|2)|\s|,0*/;
    tds = document.querySelectorAll("#mod #T7");
    tds.forEach(td => {
        const content = td.textContent.trim();
        
        if (regex.test(content)) {
            //console.log(content.match(regex))
            // Add the 'highlight' class to apply styling
            td.classList.add('highlight');
            td.title = "next time remove one or more of the following:\n - m²\n- spaces\n- non-numbers\n- ,00";

        }
    });

    // T9 = valeur globale
    regex = /[^0-9]|\s/;
    tds = document.querySelectorAll("#mod #T9");
    tds.forEach(td => {
        const content = td.textContent.trim();
        
        if (regex.test(content)) {
            //console.log(content.match(regex))
            // Add the 'highlight' class to apply styling
            td.classList.add('highlight');
            td.title = "next time remove one or more of the following:\n- non-numbers\n- spaces";

        }
    });

    // T14 = latitude
    // T13 = longtitude
    regex = /,|;/;
    tds = document.querySelectorAll("#mod #T13, #mod #T14");
    tds.forEach(td => {
        const content = td.textContent.trim();
        
        if (regex.test(content)) {
            //console.log(content.match(regex))
            // Add the 'highlight' class to apply styling
            td.classList.add('highlight');
            td.title = "next time remove one or more of the following:\n- ','\n- ';'";

        }
    });

    // T15 = pu
    regex = /(d|D)(h|H)\/(m|M)(²|2)|\s|,[0-9]+|\b[a-zA-Z]*\b|\u{A0}/;
    tds = document.querySelectorAll("#mod #T15");
    tds.forEach(td => {
        const content = td.textContent.trim();
        if (regex.test(content)) {
            console.log(content.match(regex))
            // Add the 'highlight' class to apply styling
            td.classList.add('highlight');
            td.title = "next time remove one or more of the following:\n - dh/m²\n- spaces\n- non-numbers\n- ,00";
        }
    });
});


document.addEventListener("DOMContentLoaded", function() {
    const updateH1Width = () => {
        const upload_form = document.querySelector(".upload-form");
        const formWidth = upload_form.offsetWidth;
        const h1s = document.querySelectorAll("h1");

        h1s.forEach(h1 => {
            h1.style.width = formWidth + "px";
        });
    };
    updateH1Width();

    window.addEventListener("resize", updateH1Width);
});
