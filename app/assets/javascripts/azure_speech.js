const loadingUpdater = loadingText => {
  document.getElementById('loadingSpinner').classList.remove('hidden');
  document.getElementById('loadingStatusText').textContent = loadingText;
};

const createProfile = async () => {
  loadingUpdater('Creating profile, please wait');
  const response = await fetch('/create_profile_id', {
    headers: {
      Accept: 'application/json',
    },
  });
  if (response.ok) {
    loadingUpdater('Enrolling profile using selected audio clip, please wait');
  }
  const parsed = await response.json();
  const newProfileId = parsed.profileId;
  await uploadAudioFile('uploadAudioSignatureFile');
  const fileName = document.getElementById('uploadAudioSignatureFile').files[0]
    .name;
  const enrollmentResponse = await fetch(
    `/enroll_profile?file_name=${fileName}&profile_id=${newProfileId}`
  );
  if (enrollmentResponse.ok) {
    document.getElementById('loadingStatusText').textContent =
      'Profile created, refreshing page';
  } else {
    document.getElementById('loadingStatusText').textContent =
      'An error occured, please verify your Azure subscription';
  }
};

const verifyAudio = async (audioFileName, profileId) => {
  loadingUpdater(
    'Comparing audio clip against selected voice profile, please wait'
  );
  try {
    const response = await fetch(
      `/verify_audio?file_name=${audioFileName}&profile_id=${profileId}`
    );
    if (response.ok) {
      document.getElementById('loadingSpinner').classList.add('hidden');
      return response.json();
    } else {
      document.getElementById('loadingStatusText').textContent =
        'An error occured, please contact an administrator';
    }
  } catch (e) {
    console.log(e);
  }
};

const uploadAudioFile = async element => {
  let audioFile = document.getElementById(`${element}`).files[0];
  if (getExtension(audioFile.name) === 'wav') {
    let formData = new FormData();
    formData.append('file', audioFile);
    loadingUpdater('Uploading audio clip, please wait...');
    const response = await fetch('/upload_audio', {
      method: 'POST',
      body: formData,
    });
    if (response.ok) {
      document.getElementById('loadingSpinner').classList.add('hidden');
      console.log('uploaded');
    } else {
      document.getElementById(
        'loadingStatusText'
      ).textContent = `Unable to upload file`;
    }
  } else {
    document.getElementById(
      'loadingStatusText'
    ).textContent = `Unable to upload file, only .wav files are accepted`;
    console.log('only wav files are accepted');
  }
};

const getExtension = filename => {
  const parts = filename.split('.');
  return parts[parts.length - 1];
};

const showTestResult = (result, score) => {
  document.getElementById(
    'resultText'
  ).textContent = `Test result: ${result} - Score: ${score}`;
};

window.addEventListener('load', () => {
  document
    .getElementById('checkAudioButton')
    .addEventListener('click', async () => {
      const audioFileName = document.getElementById('fileSelect').value;
      const profileId = document.getElementById('profileSelect').value;
      const response = await verifyAudio(audioFileName, profileId);
      showTestResult(response.recognitionResult, response.score);
    });

  document
    .getElementById('uploadNewFileButton')
    .addEventListener('click', async () => {
      await uploadAudioFile('uploadNewFile');
      location.reload();
      console.log('ok');
    });

  document
    .getElementById('enrollProfileButton')
    .addEventListener('click', async () => {
      await createProfile();
      location.reload();
      console.log('ok');
    });
});

function showDisplay() {
  var i = document.getElementsById('profileSelect');
  if (i.style.display === 'none') {
    i.style.display = 'block';
  } else {
    i.style.display = 'none';
  }
}
