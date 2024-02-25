clear;
%%
% Beats per Minute (BPM)
bpm = 69;

% Sampling rate (in Hz)
sampling_rate = 44100;

% this is doing something but I don't understand
k = 60 / bpm;

% Create array of note frequencies for A1 to GSharp6
note = zeros(1, 84);
for i = 0:83
    note(i+1) = 27.5 * 2^(i/12); % A1 is the lowest note at 27.5 Hz
end

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
%%
% 1 beat 
t_oneBeat = 0:(1/sampling_rate):(k*4-(1/sampling_rate));
% 1/2 beat
t_halfBeat = 0:(1/sampling_rate):((k*2)-(1/sampling_rate));
% 1/4 beat
t_quarterBeat = 0:(1/sampling_rate):((k)-(1/sampling_rate));
% 1/8 beat
t_eightBeat = 0:(1/sampling_rate):((k/2)-(1/sampling_rate));
% 6/8
t_sixeights = 0:1/sampling_rate:k*3-(1/sampling_rate);
%%
% an array of notes, 
song_halfNotes = [createNote(C4, t_halfBeat) + createNote(E4, t_halfBeat) + createNote(G4, t_halfBeat), createNote(C4, t_halfBeat) + createNote(E4, t_halfBeat) + createNote(A4, t_halfBeat)];

song_wholeNotes = [createNote(C3, t_oneBeat)];

song = song_wholeNotes + song_halfNotes;

soundsc(song,sampling_rate);

%%
function returnNote = createNote(note, timeVector)
    %Function to create a note for some time
    returnNote = cos(2 * pi * note * timeVector);
end