//mandolin.ck
BPM tempo;
SCALE player;

// patch
Mandolin mdl => DelayL dly => Gain mandogain => Pan2 pan => dac;
dly => LPF fblp => Delay dlyfd => Gain fdb => dly;

// mandolin line parameters
.22 => mdl.stringDetune;
88::ms => dly.delay => dly.max;
.6 => mandogain.gain;

// feedback parameters
.618 => fdb.gain;
800 => fblp.freq;
1.5 => fblp.Q;
4095::samp => dlyfd.delay => dlyfd.max;

// counter
0 => int count;

// infinite loop
while( true ){
    // a sequencer
    count%16 => int temp;
    //scale
    [SCALE.note1, SCALE.note2, SCALE.note3, SCALE.note4, 
    SCALE.note5, SCALE.note6, SCALE.note7, SCALE.note8] @=> int scale[];

    
    // random choose a note
    Math.random2( 0, scale.cap()-1 ) => int chosen;
    Std.mtof( scale[chosen] + 12 ) => mdl.freq;
    // set the string of the mandolin in front of your head
    -0.5 + (chosen+1)/scale.cap() => pan.pan;
    // play
    if( temp > 7 && temp < 13 ){
        
        Math.random2f(.2, .7) => mdl.pluckPos;
        Math.random2f(.2, .7) => mdl.noteOn;
    }

    tempo.sixteenthNote => now;
       
    count++;
}