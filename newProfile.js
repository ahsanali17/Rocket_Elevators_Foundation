const fs = require('fs');
const axios = require('axios');
const formData = require('form-data');
require('dotenv').config();

 
// const subscriptionKey = 'your-subscription-key';
// const region = 'your-region';
var subscription_key = process.env.SPEECH_SUBSCRIPTION_KEY;
var region = process.env.SPEECH_REGION;

 
module.exports = {
    createProfile: async function (file_path) {
        let form = new formData();
        form.append('file', fs.createReadStream(file_path));
        let headers = form.getHeaders();
        headers['Ocp-Apim-Subscription-Key'] = subscription_key;
    
        let url = `https://signature.${region}.cts.speech.microsoft.com/api/v1/Signature/GenerateVoiceSignatureFromFormData`;
        let response = await axios.post(url, form, { headers: headers });
        
        // get signature from response, serialize to json string
        return JSON.stringify(response.data.Signature);
    },
    
    main: async function()  {
        // use this voiceSignature string with conversation transcription calls below
        let voiceSignatureString = await createProfile();
        console.log(voiceSignatureString);
    }
}

// main();