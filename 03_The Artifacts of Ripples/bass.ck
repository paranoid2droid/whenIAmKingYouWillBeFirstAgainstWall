// bass.ck
// sound chain (mandolin for bass)
Mandolin bass => NRev r => dac;
BPM tempo;
SCALE player;

[SCALE.note1, SCALE.note2, SCALE.note3, SCALE.note4, 
 SCALE.note5, SCALE.note6, SCALE.note7, SCALE.note8] @=> int scale[];

// parameter setup
0.1 => r.mix;
0.0 => bass.stringDamping;
0.02 => bass.stringDetune;
0.2 => bass.bodySize;
.42 => bass.gain;

// loop
while( true )  
{
    Math.random2(0, 7) => int temp;
    Std.mtof(scale[temp] - 36) => bass.freq;
    <<< scale[temp] >>>;
    Math.random2f(0.05,0.5) => bass.pluckPos;
    1 => bass.noteOn;
    tempo.quarterNote => now;
    1 => bass.noteOff;
    tempo.quarterNote => now;
}


