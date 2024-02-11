% Shaan Yadav
% Fade Into You by Mazzy Star in Matlab

% --------------- SECTION 1 - Setup ------------------------

clear; % Clearing any leftovers in the workspace

% Setting the beat
bpm = 79;

% High-quality audio, standard CD sampling rate
sampling_rate = 44100;

% Calculating the duration of a beat in seconds
k = 60 / bpm;

% Prepping an array for musical notes from A1 to G#6
note = zeros(1, 84);
for i = 0:83
    note(i+1) = 27.5 * 2^(i / 12); % Starting from A1 at 27.5 Hz, going up by semitones
end

% Defining note variables for easy access later, maps frequencies to note names
% I've spelled out the notes for octaves 1 through 7 for clarity and easy reference

% Define variables for notes A1 to GSharp6
A1 = note(1);
Asharp1 = note(2);
B1 = note(3);
C1 = note(4);
Csharp1 = note(5);
D1 = note(6);
Dsharp1 = note(7);
E1 = note(8);
F1 = note(9);
Fsharp1 = note(10);
G1 = note(11);
Gsharp1 = note(12);

% Octave 2
A2 = note(13);
Asharp2 = note(14);
B2 = note(15);
C2 = note(16);
Csharp2 = note(17);
D2 = note(18);
Dsharp2 = note(19);
E2 = note(20);
F2 = note(21);
Fsharp2 = note(22);
G2 = note(23);
Gsharp2 = note(24);

% Octave 3
A3 = note(25);
Asharp3 = note(26);
B3 = note(27);
C3 = note(28);
Csharp3 = note(29);
D3 = note(30);
Dsharp3 = note(31);
E3 = note(32);
F3 = note(33);
Fsharp3 = note(34);
G3 = note(35);
Gsharp3 = note(36);

% Octave 4
A4 = note(37);
Asharp4 = note(38);
B4 = note(39);
C4 = note(40);
Csharp4 = note(41);
D4 = note(42);
Dsharp4 = note(43);
E4 = note(44);
F4 = note(45);
Fsharp4 = note(46);
G4 = note(47);
Gsharp4 = note(48);

% Octave 5
A5 = note(49);
Asharp5 = note(50);
B5 = note(51);
C5 = note(52);
Csharp5 = note(53);
D5 = note(54);
Dsharp5 = note(55);
E5 = note(56);
F5 = note(57);
Fsharp5 = note(58);
G5 = note(59);
Gsharp5 = note(60);

% Octave 6
A6 = note(61);
Asharp6 = note(62);
B6 = note(63);
C6 = note(64);
Csharp6 = note(65);
D6 = note(66);
Dsharp6 = note(67);
E6 = note(68);
F6 = note(69);
Fsharp6 = note(70);
G6 = note(71);
Gsharp6 = note(72);

% Octave 7
A7 = note(73);
Asharp7 = note(74);
B7 = note(75);
C7 = note(76);
Csharp7 = note(77);
D7 = note(78);
Dsharp7 = note(79);
E7 = note(80);
F7 = note(81);
Fsharp7 = note(82);
G7 = note(83);
Gsharp7 = note(84);

OneBarNote = cretinNote(0, 1);
FourBarNote = cretinNote(0, 4);

% ------------------- SECTION 2 - BassClef Definitions ----------------------------

% Building up the bass clef bar by bar
% I'm using custom functions to generate note sequences, plus I'm mixing different notes to create chords
% Some notes are silent (using cretinNote - it was too late to change the name to something else) to keep the rhythm without sound


bassClef_bar1_top =   [bassNote(E3, 3/16) + bassNote(Csharp3, 3/16) + bassNote(A2, 3/16)...
                       bassNote(E3, 1/16) + bassNote(Csharp3, 1/16) ...
                       bassNote(A2, 1/16)...
                       bassNote(E3, 1/16) + bassNote(Csharp3, 1/16)...
                       bassNote(E3, 3/16) + bassNote(Csharp3, 3/16)...
                       bassNote(E3, 1/16) + bassNote(Csharp3, 1/16) ...
                       bassNote(A2, 1/16)...
                       bassNote(E3, 1/16) + bassNote(Csharp3, 1/16)];

% This is because in the bass clef some notes are offset slightly
bassClef_bar1_bottom =   [cretinNote(0, 1/8)...
                          cretinNote(0, 1/8)...
                          cretinNote(0, 1/8)...
                          bassNote(A2, 1/8)...
                          bassNote(Gsharp2, 1/8)...
                          bassNote(Fsharp2, 1/8)];

bassClef_bar1 = pad(OneBarNote, bassClef_bar1_top) + pad(OneBarNote, bassClef_bar1_bottom);

bassClef_bar2_top =   [bassNote(E3, 3/16) + bassNote(B2, 3/16) + bassNote(Gsharp2, 3/16) + bassNote(E2, 3/16)...
                       bassNote(E3, 1/16) + bassNote(B2, 1/16) ...
                       bassNote(G2, 1/16)...
                       bassNote(E3, 1/16) + bassNote(B2, 1/16)...
                       bassNote(E3, 3/16) + bassNote(B2, 3/16) + bassNote(Gsharp2, 3/16)...
                       bassNote(E3, 1/16) + bassNote(B2, 1/16) ...
                       bassNote(G2, 1/16)...
                       bassNote(E3, 1/16) + bassNote(B2, 1/16)];

bassClef_bar2_bottom =   [cretinNote(0, 1/8)...
                          cretinNote(0, 1/8)...
                          cretinNote(0, 1/8)...
                          bassNote(E2, 1/8)...
                          bassNote(Fsharp2, 1/8)...
                          bassNote(Gsharp2, 1/8)];

bassClef_bar2 = pad(OneBarNote, bassClef_bar2_top) + pad(OneBarNote, bassClef_bar2_bottom);

bassClef_bar3_top =   [bassNote(Fsharp3, 3/16) + bassNote(D3, 3/16) + bassNote(B2, 3/16)...
                       bassNote(Fsharp3, 1/16) + bassNote(D3, 1/16) ...
                       bassNote(B2, 1/16)...
                       bassNote(Fsharp3, 1/16) + bassNote(D3, 1/16) ...
                       bassNote(Fsharp3, 3/16) + bassNote(D3, 3/16)...
                       bassNote(Fsharp3, 1/16) + bassNote(D3, 1/16) ...
                       cretinNote(0, 1/16)...
                       bassNote(Fsharp3, 1/16) + bassNote(D3, 1/16)];

bassClef_bar3_bottom =   [cretinNote(0, 1/8)...
                          cretinNote(0, 1/8)...
                          cretinNote(0, 1/8)...
                          bassNote(B2, 1/8)...
                          bassNote(B2, 1/8)...
                          bassNote(B2, 1/8)];

bassClef_bar3 = pad(OneBarNote, bassClef_bar3_top) + pad(OneBarNote, bassClef_bar3_bottom);


bassClef_bar4_top =   [bassNote(Fsharp3, 3/16) + bassNote(D3, 3/16) + bassNote(B2, 3/16)...
                       bassNote(Fsharp3, 1/16) + bassNote(D3, 1/16) ...
                       bassNote(B2, 1/16)...
                       bassNote(Fsharp3, 1/16) + bassNote(D3, 1/16) ...
                       bassNote(Fsharp3, 3/16) + bassNote(D3, 3/16) + bassNote(B2, 3/16)...
                       bassNote(Fsharp3, 1/16) + bassNote(D3, 1/16) ...
                       cretinNote(0, 1/16)...
                       bassNote(Fsharp3, 1/16) + bassNote(D3, 1/16)];

bassClef_bar4_bottom =   [cretinNote(0, 1/8)...
                          cretinNote(0, 1/8)...
                          cretinNote(0, 1/8)...
                          cretinNote(0, 1/8)...
                          bassNote(Csharp3, 1/8)...
                          bassNote(B2, 1/8)];

bassClef_bar4 = pad(OneBarNote, bassClef_bar4_top) + pad(OneBarNote, bassClef_bar4_bottom);


% 4 bars of my bassClef that repeat for song
bassClef_bar = pad(FourBarNote, [bassClef_bar1, bassClef_bar2, bassClef_bar3, bassClef_bar4]);


% -------------------- SECTION 4 - TrebleClef definitions ---------------------


% the melody with the treble clef
% Using createNote for actual sounds and cretinNote for pauses or silent beats

treble1 = pad(FourBarNote,[cretinNote(0,6/8), cretinNote(0,6/8), cretinNote(0,6/8), cretinNote(0,6/8)]);

treble2 = pad(FourBarNote,[createNote(Csharp5,6/8), createNote(Gsharp4,6/8), createNote(Gsharp4,1/8), createNote(Fsharp4,5/8)]);

treble3 = pad(FourBarNote,[cretinNote(0, 1/2), cretinNote(0, 1/16), createNote(Csharp4, 1/16), createNote(B3, 1/16), createNote(A3, 1/16), createNote(B3, 5/16), createNote(A3, 1/16), createNote(B3, 1/4), createNote(Csharp4, 1/4), createNote(A3, 1/8), createNote(A3, 1/2), createNote(A4, 1/8), createNote(A4, 1/8), createNote(Csharp5, 1/8), createNote(Csharp5, 1/8), createNote(Csharp5, 1/8), createNote(B4, 1/8)]);

treble4 = pad(FourBarNote,[createNote(A4, 1/2), cretinNote(0, 1/16),  createNote(Csharp4, 1/16), createNote(B3, 1/16), createNote(A3, 1/16), createNote(B3, 5/16), createNote(A3, 1/16), createNote(B3, 1/8), createNote(Csharp4, 3/8), createNote(A3, 1/8), createNote(A3, 1/2), createNote(A4, 1/8), createNote(Csharp5, 1/8), createNote(Csharp5, 1/8), createNote(Csharp5, 1/8), createNote(B4, 1/8), createNote(A4, 1/8)]);

treble5 = pad(FourBarNote,[createNote(A4, 1/2), cretinNote(0, 1/16),  createNote(Csharp4, 1/16), createNote(B3, 1/16), createNote(A3, 1/16), createNote(B3, 5/16), createNote(A3, 1/16), createNote(B3, 1/8), createNote(Csharp4, 1/4), createNote(A3, 1/8), createNote(A3, 5/8), cretinNote(0, 6/8)]);

treble6 = pad(FourBarNote,[cretinNote(0, 0.8125), createNote(Csharp4, 1/16), createNote(B3, 1/16), createNote(A3, 1/16), createNote(B3, 5/16), createNote(A3, 1/16), createNote(B3, 1/8), createNote(Csharp4, 3/8), createNote(A3, 1/8), createNote(A3, 1/2), cretinNote(0, 6/8)]);

treble7 = treble6;

treble8 = treble6;



treble11 = pad(FourBarNote, [cretinNote(0,1/2), createNote(E4, 3/4) + createNote(E5, 3/4), createNote(D4, 3/8) + createNote(D5, 3/8), createNote(Csharp4, 1/8) + createNote(Csharp5, 1/8), createNote(A3, 3/8) + createNote(A4, 3/8), createNote(B3, 1/8) + createNote(D4, 1/8) + createNote(Fsharp4, 1/8) + createNote(B4, 1/8), createNote(B3, 1/8) + createNote(D4, 1/8) + createNote(Fsharp4, 1/8) + createNote(B4, 1/8), createNote(Csharp4, 1/8) + createNote(Fsharp4, 1/8) + createNote(Csharp5, 1/8), createNote(Csharp4, 1/8) + createNote(Fsharp4, 1/8) + createNote(Csharp5, 1/8), createNote(Csharp4, 1/8) + createNote(Fsharp4, 1/8) + createNote(Csharp5, 1/8), createNote(B3, 1/8) + createNote(D4, 1/8) + createNote(Fsharp4, 1/8) + createNote(B4, 1/8), createNote(A3, 1/8) + createNote(D4, 1/8) + createNote(Fsharp4, 1/8) + createNote(A4, 1/8)]);

treble12 = pad(FourBarNote, [createNote(A3, 1/2) + createNote(Csharp4, 1/2) + createNote(E4, 1/2) + createNote(A4, 1/2), createNote(E4, 3/4) + createNote(E5, 3/4), createNote(D4,1/8) + createNote(D5, 1/8), createNote(Csharp4, 7/16) + createNote(Csharp5, 7/16), createNote(A4, 1/16) + createNote(A3, 1/16), createNote(B3, 3/8) + createNote(B4, 3/8), cretinNote(0, 1/8), createNote(B3, 1/8) + createNote(D4, 1/8) + createNote(Fsharp4, 1/8) + createNote(B4, 1/8), createNote(B3, 1/8) + createNote(D4, 1/8) + createNote(Fsharp4, 1/8) + createNote(B4, 1/8), createNote(Csharp4, 1/8) + createNote(Fsharp4, 1/8) + createNote(Csharp5, 1/8), createNote(Csharp4, 1/8) + createNote(Fsharp4, 1/8) + createNote(Csharp5, 1/8), createNote(B3, 1/8) + createNote(D4, 1/8) + createNote(Fsharp4, 1/8) + createNote(B4, 1/8)]);

treble13 = pad(FourBarNote, [createNote(A3, 1/4) + createNote(Csharp4, 1/4) + createNote(E4, 1/4) + createNote(A4, 1/4), createNote(E4, 3/4) + createNote(E5, 3/4), createNote(D4, 3/8) + createNote(D5, 3/8), createNote(Csharp4, 1/8) + createNote(Csharp5, 1/8), createNote(A3, 1/2) + createNote(A4, 1/2), cretinNote(0, 6/8)]);

treble14 = pad(FourBarNote, [cretinNote(0, 9/16), createNote(A3, 1/16), createNote(A3, 1/16), createNote(A3, 1/16), createNote(B3, 1/2) + createNote(Gsharp4, 1/2), createNote(Gsharp3, 1/8), createNote(Gsharp3, 1/8), createNote(Gsharp3, 1/8) + createNote(Gsharp4, 1/8), createNote(Fsharp4, 1/2) + pad(createNote(Fsharp4, 1/2), [createNote(Gsharp3, 1/8), createNote(Gsharp3, 1/16), createNote(A3, 1/16), createNote(A3, 1/4)]), createNote(A3, 1/8), createNote(B4, 1/8), createNote(Gsharp4, 1/8), createNote(Fsharp4, 1/2), cretinNote(0, 1/8)]);

treble15 = pad(FourBarNote, [createNote(Csharp5, 6/8), createNote(E5, 6/8), createNote(E5, 1/8), createNote(Fsharp5, 1/2), cretinNote(0, 7/8)]);

trebleClef = [treble1, treble2, treble3, treble4, treble5 ...
              treble6, treble7, treble8 ...
              treble11, treble12, treble13, treble14 ...
              treble15];

testClef = [treble1, treble2, treble3];


% -------------------- SECTION 5 - playing/saving the song ---------------------

% Combining bass and treble to form the final song

finalSong = (repeatAppend(bassClef_bar, 13)) + trebleClef;
% % 
% soundsc(finalSong, sampling_rate);

finalNorm = finalSong / max(abs(finalSong));

filename = 'ShaanFadeIntoYou.wav';
audiowrite (filename , finalNorm , sampling_rate);

plot(finalNorm); % Visual inspection of the normalized signal
title('Normalized Audio Signal');
xlabel('Sample Number');
ylabel('Amplitude');

% -------------------- SECTION 6 - function definitions ---------------------
% Below are the custom functions used to piece together the song

function n = cretinNote (note, dur)
    % Silent note creator
    fs = 44100; % Sampling frequency
    bpm2 = 79; % Same BPM as above
    n = 0 * [0 : 1/fs : 4*dur*60/bpm2-1/fs]; % Generates a silent "note" of specified duration
end

function n = createNote(note, dur)
    % Note generator
    % It takes a frequency (note) and duration, then crafts a fading note
    fs = 44100; % Freq
    bpm2 = 79; % BPM
    % Combining cosines for a natural sound and adding fades for realism
    freq = note;
    time_vec = [0 : 1/fs : 4*dur*60/bpm2-1/fs]; % time vector creation

    % Define the attack, sustain, and decay times
    attackTime = 0.02 * dur; % Attack time in seconds
    sustainTime = dur * 0.5; % Sustain time in seconds, adjust as needed
    decayTime = dur - attackTime - sustainTime; % Remaining time is decay time
    
    % Calculate the number of samples for each envelope segment
    attackSamples = round(attackTime * fs);
    sustainSamples = round(sustainTime * fs);
    decaySamples = length(time_vec) - attackSamples - sustainSamples;
    
    % Make sure that we have a valid number of decay samples
    decaySamples = max(decaySamples, 0);
    
    % Create the attack envelope
    attackEnvelope = linspace(0, 1, attackSamples);
    
    % Create the sustain envelope
    sustainEnvelope = ones(1, sustainSamples);
    
    % Create the decay envelope
    decayEnvelope = linspace(1, 0, decaySamples);
    
    % Combine the attack, sustain, and decay envelopes to create the full envelope
    fullEnvelope = [attackEnvelope, sustainEnvelope, decayEnvelope];
    
    % Ensure the full envelope is not longer than time_vec
    fullEnvelope = fullEnvelope(1:min(end, length(time_vec)));


    % Layering different frequencies, harmonics with different delays and
    % decays
    n = 0.5 * exp(time_vec * (-1/dur)) .* cos (2 * pi * freq * time_vec); % Main note
    n = n + 0.15 * exp(time_vec * (1/3) * (-1/dur) ) .* cos (2 * (1/2) * pi * freq * time_vec); % First overtone
    n = n + 0.35 * exp(time_vec * 3 * (-1/dur)) .* cos (2 * 2 * pi * freq * time_vec); % Second overtone

    n = fullEnvelope .* n;

    % n = cretinNote(note, dur);
    % n = n/max(n); % lessening volume
end


function n = bassNote(note, dur)
    % Similar to createNote but tuned for bass frequencies
    fs = 44100; 
    bpm2 = 79;
    freq = note;
    time_vec = [0 : 1/fs : 4*dur*60/bpm2-1/fs]; % time vector creation
    % Focused on lower overtones for bass

    % attackTime = 0.4 * dur; % Attack time in seconds, adjust as needed for smoothness
    % 
    % % Attack envelope
    % attackSamples = round(attackTime * fs); % Number of samples over the attack time
    % attackEnvelope = linspace(0, 0.5, attackSamples); % Linear increase from 0 to 1
    % 
    % % Full envelope with attack and decay
    % fullEnvelope = [attackEnvelope, ones(1, length(time_vec) - attackSamples)];
    % 
    % % Ensure the envelope is not longer than the note
    % fullEnvelope = fullEnvelope(1:length(time_vec));

    % Define the attack, sustain, and decay times
    attackTime = 0.02 * dur; % Attack time in seconds
    sustainTime = dur * 0.5; % Sustain time in seconds, adjust as needed
    decayTime = dur - attackTime - sustainTime; % Remaining time is decay time
    
    % Calculate the number of samples for each envelope segment
    attackSamples = round(attackTime * fs);
    sustainSamples = round(sustainTime * fs);
    decaySamples = length(time_vec) - attackSamples - sustainSamples;
    
    % Make sure that we have a valid number of decay samples
    decaySamples = max(decaySamples, 0);
    
    % Create the attack envelope
    attackEnvelope = linspace(0, 1, attackSamples);
    
    % Create the sustain envelope
    sustainEnvelope = ones(1, sustainSamples);
    
    % Create the decay envelope
    decayEnvelope = linspace(1, 0, decaySamples);
    
    % Combine the attack, sustain, and decay envelopes to create the full envelope
    fullEnvelope = [attackEnvelope, sustainEnvelope, decayEnvelope];
    
    % Ensure the full envelope is not longer than time_vec
    fullEnvelope = fullEnvelope(1:min(end, length(time_vec)));

    n = 0.4 * exp(time_vec * (1/3) * (-1/dur)) .* cos (2 * pi * freq * time_vec); % Main bass note
    % n = fullEnvelope .* n;
    % n = n + 0.2 * exp(time_vec * (1/3) * (-1/dur)) .* cos (2 * 2 * pi * freq * time_vec-0.2); % Higher freq
    n = n + 0.2 * exp(time_vec * (1/3) * (-1/dur)) .*  cos (2 * 2 * pi * freq * time_vec-0.2); % Higher freq
    n = fullEnvelope .* n;
    % n = (n/max(n)); 

end

function resultArray = repeatAppend(inputArray, n)
    % Loop an array for the background rhythm
    resultArray = inputArray; % Start with the initial input
    for i = 1:n-1
        resultArray = [resultArray, inputArray]; % Keep adding it to itself until specified
    end
end

function paddedArray = pad(array1, array2)
    % Ensures two parts of the song are the same length by adding silence to the shorter part
    if isrow(array1)
        paddedArray = [array2, zeros(1, length(array1) - length(array2))];
    else
        paddedArray = [array2; zeros(length(array1) - length(array2), 1)];
    end
end