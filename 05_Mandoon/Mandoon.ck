<<< "Zhe Zhang" >>>;
// In this work, I used a mandolin with a feedback delay
// a bell with echo effect and a moog with a chorus
// Musically it is based on Dorian scale for a sentimental air
// and the bell rings at random time point for a loosen feeling

// patch
Mandolin mdl => DelayL dly => Gain mandogain => Pan2 pan => dac;
dly => LPF fblp => Delay dlyfd => Gain fdb => dly;

// mandolin line parameters
.8 => mdl.stringDetune;
88::ms => dly.delay => dly.max;
.6 => mandogain.gain;

// feedback parameters
.618 => fdb.gain;
800 => fblp.freq;
1.5 => fblp.Q;
4095::samp => dlyfd.delay => dlyfd.max;

// bell route
SndBuf bell => Echo eco => Gain bellgain => dac;
me.dir(-1) + "/audio/cowbell_01.wav" => bell.read;
bell.samples() => bell.pos;
.8 => eco.mix;
.2 => bellgain.gain;

//scale
[62, 64, 65, 67, 69, 71, 72, 72, 72, 74] @=> int melodyscale[];
[28, 23, 35, 48] @=> int padscale[];

// moog route
Moog moog => Chorus chor => Gain mooggain => dac;

// function for moog
fun void pad( int scale[] ){
    Std.mtof( scale[Math.random2( 0, scale.cap()-1 )] ) => moog.freq;
    Math.random2f(.2, .3) => moog.filterQ;
    Math.random2f(.1, .2) => moog.filterSweepRate;
    Math.random2f(22, 42) => moog.vibratoFreq;
    Math.random2f(.2, .4) => moog.vibratoGain;
    Math.random2f(0.3, 0.6) => moog.afterTouch;
    Math.random2f(0.4, 0.6) => moog.noteOn;
}

// timing
.99::second => dur beat;

// counter
0 => int count;

// infinite loop
8 => int loop;
for(0 => int l; l < loop * 6; l++){
    // a sequencer
    count%8 => int temp;
    // random choose a note
    Math.random2( 0, melodyscale.cap()-1 ) => int chosen;
    Std.mtof( melodyscale[chosen] ) => mdl.freq;
    // set the string of the mandolin in front of your head
    -0.5 + (chosen+1)/melodyscale.cap() => pan.pan;
    // play
    Math.random2f(.2, .7) => mdl.pluckPos;
    Math.random2f(.2, .7) => mdl.noteOn;
    // randomly rings the bell
    if(maybe) 0 => bell.pos;
    // moog on and off
    if( temp == 2 ) pad( padscale );
    if( temp == 7 ) Math.random2f(0.2, 0.8) => moog.noteOff;
    // make the rhythm neat while it can be changed by multiplying a random number
    beat => now;
       
    count++;
}

//coda
0.7 => mdl.noteOn;
beat => now;

0.8 => mdl.noteOn;
beat => now;

0.9 => mdl.noteOn;
1 => moog.noteOff;
6*beat => now;