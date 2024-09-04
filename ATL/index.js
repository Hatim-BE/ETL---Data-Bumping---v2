const uploadForm = document.querySelector('.index-upload-form');
const filesInput = uploadForm.querySelector('#files');
const msgCont = document.querySelector('.msg-cont');
const msgText = document.querySelector('.msg');
const resultForm = document.querySelector('.result');

filesInput.onchange = () => {
    const label = uploadForm.querySelector('label');
    label.innerHTML = '';
    for (let i = 0; i < filesInput.files.length; i++) {
        label.innerHTML += '<span><i class="fa-solid fa-file"></i>' + filesInput.files[i].name + '</span>';
    }
};

uploadForm.onsubmit = event => {
    if (!filesInput.files.length) {
    } else {
        let uploadFormData = new FormData(uploadForm);
        let request = new XMLHttpRequest();
        request.open('POST', uploadForm.action);
        request.upload.addEventListener('progress', event => {
            if (event.lengthComputable) {
                const percentage = (event.loaded / event.total) * 100;
                uploadForm.querySelector('.upload').innerHTML = 'Uploading... ' + percentage.toFixed(2) + '%';
                uploadForm.querySelector('.progress').style.background = `linear-gradient(to right, #25b350, #25b350 ${percentage}%, #e6e8ec ${percentage}%)`;
                uploadForm.querySelector('.upload').disabled = true;
            }
        });


        request.send(uploadFormData);
    }
};


$(document).ready(function() {    
    $('.index-upload-form').on('submit', function(event) {
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



function updateLabel() {
    var separatorSelect = document.getElementById('separator');
    var separatorLabel = document.getElementById('separator-label');
    var selectedValue = separatorSelect.options[separatorSelect.selectedIndex].text;
    separatorLabel.textContent = 'Choose CSV Separator: ' + selectedValue;
}


