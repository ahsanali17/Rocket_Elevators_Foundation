    /* To run this sample, install:
    npm install microsoft-cognitiveservices-speech-sdk
    */
require('dotenv').config();

var createProfile = require('./newProfile.js');

const { Console } = require("console");
const { ConnectionEstablishErrorEvent } = require("microsoft-cognitiveservices-speech-sdk/distrib/lib/src/common/Exports");

var subscription_key = process.env.SPEECH_SUBSCRIPTION_KEY;
var region = process.env.SPEECH_REGION;



"use strict";
var sdk = require("microsoft-cognitiveservices-speech-sdk");
var fs = require("fs");

// Note: Change the locale if desired.
const profile_locale = "en-us";

// Note: passphrase_files and verify_file should contain paths to audio files that contain \"My voice is my passport, verify me.
const passphrase_files = ["sounds/myVoiceIsMyPassportVerifyMe01.wav", "sounds/myVoiceIsMyPassportVerifyMe02.wav", "sounds/myVoiceIsMyPassportVerifyMe03.wav"];
const verify_file = "sounds/myVoiceIsMyPassportVerifyMe01.wav";
const id_names = [" |Don|"," |Tim|"," |Scharles|"," |Ahsan|"," |Kaelen|"]
// Identify with independent text around 50 seconds audio
const identify_file = "sounds/aboutSpeechSdk.wav";


const ticks_per_second = 10000000;

/* From: https://github.com/Azure-Samples/cognitive-services-speech-sdk/blob/fa6428a0837779cbeae172688e0286625e340942/quickstart/javascript/node/speaker-recognition/verification/dependent-verification.js#L8
*/
function GetAudioConfigFromFile (file)
{
    let pushStream = sdk.AudioInputStream.createPushStream();
    fs.createReadStream(file).on("data", function(arrayBuffer) {
        pushStream.write(arrayBuffer.buffer);
    }).on("end", function() {
        pushStream.close();
    });
    return sdk.AudioConfig.fromStreamInput(pushStream);
}

async function TextIndependentVerification(client, speech_config)
{
    console.log ("Powered by:");
    console.log ("_____________________");
    console.log ("|R.E.S.R. Technology|");
    console.log ("|___________________|\n");
    console.log ("Text Independent Verification:\n");

    var profile = null;
    try {
        // Create the profile.
        profile = await new Promise ((resolve, reject) => {
            client.createProfileAsync (sdk.VoiceProfileType.TextIndependentVerification, profile_locale, result => { resolve(result); }, error => { reject(error); });
        });
        console.log ("Created profile ID: " + profile.profileId + id_names[0]);
        await AddEnrollmentsToTextIndependentProfile(client, profile, [identify_file]);
        const audio_config = GetAudioConfigFromFile(passphrase_files[0]);
        const recognizer = new sdk.SpeakerRecognizer(speech_config, audio_config);
        await SpeakerVerify(profile, recognizer);
    }
    catch (error) {
        console.log ("Error:\n" + error);
    }
    finally {
        if (profile !== null) {
            console.log ("Deleting profile ID: " + profile.profileId);
            await new Promise ((resolve, reject) => {
                client.deleteProfileAsync (profile, result => { resolve(result); }, error => { reject(error); });
            });
        }
    }
}

async function AddEnrollmentsToTextIndependentProfile(client, profile, audio_files)
{
    for (var i = 0; i < audio_files.length; i++) {
        console.log ("Adding enrollment to text independent profile...");
        const audio_config = GetAudioConfigFromFile (audio_files[i]);
        const result = await new Promise ((resolve, reject) => {
            client.enrollProfileAsync (profile, audio_config, result => { resolve(result); }, error => { reject(error); });
        });
        if (result.reason === sdk.ResultReason.Canceled) {
            throw(JSON.stringify(sdk.VoiceProfileEnrollmentCancellationDetails.fromResult(result)));
        }
        else {
            console.log ("Remaining audio time needed: " + (result.privDetails["remainingEnrollmentsSpeechLength"] / ticks_per_second) + " seconds.");
        }
    }
    console.log ("Enrollment completed.\n");
}

async function SpeakerVerify(profile, recognizer)
{
    const model = sdk.SpeakerVerificationModel.fromProfile(profile);
    const result = await new Promise ((resolve, reject) => {
        recognizer.recognizeOnceAsync (model, result => { resolve(result); }, error => { reject(error); });
    });
    console.log ("Verified voice profile for speaker: " + result.profileId + ". Score is: " + result.score + ".\n");
}

async function TextIndependentIdentification(client, speech_config)
{
    console.log ("Text Independent Identification:\n");
    var profile = null;
    try {
        // Create the profile.
        profile = await new Promise ((resolve, reject) => {
            client.createProfileAsync (sdk.VoiceProfileType.TextIndependentIdentification, profile_locale, result => { resolve(result); }, error => { reject(error); });
        });
        console.log ("Created profile ID: " + profile.profileId);
        await AddEnrollmentsToTextIndependentProfile(client, profile, [identify_file]);
        const audio_config = GetAudioConfigFromFile(passphrase_files[0]);
        const recognizer = new sdk.SpeakerRecognizer(speech_config, audio_config);
        await SpeakerIdentify(profile, recognizer);
    }
    catch (error) {
        console.log ("Error:\n" + error);
    }
    finally {
        if (profile !== null) {
            console.log ("Deleting profile ID: " + profile.profileId);
            await new Promise ((resolve, reject) => {
                client.deleteProfileAsync (profile, result => { resolve(result); }, error => { reject(error); });
            });
        }
    }
}

async function SpeakerIdentify(profile, recognizer)
{
    const model = sdk.SpeakerIdentificationModel.fromProfiles([profile]);
    const result = await new Promise ((resolve, reject) => {
        recognizer.recognizeOnceAsync (model, result => { resolve(result); }, error => { reject(error); });
    });
    console.log ("The most similar voice profile is: " + result.profileId + " with similarity score: " + result.score + ".\n");
}




// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.

function speachtotext() {
    // <code>
    "use strict";
    
    // pull in the required packages.
    var sdk = require("microsoft-cognitiveservices-speech-sdk");
    var fs = require("fs");
    
    // replace with your own subscription key,
    // service region (e.g., "westus"), and
    // the name of the file you want to run
    // through the speech recognizer.

    var filename = "sounds/aboutSpeechSdk.wav"; // 16000 Hz, Mono
    // var filename = "sounds/vampIntroTrevor.wav"; // 16000 Hz, Mono
    
    // create the push stream we need for the speech sdk.
var pushStream = sdk.AudioInputStream.createPushStream();

// open the file and push it to the push stream.
fs.createReadStream(filename).on('data', function(arrayBuffer) {
    pushStream.write(arrayBuffer.slice());
}).on('end', function() {
    pushStream.close();
});

// we are done with the setup
console.log("Now recognizing from: " + filename);

// now create the audio-config pointing to our stream and
// the speech config specifying the language.
var audioConfig = sdk.AudioConfig.fromStreamInput(pushStream);
var speechConfig = sdk.SpeechConfig.fromSubscription(subscription_key, region);

// setting the recognition language to English.
speechConfig.speechRecognitionLanguage = "en-US";

// create the speech recognizer.
var recognizer = new sdk.SpeechRecognizer(speechConfig, audioConfig);

// start the recognizer and wait for a result.
recognizer.recognizeOnceAsync(
    function (result) {
        console.log(result);

        recognizer.close();
        recognizer = undefined;
    },
    function (err) {
        console.trace("err - " + err);
        
        recognizer.close();
        recognizer = undefined;
    });
// </code>

};




function transcribe(voiceSignatureStringUser1, voiceSignatureStringUser2){
    var subscriptionKey = process.env.SPEECH_SUBSCRIPTION_KEY;
    var region2 = process.env.SPEECH_REGION;
    var filepath = "sounds/vampIntro2_8chan.wav"; // 8-channel audio

    // create the push stream and write file to it
    var pushStream = sdk.AudioInputStream.createPushStream();
    fs.createReadStream(filepath).on('data', function(arrayBuffer) {
        pushStream.write(arrayBuffer.slice());
    }).on('end', function() {
        pushStream.close();
    });

    var speechTranslationConfig = sdk.SpeechTranslationConfig.fromSubscription(subscriptionKey, region2);
    var audioConfig = sdk.AudioConfig.fromStreamInput(pushStream);
    speechTranslationConfig.speechRecognitionLanguage = "en-US";

    // create conversation and transcriber
    var conversation = sdk.Conversation.createConversationAsync(speechTranslationConfig, "myConversation");
    var transcriber = new sdk.ConversationTranscriber(audioConfig);

    // attach the transcriber to the conversation
    transcriber.joinConversationAsync(conversation,
    function () {
        // add first participant using voiceSignature created in enrollment step
        var user1 = sdk.Participant.From("user1@example.com", "en-us", voiceSignatureStringUser1);
        conversation.addParticipantAsync(user1,
        function () {
            // add second participant using voiceSignature created in enrollment step
            var user2 = sdk.Participant.From("user2@example.com", "en-us", voiceSignatureStringUser2);
            conversation.addParticipantAsync(user2,
            function () {
                transcriber.sessionStarted = function(s, e) {
                console.log("(sessionStarted)");
                };
                transcriber.sessionStopped = function(s, e) {
                console.log("(sessionStopped)");
                };
                transcriber.canceled = function(s, e) {
                console.log("(canceled)");
                };
                transcriber.transcribed = function(s, e) {
                console.log("(transcribed) text: " + e.result.text);
                console.log("(transcribed) speakerId: " + e.result.speakerId);
                };

                // begin conversation transcription
                transcriber.startTranscribingAsync(
                function () { },
                function (err) {
                    console.trace("err - starting transcription: " + err);
                });
        },
        function (err) {
            console.trace("err - adding user1: " + err);
        });
    },
    function (err) {
        console.trace("err - adding user2: " + err);
    });
    },
    function (err) {
    console.trace("err - " + err);
    });
}


async function main() {
 
// function main() {

    // const speech_config = sdk.SpeechConfig.fromSubscription(subscription_key, region);
    // const client = new sdk.VoiceProfileClient(speech_config);

   
    // await TextIndependentVerification(client, speech_config);
    // await TextIndependentIdentification(client, speech_config);
    // console.log ("End of recognition.");
    // console.log ("Rocket Elevator Speaker Recognition");
    // speachtotext()


    
    // var newProfile1 = await createProfile.createProfile("sounds/vampIntroTrevor.wav");
    // var newProfile2 = await createProfile.createProfile("sounds/final_testJoey.wav");

    newProfile1 = '{"Version":"0","Tag":"K7mZx5IfNYo0MmJV5WoxQp9i/bKwWsdGf8YH7rNNgdQ=","Data":"+blZ1e03y8aaUE9RpjkKBKlOEseeKaZPO8gHRSOmwwi4hGJfxLtFS8s0Dj7Na59Y8EUHxIb5g/je++ZdUx59yXOUjRiS9HSEjJ2Zhz1YlRq/QGyA99mWmHDpMFxlNS8IRk3ogfuzzkr2AYAxBuM3NUUmSu22NbE7vo4gOoITy7dg7e7WZqi5rZxOvZFA6iM8zW2B4DB3gTi90knN25wSjrTKL+TGO9Rynq0Vm/xpqYuzg/dobJ/rQN7uZYwWcQCZO3yV0U/55XbModkyo60i1U9c5hq9l8dNIfoQVNaOL/yyCuNy0MYuSN3aByFTtiWufrhMCoEBxlU2KE6MHU1vYsbI1paIj61Fcgea9/IBVffquI0uPdBU+PVDLdBJY75ymmYaj+kRKbzg7sCchUpXITOs44+wpklTGjjeZyL6NfoSl95zOPyhApXRhxxtq5mudIGod6JpibYxIkwrvZLSO5QiL0MCXQt01WorqWZ7aTFM3WzrVWEH2cbNV8c9Qd45C4V2A5Eb4O7qauM5uagFCVrR9Fce+/rgHKmDNYkkFPPSdD7tOGq30uf9V2IIf2MgOH7Tn2vykCiiJEs7BGGQM7WyPZBDkudd4IF8vGjX90uAMC7X4hEr/xtNaRoTf3L/QuQTVeij16S89Z01ZNrRLaEIsELiF+SOg/BzgmG24TcDH6JEPxz1ZabVa/zTcwdG"}';
    newProfile2 = '{"Version":"0","Tag":"uwjIjqLXnxpTonED5FW35FQOOBYIvvVdDNJRm06ikns=","Data":"tfHY7Lc4V6iHRUd1ziX4bcO6jmIaaHn/oiHcc0/vQtnOCcCicLDt1zlMf/5BL8Mb2DxY5HXhzbG11k/dLoBOfxRnxmqwcSZWrGzNFVjA/EV6ipvZQRjrfjUjbk3aRLu7UeSZ7Qb8upx4ny3nAhP2y+imc37nXgGM9d3i2WcA5s+02yrh67G8dVFw9OiwmmBjwyQM6iVcJbe7WY58K3HSM10vMWmor32sTvGwsrhzdqnO0Iyj6ovGvw/pus07yoQUYHren4fFMLvPygu7lzXtrs2nYarODniBg8i9HoDoG2qcv1hpfCU6GIDpu7eA/S+TuVIdY+INhctNb4mF0vJeKl6eVvIep4E1hs8lQ5Epyfwa7a2AeK/Oix/HoUIG79iaaBux/rjFIteg0xFIljXkQnKsleG0Byx4gIIJngP81pFMqxuLG/fquzlEaPAgtFBUPmjrGd3z75MDGyGio9iytHj53TOqCrYfv/vFwo5/tKwvzjqOvvDv1g0pexUkOml9Gb4C6KDoGO2KG/rPBuFWYFKSIv5oZpsQv6il96Vm3sn2LYGxvAh/MaWss7Pckb9/3UyVINH3Thmi9fjXlujlewMevPvf++YWrZvFeebTYBvqQqo9X1hp4q+envysCckjwR7kECtZuDgZE96T8tsww3Oc9vkfrSR457RrwFFY0xb9wTi4ycwfF5Zj1Prw3JFO"}'

    console.log (newProfile1);
    console.log ("________________________________________________________________________");
    console.log (newProfile2);
    console.log (newProfile1)
    transcribe(newProfile1, newProfile2);


}


main();