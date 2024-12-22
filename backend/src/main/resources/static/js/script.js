function showAlert(message) {
    document.getElementById('alertMessage').textContent = message;
    document.getElementById('customAlert').style.display = 'block';
}

function closeAlert() {
    document.getElementById('customAlert').style.display = 'none';
}

document.getElementById('passwordForm').addEventListener('submit', async function(event) {
    event.preventDefault();

    const password1 = document.getElementById('password1').value;
    const password2 = document.getElementById('password2').value;
    const username = document.getElementById('username').textContent.trim(); // Get the username from the span

    if (password1 && password2 && password1 === password2) {
        showAlert('Creating Password...');

        try {
            const response = await fetch(`http://localhost:8585/api/doctor/create-password/${username}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({
                    password: password1,
                    password2: password2,
                }),
            });

            if (response.ok) {
                showAlert('Password created successfully!');
                setTimeout(() => {
                    window.location.href = '/success'; // Adjust the success URL
                }, 2000);
            } else {
                const errorText = await response.text();
                showAlert(`Failed to create password: ${errorText}`);
            }
        } catch (error) {
            showAlert(`An error occurred: ${error.message}`);
        }
    } else {
        showAlert('Passwords do not match or fields are empty. Please try again.');
    }
});

function togglePasswordVisibility() {
    const password1 = document.getElementById('password1');
    const password2 = document.getElementById('password2');
    const checkbox = document.getElementById('showPassword');

    if (checkbox.checked) {
        password1.type = 'text';
        password2.type = 'text';
    } else {
        password1.type = 'password';
        password2.type = 'password';
    }
}
