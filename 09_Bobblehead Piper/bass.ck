// bass.ck
// sound chain (mandolin for bass)
Moog moog => Chorus chor => Gain mooggain => dac;
BPM tempo;
SCALE player;

// function for moog
fun void beam( int inputscale[] ){
    Std.mtof( inputscale[Math.random2( 0, inputscale.cap()-1 )] - 12) => moog.freq;
    Math.random2f(.2, .3) => moog.filterQ;
    Math.random2f(.1, .2) => moog.filterSweepRate;
    Math.random2f(22, 42) => moog.vibratoFreq;
    Math.random2f(.2, .4) => moog.vibratoGain;
    Math.random2f(0.3, 0.6) => moog.afterTouch;
    Math.random2f(0.4, 0.6) => moog.noteOn;
}

// counter
0 => int count;

// infinite loop
while( true ){
    // a sequencer
    count%8 => int temp;
    
    [SCALE.note1, SCALE.note2, SCALE.note3, SCALE.note4, 
    SCALE.note5, SCALE.note6, SCALE.note7, SCALE.note8] @=> int scale[];

    // moog on and off
    if( temp == 2 ) beam( scale );
    if( temp == 7 ) Math.random2f(0.2, 0.8) => moog.noteOff;
    // make the rhythm neat while it can be changed by multiplying a random number
    tempo.eighthNote => now;
       
    count++;
}
