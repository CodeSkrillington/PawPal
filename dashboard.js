/**
 * PawPal Dashboard Page - JavaScript
 * Handles dashboard functionality and displays pet-specific information
 */

// Initialize auth
let auth = new PawPalAuth({
  storageKey: 'example_app_user',
  usersKey: 'example_app_users'
});

// Check if user is logged in
const currentUser = auth.getCurrentUser();
if (!currentUser) {
  // Redirect to login if not authenticated
  window.location.href = 'modular-login.html';
} else {
  // Load the selected pet's dashboard
  loadPetDashboard();
}

// Logout function
async function handleLogout() {
  const result = await auth.logout();
  if (result.success) {
    window.location.href = 'modular-login.html';
  }
}

function loadPetDashboard() {
  // Get the selected pet ID from session storage
  const petId = sessionStorage.getItem('selectedPetId');
  
  if (!petId) {
    // No pet selected, redirect to home
    window.location.href = 'home.html';
    return;
  }

  // Get the pet from user's pets
  const pets = getUserPets();
  const pet = pets.find(p => p.id === Number(petId));

  if (!pet) {
    // Pet not found, redirect to home
    window.location.href = 'home.html';
    return;
  }

  // Update the header with pet info
  const icon = pet.type === 'dog' ? '🐕' : pet.type === 'cat' ? '🐈' : '🐾';
  document.getElementById('petIcon').textContent = icon;
  document.getElementById('petName').textContent = pet.name + "'s Dashboard";
  document.getElementById('petSubtitle').textContent = `Detailed information and health records for ${pet.name}`;

  // Load pet details
  loadPetDetails(pet);
  loadMedication(pet);
  loadDoseLogging(pet);
}

function loadPetDetails(pet) {
  const container = document.getElementById('petDetailsContainer');
  
  const details = `
    <div class="dashboard-info-grid">
      <div class="info-item">
        <span class="info-label">Type:</span>
        <span class="info-value">${pet.type.charAt(0).toUpperCase() + pet.type.slice(1)}</span>
      </div>
      ${pet.breed ? `
      <div class="info-item">
        <span class="info-label">Breed:</span>
        <span class="info-value">${pet.breed}</span>
      </div>
      ` : ''}
      ${pet.age !== null && pet.age !== undefined ? `
      <div class="info-item">
        <span class="info-label">Age:</span>
        <span class="info-value">${pet.age} ${pet.age === 1 ? 'year' : 'years'}</span>
      </div>
      ` : ''}
      ${pet.sex ? `
      <div class="info-item">
        <span class="info-label">Sex:</span>
        <span class="info-value">${pet.sex}</span>
      </div>
      ` : ''}
      ${pet.weight ? `
      <div class="info-item">
        <span class="info-label">Weight:</span>
        <span class="info-value">${pet.weight} lbs</span>
      </div>
      ` : ''}
    </div>
  `;
  
  container.innerHTML = details;
}

function loadMedication(pet) {
  const container = document.getElementById('healthContainer');
  
  if (pet.medicine) {
    const reminderKey = `pawpal_med_reminder_${currentUser.email}_${pet.id}`;
    const reminder = JSON.parse(localStorage.getItem(reminderKey) || '{}');
    
    container.innerHTML = `
      <div class="info-item">
        <span class="info-label">💊 Medication</span>
        <span class="info-value">${pet.medicine}</span>
      </div>
      <div style="margin-top: 16px; padding: 14px; background-color: rgba(59, 89, 152, 0.08); border-radius: 8px; border-left: 3px solid var(--primary, #3b5998);">
        <label style="display: block; font-weight: 600; color: var(--primary, #3b5998); margin-bottom: 8px; font-size: 12px; text-transform: uppercase; letter-spacing: 0.5px;">Reminder Interval (hours)</label>
        <div style="display: flex; gap: 8px;">
          <input type="number" id="reminderInterval" min="1" max="24" value="${reminder.interval || '8'}" placeholder="Hours between doses" style="flex: 1; padding: 8px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; font-family: inherit;">
          <button onclick="saveReminder(${pet.id})" style="padding: 8px 16px; background-color: #3b5998; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: 600;">Save</button>
        </div>
        ${reminder.interval ? `<span class="info-value" style="display: block; margin-top: 8px;">Reminder set for every ${reminder.interval} hours</span>` : ''}
      </div>
    `;
  } else {
    container.innerHTML = '<p>No medication recorded. Add medication information to set reminders.</p>';
  }
}

function saveReminder(petId) {
  const interval = document.getElementById('reminderInterval').value.trim();
  
  if (!interval || interval < 1 || interval > 24) {
    alert('Please enter a valid interval between 1 and 24 hours');
    return;
  }
  
  const reminderKey = `pawpal_med_reminder_${currentUser.email}_${petId}`;
  const reminder = {
    interval: parseInt(interval),
    lastSet: new Date().toISOString()
  };
  
  localStorage.setItem(reminderKey, JSON.stringify(reminder));
  
  // Reload the medication section
  const pets = getUserPets();
  const pet = pets.find(p => p.id === petId);
  if (pet) {
    loadMedication(pet);
  }
}

function loadDoseLogging(pet) {
  const container = document.getElementById('notesContainer');
  
  // Check if pet has medicine info to log doses for
  if (pet.medicine) {
    const doseLogKey = `pawpal_dose_log_${currentUser.email}_${pet.id}`;
    const doseLogs = JSON.parse(localStorage.getItem(doseLogKey) || '[]');
    
    let logsHTML = `
      <div class="dose-logging-form">
        <div style="margin-bottom: 16px;">
          <label style="display: block; font-weight: 600; color: var(--primary, #3b5998); margin-bottom: 8px; font-size: 12px; text-transform: uppercase;">Log Dose</label>
          <textarea id="doseNote" placeholder="e.g., Morning dose - 10mg, given at 8:00 AM" style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; font-family: inherit; min-height: 60px;"></textarea>
          <button onclick="saveDose(${pet.id})" style="margin-top: 8px; padding: 8px 16px; background-color: #3b5998; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: 600;">Add Entry</button>
        </div>
      </div>
    `;
    
    if (doseLogs.length > 0) {
      logsHTML += `<div class="dose-history"><h4 style="color: var(--primary, #3b5998); margin: 16px 0 12px 0; font-size: 12px; text-transform: uppercase; font-weight: 600; letter-spacing: 0.5px;">Recent Logs</h4>`;
      doseLogs.slice().reverse().slice(0, 5).forEach(log => {
        logsHTML += `<div class="info-item" style="margin-bottom: 8px;"><span class="info-label">${new Date(log.timestamp).toLocaleDateString()} ${new Date(log.timestamp).toLocaleTimeString()}</span><span class="info-value">${log.note}</span></div>`;
      });
      logsHTML += `</div>`;
    }
    
    container.innerHTML = logsHTML;
  } else {
    container.innerHTML = '<p>No medicine recorded. Add medicine information to start logging doses.</p>';
  }
}

function getUserPets() {
  const userPetsKey = `pawpal_pets_${currentUser.email}`;
  const petsData = localStorage.getItem(userPetsKey);
  return petsData ? JSON.parse(petsData) : [];
}

function saveDose(petId) {
  const doseNote = document.getElementById('doseNote').value.trim();
  
  if (!doseNote) {
    alert('Please enter a dose entry');
    return;
  }
  
  const doseLogKey = `pawpal_dose_log_${currentUser.email}_${petId}`;
  const doseLogs = JSON.parse(localStorage.getItem(doseLogKey) || '[]');
  
  doseLogs.push({
    timestamp: new Date().toISOString(),
    note: doseNote
  });
  
  localStorage.setItem(doseLogKey, JSON.stringify(doseLogs));
  
  // Clear the input and reload
  document.getElementById('doseNote').value = '';
  
  // Reload the dose logging section
  const pets = getUserPets();
  const pet = pets.find(p => p.id === petId);
  if (pet) {
    loadDoseLogging(pet);
  }
}
